import 'package:dr_alshaal/view/main/download/view_model/download_view_model.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';

import '../../../../config/env.dart';
import '../../../../config/functions.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/colors.dart';

class DownloadProgressCard extends StatelessWidget {
  final DownloadTask downloadTask;

  DownloadProgressCard({Key? key, required this.downloadTask})
      : super(key: key);
  final DownloadViewModel downloadViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: FancyShimmerImage(
                    imageUrl: downloadViewModel
                                .getRecordDataByTaskId(
                                    taskId: downloadTask.taskId)
                                ?.imageUrl ==
                            null
                        ? ''
                        : Env.baseMediaUrl +
                            downloadViewModel
                                .getRecordDataByTaskId(
                                    taskId: downloadTask.taskId)!
                                .imageUrl!,
                    boxFit: BoxFit.cover,
                    errorWidget: Container(
                      color: Colors.grey[100],
                      child: Image.asset(
                        ImageAssets.logo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              downloadTask.filename ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: DesignColors.brown),
                            ),
                            Text(
                              downloadViewModel
                                      .getRecordDataByTaskId(
                                          taskId: downloadTask.taskId)
                                      ?.materialTitle ??
                                  '',
                              style: const TextStyle(
                                  color: DesignColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      if (!downloadViewModel.isCheck.value)
                        _showPopupMenu(context)
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: getDownloadStatusAction(downloadTask),
              ),
              Text(
                getAttachmentType(downloadViewModel
                        .getRecordDataByTaskId(taskId: downloadTask.taskId)
                        ?.prefix ??
                    ''),
                style: const TextStyle(
                    color: DesignColors.brown,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                convertFileSizeFromKbToMb(downloadViewModel
                        .getRecordDataByTaskId(taskId: downloadTask.taskId)
                        ?.size ??
                    0),
                style: const TextStyle(
                    color: DesignColors.brown,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget getDownloadStatusAction(DownloadTask task) {
    return InkWell(
      onTap: () {
        if (task.status == DownloadTaskStatus.running) {
          downloadViewModel.pauseTask(task.taskId);
        }
        if (task.status == DownloadTaskStatus.paused) {
          downloadViewModel.resumeTask(task.taskId);
        }
        if (task.status == DownloadTaskStatus.failed) {
          downloadViewModel.retryTask(task.taskId);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            task.status == DownloadTaskStatus.failed
                ? Icons.error_outline
                : task.status == DownloadTaskStatus.paused
                    ? Icons.play_circle_outlined
                    : Icons.pause_circle_filled_outlined,
            color: DesignColors.brown,
            size: 25,
          ),
          SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              valueColor: task.status == DownloadTaskStatus.paused ||
                      task.status == DownloadTaskStatus.running
                  ? const AlwaysStoppedAnimation<Color>(
                      DesignColors.primary,
                    )
                  : null,
              value: task.status == DownloadTaskStatus.paused ||
                      task.status == DownloadTaskStatus.running
                  ? task.progress.toDouble() / 100
                  : 0,
            ),
          )
        ],
      ),
    );
  }

  PopupMenuButton _showPopupMenu(context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert_sharp,
        color: DesignColors.brown,
      ),
      offset: const Offset(0, 50), //add offset to fix it
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                Icon(Icons.delete_outline, size: 20, color: DesignColors.brown),
                SizedBox(
                  width: 10,
                ),
                Text("حذف")
              ],
            ),
          ),
        ];
      },
      onSelected: (value) {
        if (value == 1) {
          downloadViewModel.deleteTask(downloadTask.taskId);
        }
      },
    );
  }
}
