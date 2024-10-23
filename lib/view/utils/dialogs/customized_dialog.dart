import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../widgets/full_loader.dart';

class CustomizedDialog extends StatelessWidget {
  final List<Widget>? widgets;
  final Widget? widget;
  final bool loading;
  final double verticalPadding;
  final double horizontalPadding;
  final double heightPCT;
  final double widthPCT;
  final double borderRadius;
  final Color dialogBackgroundColor;
  final bool showCloseButton;
  final bool scrollable;
  const CustomizedDialog(
      {Key? key,
      this.widgets,
      this.widget,
      this.loading = false,
      required this.heightPCT,
      required this.widthPCT,
      required this.verticalPadding,
      required this.horizontalPadding,
      this.borderRadius = 15.0,
      this.dialogBackgroundColor = DesignColors.white,
      this.showCloseButton = false,
      this.scrollable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: dialogBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      contentPadding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      content: Stack(
        children: [
          SizedBox(
            height: heightPCT,
            width: widthPCT,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widgets!,
              ),
            ),
          ),
          loading
              ? const Center(
                  child: FullLoader(),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

customizedShowDialog({required BuildContext context, required Widget dialog, bool barrierDismissible = false}) {
  showDialog(
    context: context,
    useSafeArea: false,
    barrierColor: Colors.black.withOpacity(0.5), // Background color
    barrierDismissible: barrierDismissible,
    builder: (context) => dialog,
  );
}
