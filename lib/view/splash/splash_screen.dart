import 'dart:async';

import 'package:dr_alshaal/resources/assets_manager.dart';
import 'package:dr_alshaal/resources/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

import '../../service/notification/local_notification.dart';
import '../main/material/view_model/material_view_model.dart';
import '../main/player/view_model/player_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription? sub;

  getNotification() async {
    String? paylod = await LocalNotification().didNotificationLaunchApp();
    if (paylod != null) {
      // NotificationModel notificationModel = NotificationModel.fromJson(jsonDecode(paylod));
      Get.offNamed(AppRoutes.home);
      Get.toNamed(AppRoutes.notification);
    } else {
      Future.delayed(const Duration(seconds: 2), () async {
        Get.offNamed(AppRoutes.home);
        String? link = await getInitialLink();
        handleAppLink(link);
      });
    }
  }

  @override
  initState() {
    initUniLinks();
    getNotification();
    super.initState();
  }

  Future<void> initUniLinks() async {
    sub = linkStream.listen((String? link) {
      handleAppLink(link);
    }, onError: (err) {
      if (kDebugMode) {
        print(err);
      }
    });
  }

  handleAppLink(String? link) {
    if (link != null) {
      var uri = Uri.parse(link);
      String path = uri.path;
      if (path.contains('upload') || path.contains('serieses')) {
        String url = path.replaceFirst('https://www.dr-shaal.com/', '');
        PlayerViewModel controller = Get.put(PlayerViewModel());
        controller.addVideoUrl(url);
        Get.toNamed(AppRoutes.localPlayer);
      } else {
        String slug = path.substring(path.lastIndexOf('/') + 1);
        if (slug != '') {
          MaterialViewModel materialViewModel = Get.put(MaterialViewModel());
          materialViewModel.materialSlug = slug;
          materialViewModel.getAllData();
          Get.toNamed(AppRoutes.material);
        }
      }
    }
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          ImageAssets.splash,
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
