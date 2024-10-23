import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/resources/assets_manager.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/resources/routes.dart';
import 'package:dr_alshaal/view/main/series/view_model/series_view_model.dart';
import 'package:dr_alshaal/view/menu/widget/build_section.dart';
import 'package:dr_alshaal/view/utils/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main/materials/view_model/materials_view_model.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: DesignColors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              buildSection(
                  title: 'series'.tr,
                  icon: ImageAssets.materialMenu,
                  onTap: () {
                    SeriesViewModel seriesViewModel = Get.put(SeriesViewModel());
                    seriesViewModel.selectedCategoryId=null;
                    seriesViewModel.getAllData();
                    Get.toNamed(AppRoutes.series);
                  }),
              thickDivider(),
              buildSection(
                  title: 'materials'.tr,
                  icon: ImageAssets.materialMenu,
                  onTap: () {
                    MaterialsViewModel materialsViewModel = Get.put(MaterialsViewModel());
                    materialsViewModel.selectedSeriesId = null;
                    materialsViewModel.selectedSeriesName = 'المواد';
                    materialsViewModel.getAllData();
                    Get.toNamed(AppRoutes.materials);
                  }),
              thickDivider(),
              buildSection(
                  title: 'downloads'.tr,
                  icon: ImageAssets.downloadMenu,
                  onTap: () {
                    appController.changeNavBarIndex(3);
                    Get.offAllNamed(AppRoutes.download);
                  }),
              thickDivider(),
              buildSection(
                  title: 'favorite'.tr,
                  icon: ImageAssets.favoriteMenu,
                  onTap: () {
                    appController.changeNavBarIndex(2);

                    Get.offAllNamed(AppRoutes.favorite);
                  }),
              thickDivider(),
              buildSection(
                  title: 'questions'.tr,
                  icon: ImageAssets.questionMenu,
                  onTap: () {
                    appController.changeNavBarIndex(1);

                    Get.offAllNamed(AppRoutes.question);
                  }),
              thickDivider(),

              buildSection(
                  title: 'live_stream'.tr,
                  icon: ImageAssets.liveMenu,
                  onTap: () {
                    Get.toNamed(AppRoutes.liveStream);
                  }),
              thickDivider(),
              buildSection(
                  title: 'ahadeth'.tr,
                  icon: ImageAssets.ahadethMenu,
                  onTap: () {
                    Get.toNamed(AppRoutes.ahadeth);
                  }),

              thickDivider(),
              buildSection(
                  title: 'contact_us'.tr,
                  icon: ImageAssets.contactUsMenu,
                  onTap: () {
                    Get.toNamed(AppRoutes.contactUs);
                  }),
              thickDivider(),
              buildSection(
                  title: 'about_app'.tr,
                  icon: ImageAssets.aboutUsMenu,
                  onTap: () {
                    Get.toNamed(AppRoutes.aboutApp);
                  }),
              thickDivider(),
              buildSection(
                  title: 'settings'.tr,
                  icon: ImageAssets.settingsMenu,
                  onTap: () {
                    Get.toNamed(AppRoutes.settings);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
