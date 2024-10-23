import 'package:dr_alshaal/view/main/favorite/view_model/favorite_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/colors.dart';
import '../../../utils/buttons/customized_filled_button.dart';
import '../../../utils/buttons/customized_outlined_button.dart';

class DeleteMoreItemDialog extends StatelessWidget {
  DeleteMoreItemDialog({Key? key}) : super(key: key);
  final FavoriteViewModel favoriteViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Center(
        child: Text(
          'هل تريد حذف الملفات المحددة',
          style: TextStyle(color: DesignColors.brown, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomizedFilledButton(
                width: 100,
                text: 'حسنا',
                function: () {
                  favoriteViewModel.deleteMoreFile();
                  Get.back();
                }),
            CustomizedOutlinedButton(
                width: 100,
                text: 'إلغاء',
                function: () {
                  Get.back();
                }),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
