import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/resources/assets_manager.dart';
import 'package:dr_alshaal/resources/routes.dart';
import 'package:dr_alshaal/view/main/search/view_model/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../resources/colors.dart';

PreferredSizeWidget appBarCustom(
    {required String title,
    bool liveStreamIcon = false,
    bool notificationIcon = false,
    bool backIcon = false,
    bool searchIcon = false,
    bool menuIcon = false,
    GlobalKey? logoKey,
    liveKey}) {
  return AppBar(
    elevation: 5,
    centerTitle: true,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (menuIcon)
          InkWell(
            onTap: () {
              Get.find<AppController>().changeDrawerState();
            },
            child: Image.asset(
              key: logoKey,
              ImageAssets.menu,
              height: 35,
              width: 35,
            ),
          ),
        if (backIcon)
          InkWell(
            onTap: () {
              Get.find<AppController>().closeDrawerState();
              Get.back();
            },
            child: SvgPicture.asset(
              ImageAssets.back,
              height: 20,
              width: 20,
            ),
          ),
        if (searchIcon)
          InkWell(
            onTap: () {
              SearchViewModel searchViewModel = Get.put(SearchViewModel());
              searchViewModel.getAllData();
              Get.toNamed(AppRoutes.search);
            },
            child: SvgPicture.asset(
              ImageAssets.search,
              height: 22,
              width: 22,
            ),
          ),
        Center(
            child: TextScroll(
          title,
          mode: TextScrollMode.endless,
          textDirection: TextDirection.rtl,
          velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
          delayBefore: const Duration(milliseconds: 1000),
          numberOfReps: 100000000,
          pauseBetween: const Duration(milliseconds: 0),
          style: const TextStyle(color: DesignColors.brown, fontSize: 16, fontWeight: FontWeight.w900),
          textAlign: TextAlign.center,
          selectable: true,
        )),
        if (backIcon)
          const SizedBox(
            height: 20,
            width: 20,
          ),
        if (liveStreamIcon)
          InkWell(
              key: liveKey,
              onTap: () => Get.toNamed(AppRoutes.liveStream),
              child: SvgPicture.asset(
                ImageAssets.live,
                height: 22,
                width: 22,
              )),
        if (notificationIcon)
          InkWell(
            onTap: () => Get.toNamed(AppRoutes.notification),
            child: SvgPicture.asset(
              ImageAssets.notification,
              height: 22,
              width: 22,
            ),
          ),
      ],
    ),
  );
}
