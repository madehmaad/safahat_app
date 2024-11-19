import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/controller/management_controller.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/live_stream/live_stream.dart';
import 'package:dr_alshaal/repository/home_repo.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveStreamViewModel extends GetxController with ManagementController {
  LiveStream? liveStream;
  Dio dio = Dio();
  late WebViewController facebookController;
  late WebViewController youtubeController;
  late WebViewController mixlerController;
  late bool isLive;

  @override
  onInit() async {
    setMainLoading(true);
    await getLiveStreamLink();
    if (status) {
      await Future.wait<dynamic>([loadFacebook(), loadYoutube(), loadMixler()]);
    }
    setMainLoading(false);
    super.onInit();
  }

  getLiveStreamLink() async {
    // var response = await HomeRepo.instance.getLiveStreamLinks();
    var temp = await dio.get(Env.baseUrl + Env.liveLinks);
    final value = BaseResponse<LiveStream>.fromJson(
      temp.data!,
      (json) => LiveStream.fromJson(json as Map<String, dynamic>),
    );
    var response = value;
    if (response.success) {
      status = true;
      liveStream = response.data;
    } else {
      status = false;
      message = response.message;
    }
  }

  loadFacebook() async {
    facebookController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(liveStream?.facebook?.iframLink));
  }

  loadYoutube() async {
    var response = await dio.get(Env.checkLiveYoutube);
    isLive = response.data['items'].length != 0;

    print(response.data['items'].length);

    youtubeController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(liveStream?.youtube?.iframLink));
    print(isLive);
  }

  loadMixler() async {
    mixlerController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(liveStream?.mixler?.iframLink));
  }
}
