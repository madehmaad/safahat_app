import 'package:dr_alshaal/view/main/favorite/widget/add_favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/dialogs/confirm_dialog.dart';
import '../../utils/widgets/app_bar.dart';
import '../../utils/widgets/base_scaffold.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
              title: 'favorite'.tr, menuIcon: true, liveStreamIcon: true, notificationIcon: true, searchIcon: true),
          body: AddFavoriteScreen(
            isAdd: false,
          )),
    );
  }
}
