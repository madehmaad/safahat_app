import 'package:dio/dio.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/controller/management_controller.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/material/material.dart';
import 'package:get/get.dart';
import '../../../../models/category/category.dart';
import '../../../../models/topic/topic.dart';

class MaterialsViewModel extends GetxController with ManagementController {
  List<MaterialModel>? materials;
  Dio dio = Dio();
  int? selectedSeriesId;
  String? selectedSeriesName;
  String? selectedSeriesSlug;
  List<Topic>? topicList;
  Rx<Topic?> selectedTopic = Rx(null);
  List<Category>? subjectList;
  Rx<Category?> selectedSubject = Rx(null);
  RxString orderBy = 'DESC'.obs;
  int page = 1;
  bool statusSubject = false, statusTopic = false, statusMaterials = false;

  @override
  bool get status => statusMaterials && statusSubject && statusTopic;

  getAllData() async {
    page = 1;
    setMainLoading(true);
    await Future.wait<dynamic>([topics(), subjects(), getMaterials()]);

    setMainLoading(false);
  }

  getMaterials({bool isPagination = false}) async {
    var temp = await dio.get(
      Env.baseUrl + Env.material + '${selectedSeriesSlug}',
    );

    final value = BaseResponse<List<MaterialModel>>.fromJson(
      temp.data!,
      (json) => (json as List<dynamic>)
          .map<MaterialModel>(
              (i) => MaterialModel.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    var response = value;

    if (response.success) {
      materials = response.data;

      statusMaterials = true;
    } else {
      statusMaterials = false;
    }
  }

  getSeriesPagination() async {
    setPaginationLoading(true);
    page++;
    await getMaterials(isPagination: true);
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
    await getMaterials();
    if (!statusMaterials) {
      selectedTopic.value = previous;
    }
    setActionLoading(false);
  }

  changeSubject(Category subject) async {
    page = 1;
    Category? previous = selectedSubject.value;
    selectedSubject.value = subject;
    setActionLoading(true);
    await getMaterials();
    if (!statusMaterials) {
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
    await getMaterials();
    if (!status) {
      orderBy.value = previous;
    }
    setActionLoading(false);
  }
}
