import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../menu/menu_screen.dart';

class DrawerScreen extends StatefulWidget {
  final Widget body;
  const DrawerScreen({Key? key, required this.body}) : super(key: key);

  @override
  State<DrawerScreen> createState() => DrawerScreenState();
}

class DrawerScreenState extends State<DrawerScreen> {
  AppController appController = Get.find();
  final zoomDrawerController = ZoomDrawerController();
  @override
  void initState() {
    appController.drawerState.listen((value) {
      zoomDrawerController.toggle?.call();
    });
    appController.closeDrawer.listen((value) {
      zoomDrawerController.close?.call();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: DesignColors.primary,
        child: ZoomDrawer(
          controller: zoomDrawerController,
          menuScreen: MenuScreen(),
          mainScreen: widget.body,
          androidCloseOnBackTap: true,
          borderRadius: 24.0,
          showShadow: true,
          isRtl: true,
          angle: 0,
          mainScreenTapClose: true,
          menuScreenTapClose: true,
          style: DrawerStyle.defaultStyle,
          drawerShadowsBackgroundColor: Colors.white,
          slideWidth: 300,
        ),
      ),
    );
  }
}
