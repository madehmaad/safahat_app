import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/view/main/download/view_model/download_view_model.dart';
import 'package:dr_alshaal/view/main/player/view_model/player_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../config/env.dart';
import '../../../../config/functions.dart';
import '../../../../models/attachment/attachment.dart';
import '../../../../resources/colors.dart';
import '../../../../resources/routes.dart';
import '../../../utils/dialogs/alert _dialog.dart';
import '../../../utils/widgets/snack_bar.dart';
import '../../document_viewer/view_model/document_viewer_view_model.dart';
import '../../download/collection/download_collection.dart';

buildTitleWidget({required String title, double? width}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Container(
        width: width ?? 100,
        height: 30,
        decoration: BoxDecoration(
            color: DesignColors.primary,
            borderRadius: BorderRadius.circular(50)),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(color: DesignColors.white, fontSize: 16),
        ))),
  );
}

buildContentRow(Attachment attachment) {
  DownloadViewModel downloadViewModel = Get.find();
  AppController appController = Get.find();
  PlayerViewModel playerViewModel = Get.find();
  return Column(
    children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: SizedBox(
              width: 120,
              height: 50,
              child: Row(children: [
                IconButton(
                    onPressed: () async {
                      if (downloadViewModel.canDownload(
                          attachment.title, attachment.type)) {
                        bool status = await checkPermission();
                        if (status) {
                          await prepareSaveDir();
                          String? taskId = await FlutterDownloader.enqueue(
                            url: Env.baseMediaUrl + attachment.path,
                            headers: {},
                            savedDir:
                                appController.selectedDownloadDirectory.value,
                            saveInPublicStorage: false,
                            // saveInPublicStorage: (appController.selectedDownloadDirectory.value == '' ||
                            //         appController.selectedDownloadDirectory.value == "null")
                            //     ? true
                            //     : false,
                            requiresStorageNotLow: false,
                            showNotification: true,
                            openFileFromNotification: false,
                            allowCellular: true,
                          );
                          print(taskId);
                          if (taskId != null) {
                            DateTime now = DateTime.now();
                            String formattedDate =
                                DateFormat.yMd().add_jm().format(now);
                            progressTasks.add(Download()
                              ..taskId = taskId
                              ..name = attachment.title
                              ..slug = playerViewModel.materialModel?.slug
                              ..downloadAt = formattedDate
                              ..filePath =
                                  appController.selectedDownloadDirectory.value
                              ..imageUrl =
                                  playerViewModel.materialModel?.mainImage
                              ..url = Env.baseMediaUrl + attachment.path
                              ..size = attachment.size
                              ..materialTitle =
                                  playerViewModel.materialModel?.title
                              ..prefix = attachment.type);
                            successSnackBar(message: 'تم بدء التحميل');
                          }
                        } else {
                          errorSnackBar(
                              message:
                                  'لا تمتلك صلاحيات التخزين يرجى إعطاء التطبيق الأذن');
                        }
                      } else {
                        Get.dialog(const CustomAlertDialog(
                          title: 'تنبيه',
                          content:
                              'يرجى حذف الملف من صفحة التنزيلات والمحاولة مرة أخرى',
                        ));
                      }
                    },
                    icon: const Icon(
                      Icons.download_for_offline_rounded,
                      color: DesignColors.brown,
                      size: 40,
                    )),
                attachment.playable == 1
                    ? IconButton(
                        onPressed: () {
                          playerViewModel.controller?.dispose();
                          playerViewModel.imageUrl.value = '';
                          playerViewModel.addVideoUrl(attachment.path);
                        },
                        icon: const Icon(
                          Icons.play_circle,
                          color: DesignColors.brown,
                          size: 40,
                        ))
                    : IconButton(
                        onPressed: () async {
                          if (getAttachmentType(attachment.type) == 'صورة') {
                            playerViewModel.imageUrl.value = attachment.path;
                          } else {
                            DocumentViewModel documentViewModel =
                                Get.put(DocumentViewModel());
                            documentViewModel.url = Env.googleViewer +
                                Env.baseMediaUrl +
                                attachment.path;
                            documentViewModel.loadNetworkDocument();
                            Get.toNamed(AppRoutes.networkDoc);
                          }
                        },
                        icon: const Icon(
                          Icons.remove_red_eye_rounded,
                          color: DesignColors.brown,
                          size: 40,
                        )),
              ]),
            ),
          ),
          buildItemRow(text: attachment.title, width: 150),
          buildItemRow(text: getAttachmentType(attachment.type)),
          buildItemRow(text: attachment.type),
          buildItemRow(text: convertFileSizeFromKbToMb(attachment.size ?? 0)),
          buildItemRow(text: attachment.duration ?? ''),
        ],
      ),
    ],
  );
}

buildItemRow({required String text, double? width}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0),
    child: SizedBox(
        width: width ?? 100,
        height: 50,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: DesignColors.brown, fontSize: 16),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        )),
  );
}
