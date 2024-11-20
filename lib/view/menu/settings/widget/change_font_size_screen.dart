import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/view/utils/widgets/app_bar.dart';
import 'package:dr_alshaal/view/utils/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/colors.dart';

class ChangeFontSizeScreen extends StatelessWidget {
  ChangeFontSizeScreen({Key? key}) : super(key: key);
  final AppController appController = Get.find();
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBar: appBarCustom(title: 'default_font_size'.tr, backIcon: true),
        body: Obx(() => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'change_font_size'.tr,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Slider(
                      value: appController.fontSize.value,
                      thumbColor: DesignColors.primary,
                      activeColor: Colors.blue,
                      inactiveColor: DesignColors.gray2,
                      max: 40,
                      min: 5,
                      onChanged: (value) {
                        appController.changeFontSize(value.toDouble());
                      }),
                  Text(
                    appController.fontSize.value.toStringAsFixed(0),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.65,
                    child: SingleChildScrollView(
                      child: Text(
                        'جميع الحقوق محفوظة موقع الشيخ الطبيب محمد خير الشعال - يمنع المتاجرة بأي مادة بقصد الربح، ويسمح بالنسخ و التوزيع بقصد الدعوة.',
                        style:
                            TextStyle(fontSize: appController.fontSize.value),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
