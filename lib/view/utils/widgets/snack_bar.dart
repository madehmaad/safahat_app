import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/colors.dart';

SnackbarController errorSnackBar({required String message}) {
  return Get.snackbar('error'.tr, message,
      backgroundColor: DesignColors.red,
      icon: const Icon(
        Icons.warning_amber_outlined,
        color: DesignColors.white,
      ),
      borderRadius: 12,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      duration: const Duration(seconds: 1),
      isDismissible: true,
      snackPosition: SnackPosition.TOP,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeOut,
      colorText: DesignColors.white);
}

SnackbarController successSnackBar({String? message}) {
  return Get.rawSnackbar(
    message: message?.tr ?? "success".tr,
    backgroundColor: DesignColors.primary,
    icon: const Icon(
      Icons.check_circle,
      color: DesignColors.white,
    ),
    borderRadius: 12,
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    isDismissible: true,
    snackPosition: SnackPosition.TOP,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeOut,
  );
}
