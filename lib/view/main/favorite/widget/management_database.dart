import 'package:dr_alshaal/view/main/favorite/view_model/favorite_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/functions.dart';
import '../../../../resources/colors.dart';

class ManagementDatabase extends StatelessWidget {
  ManagementDatabase({Key? key}) : super(key: key);
  final FavoriteViewModel favoriteViewModel = Get.find();

  Future<void> pickDirectory() async {
   bool status= await checkPermission();
   if(status){
     String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
     if (selectedDirectory != null) {
       favoriteViewModel.exportDataBase(directoryPath: selectedDirectory);
     }
   }

  }

  Future<void> pickFile() async {
    FilePickerResult? selectedFile = await FilePicker.platform.pickFiles();
    if (selectedFile != null) {
      favoriteViewModel.importDataBase(filePath: selectedFile.paths[0]!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(
          Icons.more_vert_sharp,
          color: DesignColors.brown,
        ),
        offset: const Offset(0, 50), //add offset to fix it
        itemBuilder: (context) {
          return [
            const PopupMenuItem(
              value: 1,
              child: Text("تصدير البيانات"),
            ),
            // PopupMenuItem 2
            const PopupMenuItem(
              value: 2,
              child: Text("استيراد البيانات"),
            ),
          ];
        },
        onSelected: (value) {
          if (value == 1) {
            pickDirectory();
          }
          if (value == 2) {
            pickFile();
          }
        });
  }
}
