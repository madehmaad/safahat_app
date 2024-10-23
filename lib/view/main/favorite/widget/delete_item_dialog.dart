import 'package:dr_alshaal/view/main/favorite/view_model/favorite_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/colors.dart';
import '../../../utils/buttons/customized_filled_button.dart';
import '../../../utils/buttons/customized_outlined_button.dart';
import '../collection/favorite_collection.dart';

class DeleteItemDialog extends StatelessWidget {
  final Favorite favorite;

  DeleteItemDialog({Key? key, required this.favorite}) : super(key: key);
  final FavoriteViewModel favoriteViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Center(
        child: Text(
          'هل انت متأكد من الحذف',
          style: TextStyle(color: DesignColors.brown, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      content: Center(child: Text(favorite.title)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomizedFilledButton(
                width: 100,
                text: 'حسنا',
                function: () {
                  favoriteViewModel.deleteFile(id: favorite.id);
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
