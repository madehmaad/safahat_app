import 'package:dr_alshaal/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  const CustomAlertDialog({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(color: DesignColors.primary, fontSize: 20),
        textAlign: TextAlign.center,
      ),
      content:
          Text(content, style: const TextStyle(color: DesignColors.brown, fontSize: 18), textAlign: TextAlign.center),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            "نعم".tr,
            style: const TextStyle(color: DesignColors.gray2, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
