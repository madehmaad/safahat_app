import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/resources/assets_manager.dart';
import 'package:dr_alshaal/view/main/ahadeth/ahadeth_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../config/env.dart';
import '../../../config/functions.dart';
import '../../../resources/colors.dart';
import '../../utils/widgets/app_bar.dart';
import '../../utils/widgets/base_scaffold.dart';
import '../../utils/widgets/snack_bar.dart';

class AhadethScreen extends StatelessWidget {
  const AhadethScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: appBarCustom(title: 'ahadeth'.tr, backIcon: true),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildPdfRow(title: 'سنن ابن ماجه', url: Env.ahadethUrl1),
              buildPdfRow(title: 'سنن أبي داود', url: Env.ahadethUrl2),
              buildPdfRow(title: 'سنن الترمزي', url: Env.ahadethUrl3),
              buildPdfRow(title: 'سنن النسائي', url: Env.ahadethUrl4),
              buildPdfRow(title: 'صحيح البخاري', url: Env.ahadethUrl5),
              buildPdfRow(title: 'صحيح مسلم', url: Env.ahadethUrl6),
              buildPdfRow(title: 'موطأ مالك', url: Env.ahadethUrl7),
            ],
          ),
        ),
      ),
    );
  }

  buildPdfRow({required String url, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () async {
          // await launchUrl(Uri.parse(Env.googleViewer + url),
          //     mode: LaunchMode.externalNonBrowserApplication,
          //     webViewConfiguration: const WebViewConfiguration(enableJavaScript: true));
          Get.to(AhadethDetails(path: url));
        },
        child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 10,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(children: [
                  Image.asset(
                    ImageAssets.pdf,
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: Get.mediaQuery.size.width * 0.45,
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        bool status = await checkPermission();
                        if (status) {
                          await prepareSaveDir();
                          await FlutterDownloader.enqueue(
                            url: url,
                            headers: {},
                            savedDir: Get.find<AppController>()
                                .selectedDownloadDirectory
                                .value,
                            saveInPublicStorage: false,
                            requiresStorageNotLow: false,
                            showNotification: true,
                            openFileFromNotification: false,
                            allowCellular: true,
                          );
                        } else {
                          errorSnackBar(
                              message:
                                  'لا تمتلك صلاحيات التخزين يرجى إعطاء التطبيق الأذن');
                        }
                      },
                      icon: const Icon(
                        Icons.download,
                        size: 30,
                        color: DesignColors.brown,
                      )),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Share.share('$title\n$url');
                      },
                      icon: const Icon(
                        Icons.share,
                        size: 30,
                        color: DesignColors.brown,
                      )),
                ]))),
      ),
    );
  }
}
