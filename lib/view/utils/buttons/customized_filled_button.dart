import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../widgets/loader.dart';

class CustomizedFilledButton extends StatelessWidget {
  final Color color;
  final Color fontColor;
  final String text;
  final double fontSize;
  final double? width;
  final Function function;
  final bool loading;
  final bool disabled;
  const CustomizedFilledButton(
      {Key? key,
      this.fontSize = 14.0,
      this.color = DesignColors.primary,
      this.fontColor = DesignColors.white,
      required this.text,
      required this.function,
      this.loading = false,
      this.width,
      this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return disabled
        ? Opacity(opacity: 0.48, child: button(context))
        : InkWell(
            onTap: () {
              function.call();
            },
            child: button(context));
  }

  button(context) {
    return Container(
      width: width ?? 150,
      padding: const EdgeInsets.symmetric(vertical: 11.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color, width: 2.0),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(),
            Text(
              text,
              style: TextStyle(
                color: fontColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
              ),
            ),
            loading ? const Loader() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
