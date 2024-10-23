import 'package:dio/dio.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/controller/management_controller.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/seriese/seriese.dart';
import 'package:get/get.dart';

import '../../../../models/category/category.dart';
import '../../../../models/pagination_model/pagination_model.dart';
import '../../../../models/topic/topic.dart';

class SeriesViewModel extends GetxController with ManagementController {
  Dio dio = Dio();
  PaginationModel? series;
  int? selectedCategoryId;
  List<Topic>? topicList;
  Rx<Topic?> selectedTopic = Rx(null);
  List<Category>? subjectList;
  Rx<Category?> selectedSubject = Rx(null);
  RxString orderBy = 'DESC'.obs;
  int page = 1;
  bool statusSubject = false, statusTopic = false, statusSeries = false;

  @override
  bool get status => statusSeries && statusSubject && statusTopic;

  getAllData() async {
    reset();
    setMainLoading(true);
    if (selectedCategoryId != null) {
      await topics();
      await subjects();
    } else {
      await Future.wait<dynamic>([topics(), subjects(), getSeries()]);
    }
    setMainLoading(false);
  }

  getSeries({
    bool isPagination = false,
  }) async {
    // var response = await MaterialRepo.instance.getSeries(
    //   page: page,
    //   orderBy: orderBy.value,
    // topic: selectedTopic.value?.id.toString(),
    // type: selectedSubject.value?.id == null ? '' : selectedSubject.value?.id.toString(),
    // );
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'type': selectedSubject.value?.id == null
          ? ''
          : selectedSubject.value?.id.toString(),
      r'topic_id': selectedTopic.value?.id.toString(),
      r'order_by': orderBy.value,
    };
    queryParameters.removeWhere((k, v) => v == null);
    var temp = await dio.get(Env.baseUrl + Env.seriesesPaginate,
        queryParameters: queryParameters);
    final value = BaseResponse<PaginationModel<Seriese>>.fromJson(
      temp.data!,
      (json) => PaginationModel<Seriese>.fromJson(
        json as Map<String, dynamic>,
        (json) => Seriese.fromJson(json as Map<String, dynamic>),
      ),
    );
    var response = value;

    if (response.success) {
      if (isPagination) {
        series?.currentPage = response.data?.currentPage;
        series?.nextPageUrl = response.data?.nextPageUrl;
        series?.data.addAll(response.data!.data.toList());
      } else {
        series = response.data;
      }
      statusSeries = true;
    } else {
      statusSeries = false;
    }
  }

  getSeriesPagination() async {
    setPaginationLoading(true);
    page++;

    await getSeries(isPagination: true);
    setPaginationLoading(false);
  }

  subjects() async {
    // var response = await FilterRepo.instance.subjects();
    var temp = await dio.get(Env.baseUrl + Env.subjects);
    final value = BaseResponse<List<Category>>.fromJson(
      temp.data!,
      (json) => (json as List<dynamic>)
          .map<Category>((i) => Category.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    var response = value;
    if (response.success) {
      statusSubject = true;
      subjectList = response.data;
      subjectList?.insert(0, Category(title: 'الكل'));
      for (int i = 0; i < subjectList!.length; i++) {
        if (subjectList?[i].id == selectedCategoryId) {
          await changeSubject(subjectList![i]);
          break;
        }
      }
    } else {
      statusSubject = false;
      message = response.message;
    }
  }

  topics() async {
    // var response = await FilterRepo.instance.topics();
    var temp = await dio.get(Env.baseUrl + Env.topics);
    final value = BaseResponse<List<Topic>>.fromJson(
      temp.data!,
      (json) => (json as List<dynamic>)
          .map<Topic>((i) => Topic.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    var response = value;
    if (response.success) {
      print(temp.data);
      statusTopic = true;
      topicList = response.data;
      topicList?.insert(0, Topic(title: 'الكل'));
    } else {
      statusTopic = false;
      message = response.message;
    }
  }

  changeTopic(Topic topic) async {
    page = 1;
    Topic? previous = selectedTopic.value;
    selectedTopic.value = topic;
    setActionLoading(true);
    await getSeries();
    if (!statusSeries) {
      selectedTopic.value = previous;
    }
    setActionLoading(false);
  }

  changeSubject(Category subject) async {
    page = 1;
    Category? previous = selectedSubject.value;
    selectedSubject.value = subject;
    setActionLoading(true);
    await getSeries();
    if (!statusSeries) {
      selectedSubject.value = previous;
    }
    setActionLoading(false);
  }

  changeOrderBy() async {
    page = 1;
    String previous = orderBy.value;
    setActionLoading(true);
    if (orderBy.value == 'DESC') {
      orderBy.value = 'ASC';
    } else {
      orderBy.value = 'DESC';
    }
    await getSeries();
    if (!statusSeries) {
      orderBy.value = previous;
    }
    setActionLoading(false);
  }

  void reset() {
    selectedTopic.value = null;
    selectedSubject.value = null;
    orderBy.value = 'DESC';
  }
}
