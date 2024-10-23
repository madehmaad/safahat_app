import 'package:dio/dio.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/controller/management_controller.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/lecture_schedule/lecture_schedule.dart';
import 'package:dr_alshaal/models/material/material.dart';
import 'package:dr_alshaal/models/pagination_model/pagination_model.dart';
import 'package:dr_alshaal/repository/home_repo.dart';
import 'package:get/get.dart';

import '../../../../models/home_models/home_type.dart';
import '../../../../models/home_models/home_type_material.dart';
import '../../../../models/mixler_lesson/mixler_lesson.dart';

class HomeViewModel extends GetxService with ManagementController {
  Dio dio = Dio();
  List<MixlerLesson>? mixlerLessons = [];
  List<LectureSchedule>? lectureSchedule = [];
  List<HomeType>? homeTypeList = [];
  PaginationModel? lastPostModel;
  List<HomeTypeMaterial>? homeTypeMaterial = [];
  int lastPostPage = 1;
  int selectedIndexType = 0;
  bool mixlerLessonStatus = false,
      lastPosStatus = false,
      lectureScheduleStatus = false;

  @override
  Future<void> onInit() async {
    setMainLoading(true);
    await Future.wait<dynamic>([
      getLastPosts(),
      getMixlerLessons(),
      getLectureSchedule(),
      getHomeTypes(),
    ]);
    setMainLoading(false);
    super.onInit();
  }

// !..................................................................
  getMixlerLessons() async {
    // var response = await HomeRepo.instance.getMixlerLessons();
    var temp = await dio.get(Env.baseUrl + Env.mixlerLessons);
    final value = BaseResponse<List<MixlerLesson>>.fromJson(
      temp.data!,
      (json) => (json as List<dynamic>)
          .map<MixlerLesson>(
              (i) => MixlerLesson.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    var response = value;
    if (response.success) {
      mixlerLessonStatus = true;
      mixlerLessons = [];
      mixlerLessons?.addAll(response.data!);
    } else {
      mixlerLessonStatus = false;
      message = response.message;
    }
  }

// !................................................................
  getLectureSchedule() async {
    // var response = await HomeRepo.instance.getLeactureSchedule();
    var temp = await dio.get(Env.baseUrl + Env.leactureSchedule);
    final value = BaseResponse<List<LectureSchedule>>.fromJson(
      temp.data!,
      (json) => (json as List<dynamic>)
          .map<LectureSchedule>(
              (i) => LectureSchedule.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    var response = value;

    if (response.success) {
      lectureScheduleStatus = true;
      lectureSchedule = [];
      lectureSchedule?.addAll(response.data!);
    } else {
      lectureScheduleStatus = false;
      message = response.message;
    }
  }

// !..................................................................
  getLastPosts() async {
    final queryParameters = <String, dynamic>{r'page': lastPostPage};
    var temp = await dio.get(Env.baseUrl + Env.getHomepageLatest,
        queryParameters: queryParameters);
    final value = BaseResponse<PaginationModel<MaterialModel>>.fromJson(
      temp.data!,
      (json) => PaginationModel<MaterialModel>.fromJson(
        json as Map<String, dynamic>,
        (json) => MaterialModel.fromJson(json as Map<String, dynamic>),
      ),
    );

    var response = value;

    if (response.success) {
      lastPosStatus = true;
      if (lastPostPage == 1) {
        lastPostModel = response.data;
      } else {
        lastPostModel?.data.addAll(response.data!.data.toList());
      }
    } else {
      lastPosStatus = false;
      message = response.message;
    }
  }

  getLastPostsPagination() async {
    setPaginationLoading(true);
    lastPostPage++;
    await getLastPosts();
    setPaginationLoading(false);
  }

// !..............................................................
  getHomeTypes() async {
    var temp = await dio.get(Env.baseUrl + Env.getHomeTypes);

    final value = BaseResponse<List<HomeType>>.fromJson(
      temp.data!,
      (json) => (json as List<dynamic>)
          .map<HomeType>((i) => HomeType.fromJson(i as Map<String, dynamic>))
          .toList(),
    );

    var response = value;

    if (response.success) {
      status = true;

      homeTypeList = response.data;
    } else {
      status = false;
      message = response.message;
    }
    if (status) {
      final results = await Future.wait(homeTypeList!.map((element) {
        return getHomeTypeMaterials(page: 1, typeId: element.id!);
      }));
      for (var response in results) {
        if (response != null) {
          homeTypeMaterial?.add(response);
        }
      }
    }
    if (homeTypeMaterial?.length != homeTypeList?.length) {
      status = false;
    }
  }

// !.................................................................
  Future<HomeTypeMaterial?> getHomeTypeMaterials(
      {required int page, required int typeId}) async {
    // var response = await HomeRepo.instance
    //     .getHomeTypeMaterials(page: page, typeId: typeId);
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'type_id': typeId,
    };
    var temp = await dio.get(Env.baseUrl + Env.getHomeTypeMaterials,
        queryParameters: queryParameters);

    final value = BaseResponse<HomeTypeMaterial>.fromJson(
      temp.data!,
      (json) => HomeTypeMaterial.fromJson(json as Map<String, dynamic>),
    );

    var response = value;
    if (response.success) {
      status = true;
      return response.data;
    } else {
      status = false;
      message = response.message;
    }
    return null;
  }

  getMaterialPagination({required int page, required int typeId}) async {
    selectedIndexType = typeId;
    setPaginationLoadingOne(true);
    var response = await getHomeTypeMaterials(page: page, typeId: typeId);
    if (response != null) {
      int index =
          homeTypeMaterial!.indexWhere((element) => element.type!.id == typeId);
      homeTypeMaterial![index]
          .materials!
          .data
          .addAll(response.materials!.data.toList());
      homeTypeMaterial![index].materials!.currentPage =
          response.materials!.currentPage;
      homeTypeMaterial![index].materials!.nextPageUrl =
          response.materials!.nextPageUrl;
    }
    setPaginationLoadingOne(false);
  }
}
