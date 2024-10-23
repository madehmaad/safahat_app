import 'package:dr_alshaal/config/functions.dart';
import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/resources/routes.dart';
import 'package:dr_alshaal/view/menu/widget/build_section.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:dr_alshaal/view/utils/widgets/base_scaffold.dart';
import 'package:dr_alshaal/view/utils/widgets/divider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../resources/assets_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AppController appController = Get.find();
  late TutorialCoachMark tutorialCoachMark;
  GlobalKey fullScreenKey = GlobalKey();
  GlobalKey autoPlayKey = GlobalKey();
  GlobalKey fontSizeKey = GlobalKey();
  GlobalKey storePathKey = GlobalKey();

  Future<void> pickDirectory() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      appController.changeDownloadDirectoryPath(selectedDirectory);
    }
  }

  @override
  void initState() {
    createTutorial();
    Future.delayed(const Duration(seconds: 1), showTutorial);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: appBarCustom(
        title: 'settings'.tr,
        backIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            buildSection(
                key: fontSizeKey,
                title: 'default_font_size'.tr,
                icon: ImageAssets.fontSizeMenu,
                onTap: () => Get.toNamed(AppRoutes.changeFont)),
            thinDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    key: fullScreenKey,
                    ImageAssets.fullScreenMenu,
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(width: 30),
                  Text(
                    'full_screen'.tr,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: DesignColors.brown),
                  ),
                  const Spacer(),
                  Obx(
                    () => Switch(
                        activeColor: DesignColors.primary,
                        value: appController.fullScreen.value,
                        onChanged: (value) {
                          appController.changeDefaultFullScreen(value);
                        }),
                  )
                ],
              ),
            ),
            thinDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    key: autoPlayKey,
                    ImageAssets.autoPlayMenu,
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(width: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 180,
                    child: Text(
                      'auto_play'.tr,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: DesignColors.brown),
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => Switch(
                        activeColor: DesignColors.primary,
                        value: appController.isAutoPlay.value,
                        onChanged: (value) {
                          appController.changeAutoPlayMedia(value);
                        }),
                  )
                ],
              ),
            ),
            thickDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => pickDirectory(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              key: storePathKey,
                              ImageAssets.downloadPathMenu,
                              height: 25,
                              width: 25,
                            ),
                            const SizedBox(width: 30),
                            Flexible(
                              child: Text(
                                'default_download_directory'.tr,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: DesignColors.brown),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => Text(
                            appController.selectedDownloadDirectory.value ==
                                    'null'
                                ? ''
                                : appController.selectedDownloadDirectory.value
                                    .replaceAll('storage/emulated/0/', ''),
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: DesignColors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showTutorial() {
    if (!getSettingsGide()) {
      setSettingsGide();
      tutorialCoachMark.show(context: context);
    }
  }

  createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      alignSkip: Alignment.bottomRight,
      targets: [
        TargetFocus(
          identify: "fontSizeKey",
          keyTarget: fontSizeKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return const Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 300,
                    ),
                    Text(
                      "يقوم هذا الخيار بتحديد حجم الخط الافتراضي في شرح المادة فقط ولا ينعكس التغيير في باقي التطبيق",
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
          identify: "fullScreenKey",
          keyTarget: fullScreenKey,
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
                      "يقوم هذا الخيار بتفعيل وضع ملء الشاشة بحيث يختفي الشريط العلوي يمكن إلغاء هذا الوضع بالضغط على (x)",
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
          identify: "autoPlayKey",
          keyTarget: autoPlayKey,
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
                      "يقوم هذا الخيار بتشغيل الوسائط بشكل تلقائي في التطبيق عند الدخول إلى صفحة المشغل او صفحة المادة",
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
          identify: "storePathKey",
          keyTarget: storePathKey,
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
                      "يقوم هذا الخيار بتحديد الموقع الذي تريد تخزين الوسائط فيه بعد التنزيل إلى هاتفك الخاص.",
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
      ],
      colorShadow: Colors.black,
      textSkip: "تخطي",
      paddingFocus: 0,
      opacityShadow: 0.7,
    );
  }
}
