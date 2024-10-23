import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../widgets/loader.dart';

class CustomizedOutlinedButton extends StatelessWidget {
  final Color? color;
  final Color? outlineColor;
  final String text;
  final double? fontSize;
  final Function function;
  final double? verticalPadding;
  final bool loading;
  final double? width;
  const CustomizedOutlinedButton({
    Key? key,
    this.fontSize = 14.0,
    this.color = DesignColors.white,
    this.outlineColor = DesignColors.gray1,
    required this.text,
    required this.function,
    this.verticalPadding,
    this.loading = false,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function.call();
      },
      child: Container(
        width: width ?? 150,
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 11.0),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: outlineColor!,
              width: 2.0,
            )),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(),
              Text(
                text,
                style: TextStyle(
                  color: outlineColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              loading ? Loader(color: outlineColor!) : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
