import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/resources/app_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/utils/dialogs/confirm_dialog.dart';

Future<bool> isConnect() async {
  return await InternetConnectionChecker().hasConnection;
}

void println(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

getDateLocal(String date) {
  return DateFormat("yyyy-MM-dd").format(DateTime.parse(date).toLocal());
}

getTimeLocal(String date) {
  return DateFormat("HH:mm:ss").format(DateTime.parse(date).toLocal());
}

getDateTimeLocal(String date) {
  return DateFormat("yyyy-MM-dd HH:mm:ss")
      .format(DateTime.parse(date).toLocal());
}

String convertDoubleToString(double value) {
  if (value.ceil() != value.floor()) {
    return value.toString();
  } else {
    return value.toStringAsFixed(0);
  }
}

double getFontSize() {
  return Get.find<SharedPreferences>()
          .getDouble(AppConst.fontSize)
          ?.toDouble() ??
      12.0;
}

setFontSize(double fontSize) {
  Get.find<SharedPreferences>().setDouble(AppConst.fontSize, fontSize);
}

bool getFullScreen() {
  return Get.find<SharedPreferences>().getBool(AppConst.fullScreen) ?? false;
}

setFullScreen(bool status) {
  Get.find<SharedPreferences>().setBool(AppConst.fullScreen, status);
}

changeAutoPlay(bool status) {
  Get.find<SharedPreferences>().setBool(AppConst.autoPlay, status);
}

bool getAutoPlayMedia() {
  return Get.find<SharedPreferences>().getBool(AppConst.autoPlay) ?? false;
}

Future<String> getDownloadDirectory() async {
  String? directory = await getDownloadPath();
  return Get.find<SharedPreferences>().getString(AppConst.downloadDirectory) ??
      '$directory';
}

changeDownloadDirectory(String path) {
  Get.find<SharedPreferences>().setString(AppConst.downloadDirectory, path);
}

setSettingsGide() {
  Get.find<SharedPreferences>().setBool(AppConst.settingGuid, true);
}

bool getSettingsGide() {
  return Get.find<SharedPreferences>().getBool(AppConst.settingGuid) ?? false;
}

setHomeGide() {
  Get.find<SharedPreferences>().setBool(AppConst.homeGuid, true);
}

bool getHomeGide() {
  return Get.find<SharedPreferences>().getBool(AppConst.homeGuid) ?? false;
}

changeSecondsToMinuteAndSecond(int timeInSecond) {
  int sec = timeInSecond % 60;
  int min = (timeInSecond / 60).floor();
  String minute = min.toString().length <= 1 ? "0$min" : "$min";
  String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
  return "$second : $minute";
}

String getAttachmentType(String file) {
  if (file == 'wmv' || file == 'mp4' || file == 'mkv' || file == 'wav') {
    return 'فيديو';
  } else if (file == 'mp3') {
    return 'صوت';
  } else if (file == 'jpg' ||
      file == 'png' ||
      file == 'gif' ||
      file == 'jpeg') {
    return 'صورة';
  } else if (file == 'pdf' || file == 'docx' || file == 'doc') {
    return 'نص';
  } else {
    return 'ملف';
  }
}

bool isTablet() {
  final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
  return data.size.width > 500;
}

convertFileSizeFromKbToMb(int size) {
  String x = ((size / 1024) / 1024).toStringAsFixed(2);
  return '$x ميغا';
}

Future<String?> getDownloadPath() async {
  Directory? directory;
  try {
    if (Platform.isIOS) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        await Get.dialog(ConfirmDialog(
          title: "طلب صلاحية",
          message: "يحتاج تطببيق الشعال الأذن لتنزيل الدروس والملفات إلى جهازك",
          confirmBtnText: "نعم",
          confirmFunction: () async {
            Get.back();
            await Permission.storage.request();
            await Permission.manageExternalStorage.request();
          },
          dismissBtnText: "لا",
        ));
      }
      directory = await getApplicationDocumentsDirectory();
    } else {
      await Directory('/storage/emulated/0/Download/al_shaal')
          .create()
          .then((value) => directory = value);
      bool? s = await directory?.exists();
      if (directory == null || (s == null || s == false)) {
        final status = await Permission.storage.status;
        if (status != PermissionStatus.granted) {
          await Get.dialog(ConfirmDialog(
            title: "طلب صلاحية",
            message:
                "يحتاج تطببيق الشعال الأذن لتنزيل الدروس والملفات إلى جهازك",
            confirmBtnText: "نعم",
            confirmFunction: () async {
              Get.back();
              await Permission.storage.request();
              await Permission.manageExternalStorage.request();
            },
            dismissBtnText: "لا",
          ));
        }
        directory = await getExternalStorageDirectory() ??
            await getTemporaryDirectory();
      }
    }
  } catch (err, _) {
    print("Cannot get download folder path");
  }

  return directory?.path;
}

Future<String> getAndroidVersion() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  return androidInfo.version.release;
}

Future<bool> checkPermission() async {
  var version = await getAndroidVersion();
  int androidVersion = num.parse(version).toInt();
  if (Platform.isAndroid && androidVersion < 11) {
    PermissionStatus status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      await Get.dialog(ConfirmDialog(
        title: "طلب صلاحية",
        message: "يحتاج تطببيق الشعال الأذن لتنزيل الدروس والملفات إلى جهازك",
        confirmBtnText: "نعم",
        confirmFunction: () async {
          await Permission.storage.request();
          Get.back();
        },
        dismissBtnText: "لا",
      ));
      status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
  }
  return true;
}

Future<void> prepareSaveDir() async {
  final savedDir =
      Directory(Get.find<AppController>().selectedDownloadDirectory.value);
  bool hasExisted = await savedDir.exists();
  if (!hasExisted) {
    savedDir.create();
  }
}
