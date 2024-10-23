import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/resources/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../resources/assets_manager.dart';

class BaseScaffold extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final GlobalKey? questionKey, favoriteKey, downloadKey;
  final bool removeNavBar;

  const BaseScaffold(
      {Key? key,
      this.appBar,
      required this.body,
      this.questionKey,
      this.downloadKey,
      this.favoriteKey,
      this.removeNavBar = false})
      : super(key: key);

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: appController.fullScreen.value ? null : widget.appBar,
        body: cancelFullScreen(widget.body),
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: widget.removeNavBar
            ? null
            : AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: appController.navBarIsVisible.value ? 60 : 0.0,
                child: BottomNavigationBar(
                  elevation: 20,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: appController.navBarIndex.value == 0
                            ? SvgPicture.asset(
                                ImageAssets.homeNavA,
                                width: 25,
                                height: 25,
                              )
                            : SvgPicture.asset(
                                ImageAssets.homeNavD,
                                width: 25,
                                height: 25,
                              ),
                        label: 'home'),
                    BottomNavigationBarItem(
                        icon: appController.navBarIndex.value == 1
                            ? SvgPicture.asset(
                                key: widget.questionKey,
                                ImageAssets.questionNavA,
                                width: 25,
                                height: 25,
                              )
                            : SvgPicture.asset(
                                key: widget.questionKey,
                                ImageAssets.questionNavD,
                                width: 25,
                                height: 25,
                              ),
                        label: 'question'),
                    BottomNavigationBarItem(
                        icon: appController.navBarIndex.value == 2
                            ? SvgPicture.asset(
                                key: widget.favoriteKey,
                                ImageAssets.favoriteNavA,
                                width: 25,
                                height: 25,
                              )
                            : SvgPicture.asset(
                                key: widget.favoriteKey,
                                ImageAssets.favoriteNavD,
                                width: 25,
                                height: 25,
                              ),
                        label: 'favorite'),
                    BottomNavigationBarItem(
                        icon: appController.navBarIndex.value == 3
                            ? SvgPicture.asset(
                                key: widget.downloadKey,
                                ImageAssets.downloadNavA,
                                width: 25,
                                height: 25,
                              )
                            : SvgPicture.asset(
                                key: widget.downloadKey,
                                ImageAssets.downloadNavD,
                                width: 25,
                                height: 25,
                              ),
                        label: 'download'),
                  ],
                  currentIndex: appController.navBarIndex.value,
                  onTap: (index) {
                    switch (index) {
                      case 0:
                        appController.navBarIndex.value = 0;
                        Get.offAllNamed(AppRoutes.home);
                        break;
                      case 1:
                        appController.navBarIndex.value = 1;
                        Get.offAllNamed(AppRoutes.question);
                        break;
                      case 2:
                        appController.navBarIndex.value = 2;
                        Get.offAllNamed(AppRoutes.favorite);
                        break;
                      case 3:
                        appController.navBarIndex.value = 3;
                        Get.offAllNamed(AppRoutes.download);
                        break;
                    }
                  },
                ),
              ),
      );
    });
  }
}

Widget cancelFullScreen(Widget body) {
  AppController appController = Get.find();
  return Container(
    height: double.infinity,
    width: double.infinity,
    decoration: BoxDecoration(
        image: DecorationImage(
      image: AssetImage(ImageAssets.placeholderPng),
      fit: BoxFit.fill,
      // alignment: Alignment.bottomCenter,
      //opacity: 0.5,
    )),
    child: Stack(
      alignment: Alignment.topLeft,
      children: [
        body,
        if (appController.fullScreen.value)
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20),
            child: InkWell(
              onTap: () => appController.changeDefaultFullScreen(false),
              child: const Icon(
                Icons.cancel_outlined,
                color: DesignColors.gray2,
                size: 25,
              ),
            ),
          ),
      ],
    ),
  );
}
