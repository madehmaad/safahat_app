import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../resources/colors.dart';

class CustomizedTextFormField extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? label;
  final String? hint;
  final bool required;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final Widget? prefix;
  final Widget? postfix;
  final List<TextInputFormatter>? formatters;
  final bool obscureText;
  final bool editable;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final Function(String)? onTextChanged;
  final FocusNode? focusNode;
  final InputBorder? focusBorder;
  final InputBorder? unFocusBorder;
  final EdgeInsets? contentPadding;
  final Color? fillColor;
  final double? labelSize;
  final Color? labelColor;
  final int? minLines;
  final bool showLabel;
  final bool isPassword;
  final double textSize;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final double? labelSpacing;
  final FormState? formState;
  final TextAlign? textAlign;
  final bool autoSelectContent;
  final bool updateCursorAtTheEnd;

  const CustomizedTextFormField(
      {Key? key,
      this.validator,
      this.label,
      this.textInputAction,
      this.textInputType,
      required this.controller,
      this.hint,
      this.maxLength,
      this.prefix,
      this.postfix,
      this.required = true,
      this.obscureText = false,
      this.formatters,
      this.onEditingComplete,
      this.onTap,
      this.onTextChanged,
      this.focusNode,
      this.editable = true,
      this.showLabel = true,
      this.focusBorder,
      this.unFocusBorder,
      this.fillColor,
      this.labelSize = 16.0,
      this.labelColor = DesignColors.black,
      this.minLines = 1,
      this.isPassword = false,
      this.textSize = 16.0,
      this.textStyle,
      this.labelStyle,
      this.labelSpacing = 4.0,
      this.contentPadding,
      this.formState,
      this.textAlign,
      this.autoSelectContent = false,
      this.updateCursorAtTheEnd = false})
      : super(key: key);

  @override
  State<CustomizedTextFormField> createState() =>
      _CustomizedTextFormFieldState();
}

class _CustomizedTextFormFieldState extends State<CustomizedTextFormField> {
  late final GlobalKey<FormFieldState> _field;

  final _unFocusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: DesignColors.primary),
      borderRadius: BorderRadius.circular(50.0));
  final _focusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: DesignColors.primary),
      borderRadius: BorderRadius.circular(50.0));
  final _hintStyle = const TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w400, color: DesignColors.gray1);
  final _textStyle = const TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w400, color: DesignColors.black);
  final _errorStyle = const TextStyle(
    color: DesignColors.red,
    fontSize: 10.0,
    height: 1,
  );
  late bool _hidePassword;

  @override
  void initState() {
    super.initState();
    _hidePassword = true;
    _field = GlobalKey<FormFieldState>();
  }

  @override
  Widget build(BuildContext context) {
    //TO SET THE CURSOR AT THE END
    if (widget.updateCursorAtTheEnd) {
      //widget.controller.selection = TextSelection.collapsed(offset: widget.controller.text.length);
      widget.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: widget.controller.text.length));
    }
    return AbsorbPointer(
      absorbing: !widget.editable,
      child: TextFormField(
        key: _field,
        onTap: widget.autoSelectContent
            ? () => widget.controller.selection = TextSelection(
                baseOffset: 0,
                extentOffset: widget.controller.value.text.length)
            : () {
                if (widget.onTap == null) {
                } else {
                  widget.onTap!();
                }
              },
        maxLength: widget.maxLength ?? 1000,
        focusNode: widget.focusNode,
        minLines: widget.minLines,
        maxLines: widget.minLines,
        textAlign: widget.textAlign ?? TextAlign.start,
        decoration: InputDecoration(
          counterText: "",
          labelText: widget.label,
          labelStyle: widget.labelStyle,
          fillColor: widget.fillColor ?? Colors.white,
          filled: true,
          hintText: widget.hint,
          hintStyle: _hintStyle,
          errorStyle: _errorStyle,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          // border: widget.unFocusBorder ?? _unFocusedBorder,
          enabledBorder: widget.unFocusBorder ?? _unFocusedBorder,
          focusedBorder: widget.focusBorder ?? _focusedBorder,
          prefixIcon: widget.prefix,
          suffixIcon: widget.postfix,
        ),
        cursorColor: DesignColors.primary,
        obscureText: widget.isPassword ? _hidePassword : widget.obscureText,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        controller: widget.controller,
        onChanged: widget.onTextChanged ??
            (val) {
              if (widget.formState != null) {
                widget.formState!.validate();
              }
            },
        onEditingComplete: widget.onEditingComplete,
        keyboardType: widget.textInputType,
        inputFormatters: widget.formatters,
        onFieldSubmitted: (val) {
          if (_field.currentState?.hasError ?? false) {
            Form.of(context).validate();
          }
        },
        onSaved: (val) {
          if (_field.currentState?.hasError ?? false) {
            Form.of(context).validate();
          }
        },
        validator: widget.validator ??
            (val) {
              if (!widget.required) return null;
              if (val?.isEmpty ?? true) return 'Field required';
              return null;
            },
        style: widget.textStyle ?? _textStyle,
      ),
    );
  }
}
