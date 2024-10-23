import 'package:dio/dio.dart';
import 'package:dr_alshaal/api/search_rest_client/search_rest_client.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/search/search.dart';
import 'package:dr_alshaal/repository/base_repository.dart';
import 'package:get/get.dart';

class SearchRepo extends BaseRepository {
  static SearchRepo? _instance;
  late final SearchRestClient _searchRestClient;

  SearchRepo._internal() {
    _searchRestClient = SearchRestClient(Get.find<Dio>(), baseUrl: Env.baseUrl);
  }

  static SearchRepo get instance => _instance ?? SearchRepo._internal();

  Future<BaseResponse<Search>> search({
    required int page,
    String? query,
    String? attachment,
    String? from,
    String? questions,
    String? to,
    String? topic,
    String? type,
  }) async {
    return _searchRestClient
        .search(
            page: page,
            query: query,
            attachment: attachment,
            from: from,
            questions: questions ?? 'null',
            to: to,
            topic: topic,
            type: type ?? 'null')
        .onError((e, _) => catchError<Search>(e));
  }
}
