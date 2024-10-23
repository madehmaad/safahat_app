import 'package:dio/dio.dart';
import 'package:dr_alshaal/api/home_rest_client/home_rest_client.dart';
import 'package:dr_alshaal/api/home_rest_client/home_rest_client.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/live_stream/live_stream.dart';
import 'package:dr_alshaal/models/mixler_lesson/mixler_lesson.dart';
import 'package:dr_alshaal/repository/base_repository.dart';
import 'package:get/get.dart';

import '../models/home_models/home_type.dart';
import '../models/home_models/home_type_material.dart';
import '../models/lecture_schedule/lecture_schedule.dart';
import '../models/notification/notification.dart';
import '../models/pagination_model/pagination_model.dart';

class HomeRepo extends BaseRepository {
  static HomeRepo? _instance;
  late final HomeRestClient _homeRestClient;

  HomeRepo._internal() {
    _homeRestClient = HomeRestClient(Get.find<Dio>(), baseUrl: Env.baseUrl);
  }

  static HomeRepo get instance => _instance ?? HomeRepo._internal();

  Future<BaseResponse<List<MixlerLesson>>> getMixlerLessons() async {
    return _homeRestClient
        .mixlerLessons()
        .onError((error, _) => catchError(error));
  }

  Future<BaseResponse<List<LectureSchedule>>> getLeactureSchedule() async {
    return _homeRestClient
        .leactureSchedule()
        .onError((error, _) => catchError(error));
  }

  Future<BaseResponse<PaginationModel>> getHomepageLatest(
      {required int page}) async {
    return _homeRestClient
        .getHomepageLatest(page: page)
        .onError((error, _) => catchError(error));
  }

  Future<BaseResponse<List<HomeType>>> getHomeTypes() async {
    return _homeRestClient
        .getHomeTypes()
        .onError((error, _) => catchError(error));
  }

  Future<BaseResponse<HomeTypeMaterial>> getHomeTypeMaterials(
      {required int page, required int typeId}) async {
    return _homeRestClient
        .getHomeTypeMaterials(page: page, typeId: typeId)
        .onError((error, _) => catchError(error));
  }

  Future<BaseResponse<LiveStream>> getLiveStreamLinks() async {
    return _homeRestClient
        .getLiveStreamLinks()
        .onError((error, _) => catchError(error));
  }

  Future<BaseResponse<PaginationModel<NotificationModel>>> getNotifications(
      {required int page}) async {
    return _homeRestClient
        .getNotifications(page: page)
        .onError((error, _) => catchError(error));
  }
}
