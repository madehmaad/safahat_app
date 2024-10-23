import 'package:dr_alshaal/view/main/player/view_model/player_view_model.dart';
import 'package:dr_alshaal/view/main/player/widget/media_player.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:dr_alshaal/view/utils/widgets/base_scaffold.dart';
import 'package:dr_alshaal/view/utils/widgets/full_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LocalPlayerScreen extends StatefulWidget {
  const LocalPlayerScreen({Key? key}) : super(key: key);

  @override
  State<LocalPlayerScreen> createState() => _LocalPlayerScreenState();
}

class _LocalPlayerScreenState extends State<LocalPlayerScreen> {
  PlayerViewModel playerViewModel = Get.find();

  @override
  void dispose() {
    playerViewModel.controller?.pause();
    playerViewModel.chewieController?.pause();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBar: appBarCustom(
          title: 'player'.tr,
          backIcon: true,
        ),
        body: Obx(() {
          return playerViewModel.getMainLoading ? const FullLoader() : const MediaPlayer();
        }));
  }
}
