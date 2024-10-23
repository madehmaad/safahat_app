import 'package:dr_alshaal/controller/management_controller.dart';
import 'package:dr_alshaal/models/category/category.dart';
import 'package:dr_alshaal/models/search/search.dart';
import 'package:dr_alshaal/repository/search_repo.dart';
import 'package:get/get.dart';

import '../../../../models/topic/topic.dart';
import '../../../../repository/filter_repo.dart';

class SearchViewModel extends GetxController with ManagementController {
  Search? itemSearch;
  List<Topic>? topicList;
  Rx<Topic?> selectedTopic = Rx(null);
  List<Category>? subjectList;
  Rx<Category?> selectedSubject = Rx(null);
  List<String>? materialAttachmentList;
  Rx<String?> selectedAttachment = Rx(null);
  String? selectedDateFrom;
  String? selectedDateTo;
  String? query;
  int page = 1;
  bool statusSearch = false, statusSubject = false, statusTopic = false, statusAttachment = false;

  @override
  bool get status => statusSearch && statusSubject && statusTopic && statusAttachment;

  getAllData() async {
    selectedSubject.value = null;
    selectedAttachment.value = null;
    selectedTopic.value = null;
    setMainLoading(true);
    await Future.wait<dynamic>([topics(), subjects(), materialAttachment(), search()]);
    selectedSubject.value = subjectList![0];
    setMainLoading(false);
  }

  search({bool isPagination = false}) async {
    var response = await SearchRepo.instance.search(
      from: selectedDateFrom,
      to: selectedDateTo,
      topic: selectedTopic.value?.id.toString(),
      attachment: selectedAttachment.value == 'الكل' ? null : selectedAttachment.value,
      type: selectedSubject.value?.id.toString(),
      query: query,
      page: page,
    );
    if (response.success) {
      if (isPagination) {
        if (selectedSubject.value?.id == 'questions') {
          itemSearch?.questions?.addAll(response.data!.questions!.toList());
          itemSearch?.questionsHasNextPage = response.data!.questionsHasNextPage;
        } else {
          itemSearch?.list![0].materials?.addAll(response.data!.list![0].materials!.toList());
          itemSearch?.list![0].hasNextPage = response.data!.list![0].hasNextPage;
        }
      } else {
        statusSearch = true;
        itemSearch = response.data;
      }
    } else {
      statusSearch = false;
      message = response.message;
    }
  }

  subjects() async {
    var response = await FilterRepo.instance.subjects();
    if (response.success) {
      statusSubject = true;
      subjectList = response.data;
      subjectList?.insert(0, Category(title: 'الكل'));
      subjectList?.insert(1, Category(title: 'الأسئلة والأستشارات', id: 'questions'));
    } else {
      statusSubject = false;
      message = response.message;
    }
  }

  topics() async {
    var response = await FilterRepo.instance.topics();
    if (response.success) {
      statusTopic = true;
      topicList = response.data;
      topicList?.insert(0, Topic(title: 'الكل'));
    } else {
      statusTopic = false;
      message = response.message;
    }
  }

  materialAttachment() async {
    var response = await FilterRepo.instance.materialAttachments();
    if (response.success) {
      statusAttachment = true;
      materialAttachmentList = response.data;
      materialAttachmentList?.insert(0, 'الكل');
    } else {
      statusAttachment = false;
      message = response.message;
    }
  }

  changeQuery(String query) async {
    this.query = query;
    setActionLoading(true);
    await search();
    setActionLoading(false);
  }

  changeTopic(Topic topic) async {
    page = 1;
    Topic? previous = selectedTopic.value;
    selectedTopic.value = topic;
    setActionLoading(true);
    await search();
    if (!statusSearch) {
      selectedTopic.value = previous;
    }
    setActionLoading(false);
  }

  changeSubject(Category subject) async {
    page = 1;
    Category? previous = selectedSubject.value;
    selectedSubject.value = subject;
    setActionLoading(true);
    await search();
    if (!statusSearch) {
      selectedSubject.value = previous;
    }
    setActionLoading(false);
  }

  changeAttachment(String attachment) async {
    page = 1;
    String? previous = selectedAttachment.value;
    selectedAttachment.value = attachment;
    setActionLoading(true);
    await search();
    if (!statusSearch) {
      selectedAttachment.value = previous;
    }
    setActionLoading(false);
  }

  changeDateFrom(String? date) async {
    page = 1;
    selectedDateFrom = date;
    setActionLoading(true);
    await search();
    setActionLoading(false);
  }

  changeDateTo(String? date) async {
    page = 1;
    selectedDateTo = date;
    setActionLoading(true);
    await search();
    setActionLoading(false);
  }

  clearDate() async {
    page = 1;
    selectedDateTo = null;
    selectedDateFrom = null;
    setActionLoading(true);
    await search();
    setActionLoading(false);
  }

  int getIndexCategory(Category category) {
    return itemSearch!.list!.indexWhere((element) => element.id == category.id);
  }

  searchPagination(Category category) async {
    if (category.id == selectedSubject.value?.id) {
      setPaginationLoading(true);
      page++;
      await search(isPagination: true);
      setPaginationLoading(false);
    } else {
      await changeSubject(subjectList!.firstWhere((element) => element.id == category.id));
      setActionLoading(true);
      page++;
      await search(isPagination: true);
      setActionLoading(false);
    }
  }
}
