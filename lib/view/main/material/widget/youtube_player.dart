import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../config/env.dart';
import '../../../../resources/assets_manager.dart';
import '../view_model/material_view_model.dart';

class YouTubePlayer extends StatefulWidget {
  const YouTubePlayer({Key? key}) : super(key: key);

  @override
  State<YouTubePlayer> createState() => YouTubePlayerState();
}

class YouTubePlayerState extends State<YouTubePlayer> {
  MaterialViewModel materialViewModel = Get.find();
  AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return materialViewModel.materialModel?.mainVideo == null ||
            materialViewModel.materialModel?.mainVideo == ''
        ? AspectRatio(
            aspectRatio: 16 / 9,
            child: FancyShimmerImage(
              imageUrl: materialViewModel.materialModel?.mainImage == null
                  ? ''
                  : Env.baseMediaUrl +
                      materialViewModel.materialModel?.mainImage,
              boxFit: BoxFit.fill,
              errorWidget: Container(
                color: Colors.grey[100],
                child: Image.asset(
                  ImageAssets.logo,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
        : YoutubePlayer(
            aspectRatio: 16 / 9,
            bottomActions: [
              IconButton(
                  onPressed: () {
                    materialViewModel.youtubePlayerController
                        .toggleFullScreenMode();
                  },
                  icon: const Icon(
                    Icons.fullscreen,
                    color: DesignColors.white,
                  )),
              const SizedBox(width: 20.0),
              CurrentPosition(),
              const SizedBox(width: 20.0),
              ProgressBar(
                isExpanded: true,
              ),
              RemainingDuration(),
            ],
            onReady: () {
              print('hi');
            },
            controller: materialViewModel.youtubePlayerController,
            showVideoProgressIndicator: false ,
          );
  }
}
