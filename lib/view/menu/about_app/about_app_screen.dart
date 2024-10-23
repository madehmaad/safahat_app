import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/resources/routes.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:dr_alshaal/view/utils/widgets/base_scaffold.dart';
import 'package:dr_alshaal/view/utils/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/app_controller/app_controller.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: appBarCustom(
        title: 'about_app'.tr,
        backIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'app_version'.tr,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: DesignColors.brown),
                  ),
                  Text(
                    appController.appVersion,
                    style: const TextStyle(fontSize: 18, color: DesignColors.brown),
                  )
                ],
              ),
            ),
            thickDivider(),
            InkWell(
              onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'privacy_policy'.tr,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: DesignColors.brown),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, color: DesignColors.brown)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
