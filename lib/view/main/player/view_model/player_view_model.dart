import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/controller/management_controller.dart';
import 'package:dr_alshaal/models/material/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../config/env.dart';

class PlayerViewModel extends GetxController with ManagementController {
  MaterialModel? materialModel;
  VideoPlayerController? controller;
  ChewieController? chewieController;
  RxBool mediaNotExist = false.obs;
  RxString imageUrl = ''.obs;
  String? url;

  addVideoUrl(String url) async {
    this.url = url;
    controller?.dispose();
    setMainLoading(true);
    controller = VideoPlayerController.network(Env.baseMediaUrl + url);
    try {
      await controller?.initialize();
      mediaNotExist.value = false;
      chewieController = ChewieController(
        allowedScreenSleep: false,
        allowFullScreen: true,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ],
        videoPlayerController: controller!,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        autoPlay: Get.find<AppController>().isAutoPlay.value,
        controlsSafeAreaMinimum: const EdgeInsets.symmetric(horizontal: 10),
        showControls: true,
        useRootNavigator: true,
      );
    } catch (error) {
      mediaNotExist.value = true;
    }
    setMainLoading(false);
  }

  addVideoFile(String path) async {
    controller?.dispose();
    setMainLoading(true);
    controller = VideoPlayerController.file(File(path));
    try {
      await controller?.initialize();
      mediaNotExist.value = false;
      chewieController = ChewieController(
        allowedScreenSleep: false,
        allowFullScreen: true,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ],
        videoPlayerController: controller!,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        autoPlay: Get.find<AppController>().isAutoPlay.value,
        controlsSafeAreaMinimum: const EdgeInsets.symmetric(horizontal: 10),
        showControls: true,
      );
    } catch (error) {
      mediaNotExist.value = true;
    }
    setMainLoading(false);
  }
}
