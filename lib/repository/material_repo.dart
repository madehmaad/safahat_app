import 'package:dio/dio.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/material/material.dart';
import 'package:dr_alshaal/models/pagination_model/pagination_model.dart';
import 'package:dr_alshaal/models/seriese/seriese.dart';
import 'package:dr_alshaal/repository/base_repository.dart';
import 'package:get/get.dart';

import '../api/material_rest_client/material_rest_client.dart';

class MaterialRepo extends BaseRepository {
  static MaterialRepo? _instance;
  late final MaterialRestClient _materialRestClient;

  MaterialRepo._internal() {
    _materialRestClient = MaterialRestClient(Get.find<Dio>(), baseUrl: Env.baseUrl);
  }

  static MaterialRepo get instance => _instance ?? MaterialRepo._internal();

  Future<BaseResponse<MaterialModel>> getMaterial({required String slug}) async {
    return _materialRestClient.getMaterial(slug: slug).onError((error, _) => catchError(error));
  }

  Future<BaseResponse<PaginationModel<Seriese>>> getSeries(
      {required int page, String? type, String? topic, String? orderBy}) async {
    return _materialRestClient
        .getSeries(page: page, type: type, topic: topic, orderBy: orderBy)
        .onError((error, _) => catchError(error));
  }

  Future<BaseResponse<PaginationModel<MaterialModel>>> getMaterials(
      {required int page, String? seriesId, String? orderBy, String? type, String? topic}) async {
    return _materialRestClient
        .getMaterials(
            page: page,
            seriesId: seriesId == 'null' ? null : seriesId,
            orderBy: orderBy,
            type: type == 'null' ? null : type,
            topic: topic == 'null' ? null : topic)
        .onError((error, _) => catchError(error));
  }
}
