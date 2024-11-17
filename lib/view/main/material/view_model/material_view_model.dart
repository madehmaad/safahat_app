import 'package:dio/dio.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/controller/management_controller.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/material/material.dart';
import 'package:dr_alshaal/repository/material_repo.dart';
import 'package:dr_alshaal/view/main/player/view_model/player_view_model.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MaterialViewModel extends GetxController with ManagementController {
  MaterialModel? materialModel;
  late YoutubePlayerController youtubePlayerController;
  Dio dio = Dio();
  String? materialSlug;
  RxDouble fontSize = 0.0.obs;
  RxBool showYoutube = true.obs;
  bool isFounded = true;

  getAllData() async {
    showYoutube.value = true;
    setMainLoading(true);
    fontSize.value = Get.find<AppController>().fontSize.value;
    await getMaterial();
    await initialYoutubeController();
    setMainLoading(false);
  }

  initialYoutubeController() {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(materialModel?.mainVideo ?? '') ?? '',
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: Get.find<AppController>().isAutoPlay.value,
      ),
    );
    // print(youtubePlayerController.initialVideoId);
  }

  getMaterial() async {
    try {
      print(Env.baseUrl + Env.materialDetails + materialSlug!);
      var temp =
          await dio.get(Env.baseUrl + Env.materialDetails + materialSlug!);
      // await MaterialRepo.instance.getMaterial(slug: materialSlug ?? '');

      print(temp.data);
      final value = BaseResponse<MaterialModel>.fromJson(
        temp.data!,
        (json) => MaterialModel.fromJson(json as Map<String, dynamic>),
      );
      var response = value;
      print(temp);
      if (response.success) {
        isFounded = true;
        status = true;
        materialModel = response.data;
      } else {
        status = false;
        message = response.message;
      }
    } catch (e) {
      isFounded = false;
      // message = response.message;
    }
  }

  increaseFontSize() {
    if (fontSize.value + 5.0 < 50) {
      fontSize.value += 5.0;
    }
  }

  decreaseFontSize() {
    if (fontSize.value - 5.0 > 5) {
      fontSize.value -= 5.0;
    }
  }
}
