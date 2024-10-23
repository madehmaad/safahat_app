import 'package:chewie/chewie.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/env.dart';
import '../../../../resources/assets_manager.dart';
import '../../../utils/widgets/loader.dart';
import '../view_model/player_view_model.dart';

class HomePlayer extends StatefulWidget {
  const HomePlayer({Key? key}) : super(key: key);

  @override
  State<HomePlayer> createState() => _HomePlayerState();
}

class _HomePlayerState extends State<HomePlayer> {
  PlayerViewModel playerViewModel = Get.find();
  double sliderValue = 0;

  listener() {
    if (mounted) {
      playerViewModel.controller?.addListener(() {
        if (mounted) {
          setState(() {
            sliderValue =
                playerViewModel.controller!.value.position.inSeconds.toDouble();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      listener();
      return playerViewModel.getMainLoading
          ? const SizedBox(height: 400, child: Loader())
          : playerViewModel.mediaNotExist.value
              ? const SizedBox(
                  height: 400,
                  child: Center(child: Text('عذراً الملف غير موجود')))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Center(
                        child: !playerViewModel.controller!.dataSource
                                .contains('.mp3')
                            ? SizedBox(
                                height: (MediaQuery.of(context).size.width) /
                                    16 *
                                    9,
                                child: Chewie(
                                  controller: playerViewModel.chewieController!,
                                ),
                              )
                            : AspectRatio(
                                aspectRatio: 16 / 9,
                                child: FancyShimmerImage(
                                  imageUrl: playerViewModel
                                              .materialModel?.mainImage ==
                                          null
                                      ? ''
                                      : Env.baseMediaUrl +
                                          playerViewModel
                                              .materialModel?.mainImage,
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
                      ),
                    ]);
    });
  }
}
