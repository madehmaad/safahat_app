import 'package:dr_alshaal/resources/routes.dart';
import 'package:dr_alshaal/view/main/notification/view_model/notification_view_model.dart';
import 'package:dr_alshaal/view/main/notification/widget/notification_card.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:dr_alshaal/view/utils/widgets/base_scaffold.dart';
import 'package:dr_alshaal/view/utils/widgets/empty_screen.dart';
import 'package:dr_alshaal/view/utils/widgets/error_screen.dart';
import 'package:dr_alshaal/view/utils/widgets/full_loader.dart';
import 'package:dr_alshaal/view/utils/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationViewModel notificationViewModel = Get.put(NotificationViewModel());
  final ScrollController scrollController = ScrollController();

  Future<void> pagination() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (notificationViewModel.notifications?.nextPageUrl != null) {
        notificationViewModel.getNotificationsPagination();
      }
    }
  }

  @override
  void initState() {
    scrollController.addListener(pagination);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: appBarCustom(
        title: 'notification'.tr,
        backIcon: true,
      ),
      body: Obx(
        () => notificationViewModel.getMainLoading
            ? const FullLoader()
            : !notificationViewModel.status
                ? ErrorScreen(refresh: () => notificationViewModel.onInit())
                : notificationViewModel.notifications!.data.isEmpty
                    ? const EmptyScreen(title: 'لا يوجد إشعارات لعرضها')
                    : Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Obx(
                          () => Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                    controller: scrollController,
                                    scrollDirection: Axis.vertical,
                                    separatorBuilder: (context, index) => const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Divider(height: 0, thickness: 1, color: DesignColors.gray2),
                                        ),
                                    itemCount: notificationViewModel.notifications?.data.length ?? 0,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          notificationViewModel.selectedNotification =
                                              notificationViewModel.notifications!.data[index];
                                          Get.toNamed(AppRoutes.notificationDetails);
                                        },
                                        child: NotificationCard(
                                            notification: notificationViewModel.notifications!.data[index]))),
                              ),
                              notificationViewModel.getPaginationLoading
                                  ? const SizedBox(
                                      height: 60,
                                      child: Loader(),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      ),
      ),
    );
  }
}
