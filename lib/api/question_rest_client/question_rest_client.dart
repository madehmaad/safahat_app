import 'package:dio/dio.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/question_category/question_category.dart';
import 'package:retrofit/http.dart';

part 'question_rest_client.g.dart';

@RestApi()
abstract class QuestionRestClient {
  factory QuestionRestClient(Dio dio, {String baseUrl}) = _QuestionRestClient;

  @GET(Env.categories)
  Future<BaseResponse<List<QuestionCategory>>> getCategoriesQuestion();

  @GET("${Env.categoriesPaginate}{id}")
  Future<BaseResponse<QuestionCategory>> getQuestions({
    @Path('id') required int id,
    @Query('page') required int page,
  });
}
