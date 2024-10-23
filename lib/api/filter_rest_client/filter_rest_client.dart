import 'package:dio/dio.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/topic/topic.dart';
import 'package:retrofit/http.dart';

import '../../models/category/category.dart';

part 'filter_rest_client.g.dart';

@RestApi()
abstract class FilterRestClient {
  factory FilterRestClient(Dio dio, {String baseUrl}) = _FilterRestClient;

  @GET(Env.subjects)
  Future<BaseResponse<List<Category>>> subjects();
  @GET(Env.topics)
  Future<BaseResponse<List<Topic>>> topics();
  @GET(Env.materialsAttachments)
  Future<BaseResponse<List<String>>> materialAttachments();
}
