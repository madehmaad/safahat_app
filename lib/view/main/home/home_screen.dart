import 'package:dr_alshaal/view/main/home/view_model/home_view_model.dart';
import 'package:dr_alshaal/view/main/home/widget/home_footer.dart';
import 'package:dr_alshaal/view/main/home/widget/last_post_list_view.dart';
import 'package:dr_alshaal/view/main/home/widget/lessons_tables.dart';
import 'package:dr_alshaal/view/main/home/widget/material_list_view.dart';
import 'package:dr_alshaal/view/main/home/widget/question_home_list.dart';
import 'package:dr_alshaal/view/utils/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../config/functions.dart';
import '../../utils/dialogs/confirm_dialog.dart';
import '../../utils/widgets/app_bar.dart';
import '../../utils/widgets/error_screen.dart';
import '../../utils/widgets/full_loader.dart';
import '../question/view_model/question_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = Get.find();
  QuestionViewModel questionViewModel = Get.find();
  late TutorialCoachMark tutorialCoachMark;
  GlobalKey liveKey = GlobalKey();
  GlobalKey logoKey = GlobalKey();
  GlobalKey questionKey = GlobalKey();
  GlobalKey favoriteKey = GlobalKey();
  GlobalKey downloadKey = GlobalKey();

  @override
  void initState() {
    createTutorial();
    Future.delayed(const Duration(seconds: 1), showTutorial);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool status = false;
        await Get.dialog(ConfirmDialog(
          height: 200,
          title: "هل تريد الخروج من التطبيق",
          confirmBtnText: "نعم",
          confirmFunction: () {
            status = true;
            Get.back();
          },
          dismissBtnText: "لا",
        ));
        return status;
      },
      child: BaseScaffold(
        questionKey: questionKey,
        downloadKey: downloadKey,
        favoriteKey: favoriteKey,
        appBar: appBarCustom(
            title: 'home'.tr,
            menuIcon: true,
            liveStreamIcon: true,
            notificationIcon: true,
            searchIcon: true,
            liveKey: liveKey,
            logoKey: logoKey),
        body: Obx(() => homeViewModel.getMainLoading
            ? const FullLoader()
            : !homeViewModel.status &&
                    !homeViewModel.lastPosStatus &&
                    !homeViewModel.mixlerLessonStatus &&
                    !homeViewModel.lectureScheduleStatus &&
                    !questionViewModel.status
                ? ErrorScreen(refresh: () {
                    homeViewModel.onInit();
                    questionViewModel.getCategories();
                  })
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            if (homeViewModel.lastPostModel?.data.isNotEmpty ??
                                false)
                              const LastPostListView(),
                            ...homeViewModel.homeTypeMaterial!
                                .map((e) =>
                                    HomeMaterialListView(homeTypeMaterial: e))
                                .toList(),
                            QuestionHomeList(),
                            const SizedBox(
                              height: 30,
                            ),
                            LessonsTables(),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                        const HomeFooter(),
                      ],
                    ),
                  )),
      ),
    );
  }

  showTutorial() {
    if (!getHomeGide()) {
      setHomeGide();
      tutorialCoachMark.show(context: context);
    }
  }

  createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      alignSkip: Alignment.bottomRight,
      targets: [
        TargetFocus(
          identify: "logoKey",
          keyTarget: logoKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return const Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                    ),
                    Text(
                      "عند الضغط على هذه الايقونة يقوم بفتح الخيارات الاضافية الموجودة في التطبيق",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        TargetFocus(
          identify: "liveKey",
          keyTarget: liveKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return const Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                    ),
                    Text(
                      "يقوم هذا الخيار بعرض البثوث المباشرة المتاحة حاليا",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        TargetFocus(
          identify: "questionKey",
          keyTarget: questionKey,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return const Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "يقوم هذا القسم بعرض جميع الاسئلة والاستشارات في الكثير من المجالات والاجابة عليها",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 200,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        TargetFocus(
          identify: "favoriteKey",
          keyTarget: favoriteKey,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return const Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "يقوم هذا القسم بعرض المفضلة الخاصة بك حيث يمكن إضافة المواد عليها من صفحة المادة",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 200,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        TargetFocus(
          identify: "downloadKey",
          keyTarget: downloadKey,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return const Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "يقوم هذا القسم بعرض الوسائط الجاري تحميلها والتي تم تحميلها مسبقا ويمكن فتحها من هذا القسم",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 200,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
      colorShadow: Colors.black,
      textSkip: "تخطي",
      paddingFocus: 0,
      opacityShadow: 0.7,
    );
  }
}
