import 'package:dr_alshaal/view/main/favorite/view_model/favorite_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/colors.dart';
import '../../../utils/buttons/customized_filled_button.dart';
import '../../../utils/buttons/customized_outlined_button.dart';
import '../../../utils/form_widgets/customized_text_form_field.dart';

class CreateFolderDialog extends StatelessWidget {
  CreateFolderDialog({Key? key}) : super(key: key);
  final FavoriteViewModel favoriteViewModel = Get.find();
  final TextEditingController folderController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Center(
        child: Text(
          'إنشاء مجموعة جديدة',
          style: TextStyle(color: DesignColors.brown, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(children: [
        const Text('أدخل اسم المجموعة'),
        Form(
            key: formKey,
            child: CustomizedTextFormField(
              controller: folderController,
              focusBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: DesignColors.primary),
              ),
              unFocusBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: DesignColors.primary),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "لا يمكن ان يكون اسم المجموعة فارغ";
                }
                return null;
              },
            )),
      ]),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomizedFilledButton(
                width: 100,
                text: 'حسنا',
                function: () {
                  if (formKey.currentState!.validate()) {
                    favoriteViewModel.createFolder(title: folderController.text);
                    Get.back();
                  }
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
