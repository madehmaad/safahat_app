import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../models/lecture_schedule/app.dart';
import '../../../../models/lecture_schedule/lecture_schedule.dart';
import '../../../../models/mixler_lesson/mixler_lesson.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/colors.dart';
import '../view_model/home_view_model.dart';

class LessonsTables extends StatelessWidget {
  LessonsTables({Key? key}) : super(key: key);
  int index = 0;
  final HomeViewModel homeViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (homeViewModel.mixlerLessons!.isNotEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              ' أوقات بث دروس المكسلر ',
              style: TextStyle(fontSize: 20, color: DesignColors.brown, fontWeight: FontWeight.bold),
            ),
          ),
        const SizedBox(
          height: 10,
        ),
        if (homeViewModel.mixlerLessons!.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Column(children: [
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      buildTitleWidget(title: 'material'.tr),
                      buildTitleWidget(title: 'date_stream'.tr),
                      buildTitleWidget(title: 'first_repeat'.tr),
                      buildTitleWidget(title: 'second_repeat'.tr),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...homeViewModel.mixlerLessons!.map((e) => buildContentMixlerRow(e)).toList()
                ])
              ],
            ),
          ),
        const SizedBox(height: 50),
        if (homeViewModel.lectureSchedule!.isNotEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              ' أوقات بث دروس المساجد',
              style: TextStyle(fontSize: 20, color: DesignColors.brown, fontWeight: FontWeight.bold),
            ),
          ),
        const SizedBox(
          height: 10,
        ),
        if (homeViewModel.lectureSchedule!.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Column(children: [
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      buildTitleWidget(title: 'العنوان'.tr),
                      buildTitleWidget(title: 'المكان'.tr),
                      buildTitleWidget(title: 'الوقت'.tr),
                      buildTitleWidget(title: 'البث'.tr, width: 250),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...homeViewModel.lectureSchedule!.map((e) => buildContentLectureRow(e)).toList()
                ])
              ],
            ),
          ),
      ],
    );
  }

  buildTitleWidget({required String title, double? width}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
          width: width ?? 100,
          height: 30,
          decoration: BoxDecoration(color: DesignColors.primary, borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: Text(
            title,
            style: const TextStyle(color: DesignColors.white, fontSize: 16),
          ))),
    );
  }

  buildContentLectureRow(LectureSchedule lectureSchedule) {
    index++;
    return Container(
      color: index % 2 == 0 ? Colors.grey[200] : Colors.grey[50],
      height: 50,
      child: Row(
        children: [
          const SizedBox(width: 10),
          buildItemRow(lectureSchedule.title),
          buildItemRow(lectureSchedule.place),
          buildItemRow(lectureSchedule.time),
          buildIconRowLecture(lectureSchedule.app!),
        ],
      ),
    );
  }

  buildContentMixlerRow(MixlerLesson mixlerLesson) {
    index++;
    return Container(
      color: index % 2 == 0 ? Colors.grey[200] : Colors.grey[50],
      height: 50,
      child: Row(
        children: [
          const SizedBox(width: 10),
          buildItemRow(mixlerLesson.name),
          buildItemRow(mixlerLesson.time),
          buildItemRow(mixlerLesson.firstRepeat),
          buildItemRow(mixlerLesson.secondRepeat),
        ],
      ),
    );
  }

  buildItemRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: SizedBox(
          width: 100,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: DesignColors.brown, fontSize: 14),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          )),
    );
  }

  buildIconRowLecture(List<App> app) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SizedBox(
          width: 245,
          child: Row(
            children: [
              ...app
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: InkWell(
                            onTap: () async => await launchUrl(Uri.parse(e.link), mode: LaunchMode.externalApplication),
                            child: getIconInLecture(e.name)),
                      ))
                  .toList()
            ],
          ),
        ));
  }

  getIconInLecture(String name) {
    switch (name) {
      case 'Facebook':
        return SvgPicture.asset(
          ImageAssets.facebook,
          height: 27,
          width: 27,
          color: DesignColors.brown,
        );
      case 'Youtube':
        return SvgPicture.asset(
          ImageAssets.youtube,
          height: 27,
          width: 27,
          color: DesignColors.brown,
        );
      case 'Twitter':
        return SvgPicture.asset(
          ImageAssets.twitter,
          height: 27,
          width: 27,
          color: DesignColors.brown,
        );
      case 'Instagram':
        return SvgPicture.asset(
          ImageAssets.instagram,
          height: 27,
          width: 27,
          color: DesignColors.brown,
        );
      case 'Telegram':
        return SvgPicture.asset(
          ImageAssets.telegram,
          height: 27,
          width: 27,
          color: DesignColors.brown,
        );
      case 'Soundcloud':
        return SvgPicture.asset(
          ImageAssets.soundcloud,
          height: 27,
          width: 27,
          color: DesignColors.brown,
        );
      case 'Mixlr':
        return SvgPicture.asset(
          ImageAssets.mixler,
          height: 27,
          width: 27,
          color: DesignColors.brown,
        );
    }
  }
}
