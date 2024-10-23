import 'package:dr_alshaal/config/env.dart';
import 'package:dr_alshaal/view/main/download/view_model/download_view_model.dart';
import 'package:dr_alshaal/view/main/player/view_model/player_view_model.dart';
import 'package:dr_alshaal/view/main/player/widget/attachments_widget.dart';
import 'package:dr_alshaal/view/main/player/widget/media_player.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:dr_alshaal/view/utils/widgets/base_scaffold.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controller/app_controller/app_controller.dart';
import '../../../resources/assets_manager.dart';

class NetworkPlayerScreen extends StatefulWidget {
  const NetworkPlayerScreen({Key? key}) : super(key: key);

  @override
  State<NetworkPlayerScreen> createState() => _NetworkPlayerScreenState();
}

class _NetworkPlayerScreenState extends State<NetworkPlayerScreen> {
  PlayerViewModel playerViewModel = Get.find();
  DownloadViewModel downloadViewModel = Get.find();
  AppController appController = Get.find();

  @override
  void dispose() {
    playerViewModel.controller?.dispose();
    playerViewModel.chewieController?.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: appBarCustom(
        title: 'player'.tr,
        backIcon: true,
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            children: [
              playerViewModel.controller != null &&
                      playerViewModel.imageUrl.value == ''
                  ? const MediaPlayer()
                  : AspectRatio(
                      aspectRatio: 16 / 9,
                      child: FancyShimmerImage(
                        imageUrl: playerViewModel.imageUrl.value != ''
                            ? Env.baseMediaUrl + playerViewModel.imageUrl.value
                            : playerViewModel.materialModel?.mainImage == null
                                ? ''
                                : Env.baseMediaUrl +
                                    playerViewModel.materialModel?.mainImage,
                        boxFit: BoxFit.fill,
                        errorWidget: Container(
                          color: Colors.grey[100],
                          child: Image.asset(
                            ImageAssets.logo,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              if (playerViewModel.materialModel != null &&
                  playerViewModel.materialModel!.attachments!.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Column(children: [
                        Row(
                          children: [
                            buildTitleWidget(title: 'download'.tr),
                            buildTitleWidget(
                                title: 'material_desc'.tr, width: 170),
                            buildTitleWidget(title: 'type'.tr),
                            buildTitleWidget(title: 'postfix'.tr),
                            buildTitleWidget(title: 'size'.tr),
                            buildTitleWidget(title: 'duration'.tr),
                          ],
                        ),
                        ...playerViewModel.materialModel!.attachments!
                            .map((e) => buildContentRow(e))
                            .toList()
                      ])
                    ],
                  ),
                )
            ],
          );
        }),
      ),
    );
  }
}
