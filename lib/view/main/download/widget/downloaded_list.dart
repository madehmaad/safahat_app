import 'package:dr_alshaal/view/main/download/widget/downloaded_card.dart';
import 'package:dr_alshaal/view/utils/widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;

import '../../../../config/functions.dart';
import '../../../../resources/colors.dart';
import '../../../../resources/routes.dart';
import '../../player/view_model/player_view_model.dart';
import '../view_model/download_view_model.dart';

class DownloadedList extends StatelessWidget {
  DownloadedList({Key? key}) : super(key: key);
  final DownloadViewModel downloadViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => downloadViewModel.downloads.isEmpty
          ? const EmptyScreen(
              title: 'لم يتم تحميل اي مواد سابقة لعرضها',
            )
          : ListView.separated(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Divider(height: 0, thickness: 1, color: DesignColors.gray2),
                  ),
              itemCount: downloadViewModel.downloads.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    if (getAttachmentType(downloadViewModel.downloads[index].prefix ?? '') == 'ملف') {
                      OpenFilex.open(
                          '${downloadViewModel.downloads[index].filePath}/${path.basename(downloadViewModel.downloads[index].url!)}');
                    } else {
                      PlayerViewModel controller = Get.put(PlayerViewModel());
                      controller.url =
                          downloadViewModel.downloads[index].url?.replaceAll('https://d.dr-shaal.com/', "");
                      controller.addVideoFile(
                          '${downloadViewModel.downloads[index].filePath}/${path.basename(downloadViewModel.downloads[index].url!)}');
                      Get.toNamed(AppRoutes.localPlayer);
                    }
                  },
                  child: Row(
                    children: [
                      if (downloadViewModel.isCheck.value)
                        Obx(
                          () => Checkbox(
                              checkColor: DesignColors.brown,
                              activeColor: DesignColors.primary,
                              value: downloadViewModel.checked[index].isCheck,
                              onChanged: (value) {
                                downloadViewModel.checked[index].isCheck = value!;
                                downloadViewModel.checked.refresh();
                              }),
                        ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: DownloadedCard(
                        download: downloadViewModel.downloads[index],
                      )),
                    ],
                  ))),
    );
  }
}
