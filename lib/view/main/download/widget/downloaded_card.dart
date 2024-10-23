import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;

import '../../../../config/env.dart';
import '../../../../config/functions.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/colors.dart';
import '../../../../resources/routes.dart';
import '../../../utils/dialogs/confirm_dialog.dart';
import '../../material/view_model/material_view_model.dart';
import '../collection/download_collection.dart';
import '../view_model/download_view_model.dart';

class DownloadedCard extends StatelessWidget {
  final Download download;

  DownloadedCard({Key? key, required this.download}) : super(key: key);
  final DownloadViewModel downloadViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Row(
        children: [
          FancyShimmerImage(
            imageUrl: download.imageUrl == null ? '' : Env.baseMediaUrl + download.imageUrl!,
            width: 80,
            height: 80,
            boxFit: BoxFit.cover,
            errorWidget: Container(
              color: Colors.grey[100],
              child: Image.asset(
                ImageAssets.logo,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    download.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: DesignColors.brown),
                  ),
                  Text(
                    download.materialTitle ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: DesignColors.black),
                  ),
                  Row(
                    children: [
                      getAttachmentType(download.prefix ?? '') == 'ملف'
                          ? const Icon(
                              Icons.remove_red_eye,
                              size: 30,
                              color: DesignColors.brown,
                            )
                          : SvgPicture.asset(
                              ImageAssets.play,
                              width: 30,
                              height: 30,
                            ),
                      const Spacer(),
                      Text(
                        convertFileSizeFromKbToMb(download.size ?? 0),
                        style: const TextStyle(color: DesignColors.brown, fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          if (!downloadViewModel.isCheck.value) _showPopupMenu()
        ],
      ),
    );
  }

  PopupMenuButton _showPopupMenu() {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert_sharp,
        color: DesignColors.brown,
      ),
      offset: const Offset(0, 50), //add offset to fix it
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.openWith,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("فتح باستخدام")
              ],
            ),
          ),
          // PopupMenuItem 2
          PopupMenuItem(
            value: 2,
            child: Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.materialHome,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("فتح المادة الأم")
              ],
            ),
          ),
          const PopupMenuItem(
            value: 3,
            child: Row(
              children: [
                Icon(Icons.delete_outline, size: 25, color: DesignColors.brown),
                SizedBox(
                  width: 10,
                ),
                Text("حذف")
              ],
            ),
          ),
        ];
      },
      onSelected: (value) async {
        switch (value) {
          case 1:
            OpenFilex.open('${download.filePath}/${path.basename(download.url!)}');
            break;
          case 2:
            MaterialViewModel materialViewModel = Get.put(MaterialViewModel());
            materialViewModel.materialSlug = download.slug;
            materialViewModel.getAllData();
            Get.toNamed(AppRoutes.material);
            break;
          default:
            await Get.dialog(ConfirmDialog(
              height: 250,
              title: "هل تريد حذف المادة",
               message: 'انتبه سوف يتم الحذف من الذاكرة الداخلية!!',
              confirmBtnText: "نعم",
              confirmFunction: ()  {
                downloadViewModel.deleteFile(id: download.id);
                Get.back();
              },
              dismissBtnText: "لا",
            ));
            break;
        }
      },
    );
  }
}
