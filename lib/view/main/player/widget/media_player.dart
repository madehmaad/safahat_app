import 'package:chewie/chewie.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as i;
import 'package:share_plus/share_plus.dart';

import '../../../../config/env.dart';
import '../../../../config/functions.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/colors.dart';
import '../../../utils/widgets/loader.dart';
import '../view_model/player_view_model.dart';

class MediaPlayer extends StatefulWidget {
  const MediaPlayer({Key? key}) : super(key: key);

  @override
  State<MediaPlayer> createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
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
                      const SizedBox(
                        height: 10,
                      ),
                      if (playerViewModel.materialModel != null)
                        Text(
                          playerViewModel.materialModel?.title ?? '',
                          style: const TextStyle(
                              color: DesignColors.brown, fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (playerViewModel.materialModel != null)
                            const Icon(
                              Icons.access_time_filled_outlined,
                              size: 20,
                              color: DesignColors.brown,
                            ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (playerViewModel.materialModel != null)
                            Text(
                              i.DateFormat("EEEE dd/MM/yyyy", 'ar').format(
                                  DateTime.parse(playerViewModel
                                      .materialModel?.materialDate)),
                              style: const TextStyle(
                                  color: DesignColors.brown, fontSize: 16),
                            ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                              onTap: () => Share.share(Env.baseMediaUrl +
                                  playerViewModel.url!.replaceAll(' ', '%20')),
                              child: SvgPicture.asset(
                                ImageAssets.share,
                                height: 25,
                                width: 25,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: SizedBox(
                          child: Slider(
                              min: 0,
                              max: playerViewModel
                                  .controller!.value.duration.inSeconds
                                  .toDouble(),
                              value: sliderValue,
                              onChangeEnd: (value) {
                                Duration targetPosition =
                                    const Duration(seconds: 0) +
                                        Duration(seconds: value.toInt());
                                playerViewModel.controller!
                                    .seekTo(targetPosition);
                                playerViewModel.controller!.seekTo(
                                    Duration(seconds: sliderValue.toInt()));
                              },
                              activeColor: DesignColors.brown,
                              inactiveColor: DesignColors.primary,
                              thumbColor: DesignColors.brown,
                              onChanged: (val) {
                                setState(() {
                                  sliderValue = val;
                                });
                              }),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${changeSecondsToMinuteAndSecond(playerViewModel.controller!.value.duration.inSeconds.toInt() - playerViewModel.controller!.value.position.inSeconds.toInt())} -',
                              style: const TextStyle(
                                color: DesignColors.primary,
                              ),
                            ),
                            Text(
                              changeSecondsToMinuteAndSecond(playerViewModel
                                  .controller!.value.position.inSeconds),
                              style: const TextStyle(
                                color: DesignColors.primary,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                setState(() {
                                  Duration currentPosition = playerViewModel
                                      .controller!.value.position;
                                  Duration targetPosition = currentPosition +
                                      const Duration(seconds: 30);
                                  playerViewModel.controller
                                      ?.seekTo(targetPosition);
                                });
                              },
                              child: Image.asset(ImageAssets.seekForward,
                                  height: 40,
                                  width: 40,
                                  color: DesignColors.brown)),
                          InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                setState(() {
                                  if (playerViewModel
                                      .controller!.value.isPlaying) {
                                    playerViewModel.controller!.pause();
                                  } else {
                                    playerViewModel.controller!.play();
                                  }
                                });
                              },
                              child: playerViewModel.controller!.value.isPlaying
                                  ? const Icon(
                                      Icons.pause_circle_filled,
                                      color: DesignColors.brown,
                                      size: 50,
                                    )
                                  : const Icon(
                                      Icons.play_circle,
                                      color: DesignColors.brown,
                                      size: 50,
                                    )),
                          InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                setState(() {
                                  Duration currentPosition = playerViewModel
                                      .controller!.value.position;
                                  Duration targetPosition = currentPosition -
                                      const Duration(seconds: 10);
                                  playerViewModel.controller!
                                      .seekTo(targetPosition);
                                });
                              },
                              child: Image.asset(ImageAssets.seekBack,
                                  height: 40,
                                  width: 40,
                                  color: DesignColors.brown)),
                        ],
                      )
                    ]);
    });
  }
}
