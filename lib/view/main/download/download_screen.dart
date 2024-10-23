import 'package:dr_alshaal/view/main/download/view_model/download_view_model.dart';
import 'package:dr_alshaal/view/main/download/widget/downloaded_list.dart';
import 'package:dr_alshaal/view/main/download/widget/progress_download_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/colors.dart';
import '../../utils/dialogs/confirm_dialog.dart';
import '../../utils/widgets/app_bar.dart';
import '../../utils/widgets/base_scaffold.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  final DownloadViewModel downloadViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool status=false;
        await Get.dialog(ConfirmDialog(
          height: 200,
          title: "هل تريد الخروج من التطبيق",
          confirmBtnText: "نعم",
          confirmFunction: ()  {
            status=true;
            Get.back();
          },
          dismissBtnText: "لا",
        ));
        return status;
      },
      child: BaseScaffold(
          appBar: appBarCustom(
              title: 'downloads'.tr, menuIcon: true, liveStreamIcon: true, notificationIcon: true, searchIcon: true),
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 0,
                elevation: 5,
                backgroundColor: Colors.grey[300],
                bottom: const TabBar(
                  indicatorColor: DesignColors.primary,
                  tabs: [
                    Tab(icon: Icon(Icons.download_outlined, color: DesignColors.brown, size: 30)),
                    Tab(icon: Icon(Icons.sd_storage_outlined, color: DesignColors.brown, size: 30)),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(ImageAssets.placeholderPng),
                    fit: BoxFit.fill,
                    // alignment: Alignment.bottomCenter,
                    //opacity: 0.5,
                  )),
                  child: TabBarView(
                    children: [ProgressDownloadList(), DownloadedList()],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
