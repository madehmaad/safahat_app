import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../buttons/customized_filled_button.dart';
import '../buttons/customized_outlined_button.dart';

class ConfirmDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final String confirmBtnText;
  final String? dismissBtnText;
  final double? height;
  final Function? confirmFunction;
  final Function? dismissFunction;
  final Widget? widget;
   const ConfirmDialog(
      {Key? key,
      this.title,
      this.confirmBtnText = 'Yes',
      this.dismissBtnText = 'No',
      this.message,
      this.height,
      this.confirmFunction,
      this.dismissFunction,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 41),
      backgroundColor: DesignColors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        height:height?? MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: DesignColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            if (message != null)
              Text(
                message!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: DesignColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            if (widget != null)
              const SizedBox(
                height: 14.0,
              ),
            if (widget != null) widget!,
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomizedFilledButton(
                  width: 100,
                  text: confirmBtnText,
                  function: () {
                    confirmFunction != null ? confirmFunction!.call() : Navigator.of(context).pop(true);
                  },
                ),
                if (dismissBtnText != null)
                  CustomizedOutlinedButton(
                    width: 100,
                    text: dismissBtnText!,
                    function: () {
                      dismissFunction != null ? dismissFunction!.call() : Navigator.of(context).pop(false);
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
