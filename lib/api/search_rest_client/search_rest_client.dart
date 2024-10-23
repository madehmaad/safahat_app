import 'package:dio/dio.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/search/search.dart';
import 'package:retrofit/http.dart';

part 'search_rest_client.g.dart';

@RestApi()
abstract class SearchRestClient {
  factory SearchRestClient(Dio dio, {String baseUrl}) = _SearchRestClient;

  @GET(Env.search)
  Future<BaseResponse<Search>> search({
    @Query('search') String? query,
    @Query('topic') String? topic,
    @Query('type') String? type,
    @Query('questions') String? questions,
    @Query('attachment') String? attachment,
    @Query('from') String? from,
    @Query('to') String? to,
    @Query('page') required int page,
  });
}
