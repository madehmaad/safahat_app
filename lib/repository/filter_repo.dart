import 'package:dio/dio.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/category/category.dart';
import 'package:dr_alshaal/models/topic/topic.dart';
import 'package:dr_alshaal/repository/base_repository.dart';
import 'package:get/get.dart';

import '../api/filter_rest_client/filter_rest_client.dart';

class FilterRepo extends BaseRepository {
  static FilterRepo? _instance;
  late final FilterRestClient _filterRestClient;

  FilterRepo._internal() {
    _filterRestClient = FilterRestClient(Get.find<Dio>(), baseUrl: Env.baseUrl);
  }

  static FilterRepo get instance => _instance ?? FilterRepo._internal();

  Future<BaseResponse<List<Category>>> subjects() async {
    return _filterRestClient.subjects().onError((error, _) => catchError(error));
  }

  Future<BaseResponse<List<Topic>>> topics() async {
    return _filterRestClient.topics().onError((error, _) => catchError(error));
  }

  Future<BaseResponse<List<String>>> materialAttachments() async {
    return _filterRestClient.materialAttachments().onError((error, _) => catchError(error));
  }
}
