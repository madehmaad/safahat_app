import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../resources/assets_manager.dart';
import '../../../../resources/colors.dart';
import '../../../../resources/routes.dart';
import '../../../utils/widgets/empty_screen.dart';
import '../../material/view_model/material_view_model.dart';
import '../view_model/favorite_view_model.dart';
import 'create_folder_dialog.dart';
import 'delete_more_item_dialog.dart';
import 'favorite_card.dart';
import 'management_database.dart';

class AddFavoriteScreen extends StatelessWidget {
  final bool isAdd;
  AddFavoriteScreen({Key? key, required this.isAdd}) : super(key: key);
  final FavoriteViewModel favoriteViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (favoriteViewModel.currentId != null && !favoriteViewModel.isCheck.value)
                    IconButton(
                      onPressed: () {
                        favoriteViewModel.currentId = favoriteViewModel.getParentId();
                        favoriteViewModel.getAll();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: DesignColors.brown,
                      ),
                    ),
                  if ((favoriteViewModel.isCheck.value || favoriteViewModel.isMove.value) && !isAdd)
                    IconButton(
                      onPressed: () {
                        favoriteViewModel.isCheck.value = false;
                        favoriteViewModel.isMove.value = false;
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                        color: DesignColors.brown,
                      ),
                    ),
                  if (favoriteViewModel.isCheck.value && !isAdd)
                    IconButton(
                      onPressed: () {
                        favoriteViewModel.isMove.value = true;
                        favoriteViewModel.isCheck.value = false;
                      },
                      icon: const Icon(
                        Icons.drive_file_move_outline,
                        size: 30,
                        color: DesignColors.brown,
                      ),
                    ),
                  if (favoriteViewModel.isCheck.value && !isAdd)
                    IconButton(
                      onPressed: () {
                        Get.dialog(DeleteMoreItemDialog());
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 30,
                        color: DesignColors.brown,
                      ),
                    ),
                  if (favoriteViewModel.isMove.value && !isAdd)
                    IconButton(
                      onPressed: () {
                        favoriteViewModel.moveMoreFile();
                        favoriteViewModel.isMove.value = false;
                      },
                      icon: const Icon(
                        Icons.paste_outlined,
                        size: 30,
                        color: DesignColors.brown,
                      ),
                    ),
                  if (!favoriteViewModel.isCheck.value && !favoriteViewModel.isMove.value)
                    InkWell(
                        onTap: () {
                          Get.dialog(CreateFolderDialog());
                        },
                        child: SvgPicture.asset(
                          ImageAssets.createFolder,
                          width: 30,
                          height: 30,
                        )),
                  if (favoriteViewModel.currentId == null && !isAdd) ManagementDatabase(),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: favoriteViewModel.favorites.isEmpty
                  ? const EmptyScreen(title: 'لم يتم إضافة مواد للمفضلة لعرضها')
                  : ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (context, index) => const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Divider(height: 0, thickness: 1, color: DesignColors.gray2),
                          ),
                      itemCount: favoriteViewModel.favorites.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            if (favoriteViewModel.isCheck.value && !isAdd) {
                              favoriteViewModel.checked[index].isCheck = !favoriteViewModel.checked[index].isCheck;
                              favoriteViewModel.checked.refresh();
                            } else {
                              if (favoriteViewModel.favorites[index].isFolder) {
                                favoriteViewModel.currentId = favoriteViewModel.favorites[index].id;
                                favoriteViewModel.getAll();
                              } else if (!favoriteViewModel.favorites[index].isFolder && !isAdd) {
                                MaterialViewModel materialViewModel = Get.put(MaterialViewModel());
                                materialViewModel.materialSlug = favoriteViewModel.favorites[index].slug;
                                materialViewModel.getAllData();
                                Get.toNamed(AppRoutes.material);
                              }
                            }
                          },
                          onLongPress: () {
                            if (!favoriteViewModel.isMove.value && !isAdd) {
                              favoriteViewModel.getAll();
                              favoriteViewModel.isCheck.value = !favoriteViewModel.isCheck.value;
                            }
                          },
                          child: Row(
                            children: [
                              if (favoriteViewModel.isCheck.value)
                                Obx(
                                  () => Checkbox(
                                      checkColor: DesignColors.brown,
                                      activeColor: DesignColors.primary,
                                      value: favoriteViewModel.checked[index].isCheck,
                                      onChanged: (value) {
                                        favoriteViewModel.checked[index].isCheck = value!;
                                        favoriteViewModel.checked.refresh();
                                      }),
                                ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: FavoriteCard(
                                favorite: favoriteViewModel.favorites[index],
                                isAdd: isAdd,
                              )),
                            ],
                          ))),
            ),
          ),
        ],
      ),
    );
  }
}
