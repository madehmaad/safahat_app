import 'package:dio/dio.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/home_models/home_type.dart';
import 'package:dr_alshaal/models/live_stream/live_stream.dart';
import 'package:retrofit/http.dart';

import '../../models/home_models/home_type_material.dart';
import '../../models/lecture_schedule/lecture_schedule.dart';
import '../../models/material/material.dart';
import '../../models/mixler_lesson/mixler_lesson.dart';
import '../../models/notification/notification.dart';
import '../../models/pagination_model/pagination_model.dart';

part 'home_rest_client.g.dart';

@RestApi()
abstract class HomeRestClient {
  factory HomeRestClient(Dio dio, {String baseUrl}) = _HomeRestClient;

  @GET(Env.mixlerLessons)
  Future<BaseResponse<List<MixlerLesson>>> mixlerLessons();

  @GET(Env.leactureSchedule)
  Future<BaseResponse<List<LectureSchedule>>> leactureSchedule();

  @GET(Env.getHomepageLatest)
  Future<BaseResponse<PaginationModel<MaterialModel>>> getHomepageLatest(
      {@Query('page') required int page});

  @GET(Env.getHomeTypes)
  Future<BaseResponse<List<HomeType>>> getHomeTypes();

  @GET(Env.getHomeTypeMaterials)
  Future<BaseResponse<HomeTypeMaterial>> getHomeTypeMaterials(
      {@Query('page') required int page,
      @Query('type_id') required int typeId});

  @GET(Env.liveLinks)
  Future<BaseResponse<LiveStream>> getLiveStreamLinks();

  @GET(Env.getNotifications)
  Future<BaseResponse<PaginationModel<NotificationModel>>> getNotifications(
      {@Query('page') required int page});
}
