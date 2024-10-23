import 'package:dr_alshaal/view/main/download/widget/download_progress_card.dart';
import 'package:dr_alshaal/view/utils/widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/routes.dart';
import '../../../utils/widgets/divider.dart';
import '../../material/view_model/material_view_model.dart';
import '../view_model/download_view_model.dart';

class ProgressDownloadList extends StatelessWidget {
  ProgressDownloadList({Key? key}) : super(key: key);
  final DownloadViewModel downloadViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => downloadViewModel.tasks.isEmpty
        ? const EmptyScreen(
            title: 'لا يوجد مواد قيد التحميل حاليا',
          )
        : ListView.separated(
            itemCount: downloadViewModel.tasks.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) => thickDivider(verticalPadding: 10),
            itemBuilder: (context, index) => InkWell(
                onTap: () {
                  MaterialViewModel materialViewModel = Get.put(MaterialViewModel());
                  materialViewModel.materialSlug =
                      downloadViewModel.getRecordDataByTaskId(taskId: downloadViewModel.tasks[index].taskId)?.slug;
                  materialViewModel.getAllData();
                  Get.toNamed(AppRoutes.material);
                },
                child: DownloadProgressCard(downloadTask: downloadViewModel.tasks[index]))));
  }
}
