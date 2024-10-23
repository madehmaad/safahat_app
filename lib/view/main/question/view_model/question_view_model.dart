import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/controller/management_controller.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/question/question.dart';
import 'package:dr_alshaal/repository/question_repo.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../../models/question_category/question_category.dart';

class QuestionViewModel extends GetxService with ManagementController {
  Dio dio = Dio();
  List<QuestionCategory> categories = [];
  int? selectedId;
  QuestionCategory? questions;
  Question? selectedQuestion;
  bool statusQuestion = false;

  @override
  onInit() async {
    setMainLoading(true);
    await getCategories();
    setMainLoading(false);
    super.onInit();
  }

  getCategories() async {
    // var response = await QuestionRepo.instance.getCategoryQuestion();
    var temp = await dio.get(Env.baseUrl + Env.categories);
    final value = BaseResponse<List<QuestionCategory>>.fromJson(
      temp.data!,
      (json) => (json as List<dynamic>)
          .map<QuestionCategory>(
              (i) => QuestionCategory.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    var response = value;
    if (response.success) {
      status = true;
      categories = response.data!;
    } else {
      status = false;
      message = response.message;
    }
  }

  getQuestions({int page = 1}) async {
    // var response =
    //     await QuestionRepo.instance.getQuestions(id: selectedId!, page: page);
    final queryParameters = <String, dynamic>{r'page': page};
    var temp = await dio.get(
        Env.baseUrl + Env.categoriesPaginate + selectedId.toString(),
        queryParameters: queryParameters);
    final value = BaseResponse<QuestionCategory>.fromJson(
      temp.data!,
      (json) => QuestionCategory.fromJson(json as Map<String, dynamic>),
    );
    var response = value;
    if (response.success) {
      statusQuestion = true;
      if (page == 1) {
        questions = response.data;
      } else {
        questions?.questions?.nextPageUrl =
            response.data?.questions?.nextPageUrl;
        questions?.questions?.currentPage =
            response.data?.questions?.currentPage;
        questions?.questions?.data
            .addAll(response.data!.questions!.data.map((e) => e).toList());
      }
    } else {
      statusQuestion = false;
      message = response.message;
    }
  }

  getQuestionData() async {
    setActionLoading(true);
    questions = null;
    await getQuestions();
    setActionLoading(false);
  }

  getPaginationQuestions() async {
    setPaginationLoading(true);
    int page = questions!.questions!.currentPage!;
    page++;
    await getQuestions(page: page);
    setPaginationLoading(false);
  }
}
