import 'package:dio/dio.dart';
import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/controller/management_controller.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';
import 'package:dr_alshaal/models/notification/notification.dart';
import 'package:dr_alshaal/models/pagination_model/pagination_model.dart';
import 'package:get/get.dart';

class NotificationViewModel extends GetxController with ManagementController {
  PaginationModel<NotificationModel>? notifications;
  Dio dio = Dio();
  NotificationModel? selectedNotification;
  @override
  onInit() async {
    setMainLoading(true);
    await getNotifications(1);
    setMainLoading(false);
    super.onInit();
  }

  getNotifications(int page) async {
    // var response = await HomeRepo.instance.getNotifications(page: page);
    final queryParameters = <String, dynamic>{r'page': page};
    var temp = await dio.get(Env.baseUrl + Env.getNotifications,
        queryParameters: queryParameters);
    final value = BaseResponse<PaginationModel<NotificationModel>>.fromJson(
      temp.data!,
      (json) => PaginationModel<NotificationModel>.fromJson(
        json as Map<String, dynamic>,
        (json) => NotificationModel.fromJson(json as Map<String, dynamic>),
      ),
    );
    var response = value;
    if (response.success) {
      status = true;
      if (page == 1) {
        notifications = response.data;
      } else {
        notifications?.currentPage = response.data?.currentPage;
        notifications?.nextPageUrl = response.data?.nextPageUrl;
        notifications?.data.addAll(response.data!.data.map((e) => e).toList());
      }
    } else {
      status = false;
      message = response.message;
    }
  }

  getNotificationsPagination() async {
    setPaginationLoading(true);
    int page = notifications!.currentPage!;
    page++;
    await getNotifications(page);
    setPaginationLoading(false);
  }
}
