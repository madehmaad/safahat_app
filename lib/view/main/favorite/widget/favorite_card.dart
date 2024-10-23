import 'package:dr_alshaal/view/main/favorite/collection/favorite_collection.dart';
import 'package:dr_alshaal/view/main/favorite/widget/delete_item_dialog.dart';
import 'package:dr_alshaal/view/main/favorite/widget/update_title_dialog.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/env.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/colors.dart';
import '../view_model/favorite_view_model.dart';

class FavoriteCard extends StatelessWidget {
  final bool isAdd;
  final Favorite favorite;

  FavoriteCard({Key? key, required this.favorite, required this.isAdd})
      : super(key: key);
  final FavoriteViewModel favoriteViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(children: [
        if (!favorite.isFolder)
          FancyShimmerImage(
            imageUrl: favorite.imageUrl == null
                ? ''
                : Env.baseMediaUrl + favorite.imageUrl!,
            width: 60,
            height: 60,
            boxFit: BoxFit.cover,
            errorWidget: Container(
              color: Colors.grey[100],
              child: Image.asset(
                ImageAssets.logo,
                fit: BoxFit.cover,
              ),
            ),
          ),
        if (favorite.isFolder)
          const Icon(
            Icons.folder,
            size: 60,
            color: DesignColors.primary,
          ),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favorite.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: DesignColors.brown),
                ),
                if (favorite.isFolder)
                  Text(
                    "يحتوي على  ${favoriteViewModel.getChildrenNumber(id: favorite.id).toString()}  عنصر",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: DesignColors.black),
                  ),
              ],
            ),
          ),
        ),
        const Spacer(),
        if (!favoriteViewModel.isCheck.value &&
            !favoriteViewModel.isMove.value &&
            !isAdd)
          _showPopupMenu(context)
      ]),
    );
  }

  PopupMenuButton _showPopupMenu(context) {
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
            child: Row(
              children: [
                Icon(Icons.edit_note, size: 20, color: DesignColors.brown),
                SizedBox(
                  width: 10,
                ),
                Text("تعديل الاسم")
              ],
            ),
          ),
          // PopupMenuItem 2
          const PopupMenuItem(
            value: 2,
            child: Row(
              children: [
                Icon(Icons.delete, size: 20, color: DesignColors.brown),
                SizedBox(
                  width: 10,
                ),
                Text("حذف")
              ],
            ),
          ),
        ];
      },
      onSelected: (value) {
        switch (value) {
          case 1:
            Get.dialog(UpdateTitleDialog(favorite: favorite));
            break;
          case 2:
            Get.dialog(DeleteItemDialog(favorite: favorite));
            break;
        }
      },
    );
  }
}
