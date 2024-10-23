import 'package:dio/dio.dart';
import 'package:dr_alshaal/api/question_rest_client/question_rest_client.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/question_category/question_category.dart';
import 'package:dr_alshaal/repository/base_repository.dart';
import 'package:get/get.dart';

class QuestionRepo extends BaseRepository {
  static QuestionRepo? _instance;
  late final QuestionRestClient _questionRestClient;

  QuestionRepo._internal() {
    _questionRestClient = QuestionRestClient(Get.find<Dio>(), baseUrl: Env.baseUrl);
  }

  static QuestionRepo get instance => _instance ?? QuestionRepo._internal();

  Future<BaseResponse<List<QuestionCategory>>> getCategoryQuestion() async {
    return _questionRestClient.getCategoriesQuestion().onError((error, _) => catchError(error));
  }

  Future<BaseResponse<QuestionCategory>> getQuestions({required int id, int page = 1}) async {
    return _questionRestClient.getQuestions(id: id, page: page).onError((error, _) => catchError(error));
  }
}
