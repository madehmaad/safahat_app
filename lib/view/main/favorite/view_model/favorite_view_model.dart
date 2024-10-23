import 'dart:io';

import 'package:dr_alshaal/controller/management_controller.dart';
import 'package:dr_alshaal/view/main/download/view_model/download_view_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../download/collection/download_collection.dart';
import '../collection/favorite_collection.dart';

class FavoriteViewModel extends GetxService with ManagementController {
  var isar = Get.find<Isar>();
  int? currentId;
  RxBool isCheck = false.obs;
  RxBool isMove = false.obs;
  late RxList<Favorite> favorites = List<Favorite>.empty(growable: true).obs;
  RxList<FavoriteCheckBox> checked = List<FavoriteCheckBox>.empty(growable: true).obs;

  @override
  onInit() {
    getAll();
    super.onInit();
  }

  createFolder({required String title}) async {
    if (currentId == null) {
      final favorite = Favorite()
        ..title = title
        ..isFolder = true
        ..isRoot = true;
      await isar.writeTxn(() async {
        await isar.favorites.put(favorite);
      });
    } else {
      final favorite = isar.favorites.filter().idEqualTo(currentId!).findFirstSync();
      final child = Favorite()
        ..title = title
        ..isFolder = true
        ..isRoot = false;

      await isar.writeTxn(() async {
        await isar.favorites.put(child);
        favorite!.children.add(child);
        await favorite.children.save();
      });
    }
    getAll();
  }

  deleteFile({required int id}) async {
    await isar.writeTxn(() async {
      await isar.favorites.delete(id);
    });
    getAll();
  }

  deleteMoreFile() async {
    for (int i = 0; i < checked.length; i++) {
      if (checked[i].isCheck) {
        await isar.writeTxn(() async {
          await isar.favorites.delete(checked[i].favorite.id);
        });
      }
    }
    isCheck.value = false;
    getAll();
  }

  moveMoreFile() async {
    for (int i = 0; i < checked.length; i++) {
      if (checked[i].isCheck) {
        if (currentId == null) {
          final children = checked[i].favorite.children.filter().findAllSync();
          final favorite = Favorite()
            ..isRoot = true
            ..slug = checked[i].favorite.slug
            ..imageUrl = checked[i].favorite.imageUrl
            ..isFolder = checked[i].favorite.isFolder
            ..title = checked[i].favorite.title;

          await isar.writeTxn(() async {
            await isar.favorites.put(favorite);
            await isar.favorites.delete(checked[i].favorite.id);
          });

          for (int j = 0; j < children.length; j++) {
            await isar.writeTxn(() async {
              await isar.favorites.put(children.elementAt(j));
              favorite.children.add(children.elementAt(j));
              await favorite.children.save();
            });
          }
        } else {
          final parent = isar.favorites.filter().idEqualTo(currentId!).findFirstSync();
          final children = checked[i].favorite.children.filter().findAllSync();
          final favorite = Favorite()
            ..isRoot = false
            ..slug = checked[i].favorite.slug
            ..imageUrl = checked[i].favorite.imageUrl
            ..isFolder = checked[i].favorite.isFolder
            ..title = checked[i].favorite.title;

          await isar.writeTxn(() async {
            await isar.favorites.put(favorite);
            parent?.children.add(favorite);
            await parent?.children.save();
            await isar.favorites.delete(checked[i].favorite.id);
          });

          for (int j = 0; j < children.length; j++) {
            await isar.writeTxn(() async {
              await isar.favorites.put(children.elementAt(j));
              favorite.children.add(children.elementAt(j));
              await favorite.children.save();
            });
          }
        }
      }
    }
    getAll();
  }

  getAll() async {
    if (currentId == null) {
      favorites.value = isar.favorites.filter().isRootEqualTo(true).findAllSync();
      if (!isMove.value) {
        checked.clear();
        favorites.map((element) => checked.add(FavoriteCheckBox(false, element))).toList();
      }
    } else {
      final favorite = isar.favorites.filter().idEqualTo(currentId!).findFirstSync();
      favorites.value = favorite!.children.toList();
      if (!isMove.value) {
        checked.clear();
        favorites.map((element) => checked.add(FavoriteCheckBox(false, element))).toList();
      }
    }
  }

  addMaterial({required String title, required String slug, String? imageUrl}) async {
    if (currentId == null) {
      final favorite = Favorite()
        ..title = title
        ..slug = slug
        ..imageUrl = imageUrl
        ..isRoot = true
        ..isFolder = false;
      await isar.writeTxn(() async {
        await isar.favorites.put(favorite);
      });
    } else {
      final favorite = isar.favorites.filter().idEqualTo(currentId!).findFirstSync();
      final child = Favorite()
        ..title = title
        ..isFolder = false
        ..slug = slug
        ..imageUrl = imageUrl
        ..isRoot = false;

      await isar.writeTxn(() async {
        await isar.favorites.put(child);
        favorite!.children.add(child);
        await favorite.children.save();
      });
    }
    getAll();
  }

  updateTitleItem({required Favorite item, required String title}) async {
    item.title = title;
    await isar.writeTxn(() async {
      await isar.favorites.put(item);
    });
    getAll();
  }

  int? getParentId() {
    return isar.favorites.filter().children((q) => q.idEqualTo(currentId!)).findFirstSync()?.id;
  }

  int getChildrenNumber({required int id}) {
    return isar.favorites.filter().idEqualTo(id).findFirstSync()?.children.countSync() ?? 0;
  }

  exportDataBase({required String directoryPath}) async {

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd-HH-MM-ss').format(now);
   await isar.copyToFile('$directoryPath/alshaal($formattedDate).isar');
  }

  importDataBase({required String filePath}) async {
    final dir = await getApplicationSupportDirectory();
    final isarBackup = await Isar.open(
      [FavoriteSchema, DownloadSchema],
      directory: path.dirname(filePath),
      name: path.basename(filePath).replaceAll(".isar", ""),
      inspector: true,
    );
    String isarPath = isar.path.toString();
    await isar.close();
    await File(isarPath).delete();
    await isarBackup.writeTxn(() async => await isarBackup.copyToFile(isarPath));
    await isarBackup.close();
    isar = await Isar.open(
      [FavoriteSchema, DownloadSchema],
      directory: dir.path,
      inspector: true,
      name: "al_shaal",
    );
    DownloadViewModel downloadViewModel = Get.find();
    downloadViewModel.isar = isar;
    getAll();
  }
}

class FavoriteCheckBox {
  bool isCheck = false;
  late Favorite favorite;

  FavoriteCheckBox(this.isCheck, this.favorite);
}
