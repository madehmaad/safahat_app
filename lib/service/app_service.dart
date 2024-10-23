import 'dart:io';
import 'dart:ui';

import 'package:dr_alshaal/service/notification/notification_service.dart';
import 'package:dr_alshaal/view/utils/widgets/snack_bar.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/dio_configuration.dart';
import '../main.dart';
import '../view/main/download/collection/download_collection.dart';
import '../view/main/favorite/collection/favorite_collection.dart';

class AppService extends GetxService {
  Future<AppService> init() async {
    NotificationService.init();
    Get.put(await SharedPreferences.getInstance());
    httpClientConfig();
    await openDB();
    await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
    await FlutterDownloader.registerCallback(downloadCallback);
    HttpOverrides.global = MyHttpOverrides();
    return this;
  }

  static openDB() async {
    await Get.putAsync<Isar>(permanent: true, () async {
      final dir = await getApplicationSupportDirectory();
      final isar = await Isar.open(
        [FavoriteSchema, DownloadSchema],
        directory: dir.path,
        inspector: true,
        name: "al_shaal",
      );
      return isar;
    });
  }
}

@pragma('vm:entry-point')
void downloadCallback(String id, int status, int progress) {
  final send = IsolateNameServer.lookupPortByName('downloader_send_port');
  if (send == null) {
    errorSnackBar(message: 'حدذث خطأ');
  } else {
    send.send([id, status, progress]);
  }
}
