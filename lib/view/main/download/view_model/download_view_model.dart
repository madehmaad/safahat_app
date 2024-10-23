import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dr_alshaal/controller/management_controller.dart';
import 'package:dr_alshaal/view/main/download/collection/download_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as path;

import '../../../utils/widgets/snack_bar.dart';

class DownloadViewModel extends GetxService with ManagementController {
  final ReceivePort _port = ReceivePort();
  Isar isar = Get.find<Isar>();
  RxBool isCheck = false.obs;
  RxList<Download> downloads = List<Download>.empty(growable: true).obs;
  RxList<DownloadTask> tasks = List<DownloadTask>.empty(growable: true).obs;
  RxList<DownloadCheckBox> checked =
      List<DownloadCheckBox>.empty(growable: true).obs;

  @override
  onInit() async {
    getAll();
    await getAllTask();
    listenToIsolate();
    super.onInit();
  }

  listenToIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      if (kDebugMode) {
        print(' ************ try to register again ************');
      }
      IsolateNameServer.removePortNameMapping('downloader_send_port');
      listenToIsolate();
    } else {
      _port.listen((dynamic data) {
        if (kDebugMode) {
          print('-------------------------$data -------------------------');
        }
        getAllTask();
      });
    }
  }

  @override
  void onClose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  getAllTask() async {
    var tempTasks = await FlutterDownloader.loadTasks();
    List<DownloadTask> temp = [];
    tempTasks?.forEach((element) {
      if (element.status == DownloadTaskStatus.complete) {
        moveRecordFromTempToDB(taskId: element.taskId);
      }
      if (element.status != DownloadTaskStatus.complete &&
          element.status != DownloadTaskStatus.canceled) {
        if (!ahadeth.contains(element.filename)) {
          temp.add(element);
        }
      }
    });
    tasks.value = temp;
  }

  void deleteFileFromStorage(String path) {
    File file = File(path);
    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  deleteTask(String taskId) async {
    await FlutterDownloader.remove(taskId: taskId);
    Download? temp =
        progressTasks.firstWhereOrNull((element) => element.taskId == taskId);
    progressTasks.remove(temp);
    deleteFileFromStorage('${temp!.filePath}/${path.basename(temp.url!)}');
    getAllTask();
  }

  pauseTask(String taskId) async {
    await FlutterDownloader.pause(taskId: taskId);
  }

  resumeTask(String taskId) async {
    String? newTaskId = await FlutterDownloader.resume(taskId: taskId);
    if (newTaskId != null) {
      updateTaskId(oldTaskId: taskId, newTaskId: newTaskId);
    }
  }

  retryTask(String taskId) async {
    String? newTaskId = await FlutterDownloader.retry(taskId: taskId);
    if (newTaskId != null) {
      updateTaskId(oldTaskId: taskId, newTaskId: newTaskId);
    }
  }

  updateTaskId({required String oldTaskId, required String newTaskId}) {
    int i = progressTasks.indexWhere((element) => element.taskId == oldTaskId);
    if (i != -1) {
      progressTasks[i].taskId = newTaskId;
    }
  }

  Download? getRecordDataByTaskId({required String taskId}) {
    return progressTasks
        .firstWhereOrNull((element) => element.taskId == taskId);
  }

  moveRecordFromTempToDB({required String taskId}) {
    Download? temp =
        progressTasks.firstWhereOrNull((element) => element.taskId == taskId);
    if (temp != null) {
      successSnackBar(message: 'تم الانتهاء من التحميل');
      addMaterial(
          name: temp.name,
          slug: temp.slug,
          filePath: temp.filePath,
          imageUrl: temp.imageUrl,
          downloadAt: temp.downloadAt,
          size: temp.size,
          url: temp.url,
          materialTitle: temp.materialTitle,
          prefix: temp.prefix);
      progressTasks.remove(temp);
    }
  }

  deleteFile({required int id}) async {
    var download = isar.downloads.filter().idEqualTo(id).findFirstSync();
    await isar.writeTxn(() async {
      await isar.downloads.delete(id);
    });

    try {
      deleteFileFromStorage(
          '${download!.filePath}/${path.basename(download.url!)}');
    } catch (e) {
      if (kDebugMode) {
        print('error on delete $e');
      }
    }
    getAll();
  }

  deleteMoreFile() async {
    for (int i = 0; i < checked.length; i++) {
      if (checked[i].isCheck) {
        await isar.writeTxn(() async {
          await isar.downloads.delete(checked[i].download.id);
        });
      }
    }
    isCheck.value = false;
    getAll();
  }

  getAll() {
    downloads.value = isar.downloads.filter().idGreaterThan(0).findAllSync();
    checked.clear();
    downloads
        .map((element) => checked.add(DownloadCheckBox(false, element)))
        .toList();
  }

  addMaterial(
      {required String name,
      required String slug,
      String? imageUrl,
      required String filePath,
      String? downloadAt,
      String? materialTitle,
      String? url,
      int? size,
      String? prefix}) async {
    final download = Download()
      ..name = name
      ..slug = slug
      ..imageUrl = imageUrl
      ..filePath = filePath
      ..prefix = prefix
      ..size = size
      ..url = url
      ..materialTitle = materialTitle
      ..downloadAt = downloadAt;

    isar.writeTxnSync(() {
      isar.downloads.putSync(download);
    });
    getAll();
  }

  bool canDownload(String name, String type) {
    int index = progressTasks.indexWhere(
        (element) => (element.name == name && element.prefix == type));
    Download? download = isar.downloads
        .filter()
        .nameEqualTo(name)
        .prefixEqualTo(type)
        .findFirstSync();
    if (index != -1 || download != null) {
      return false;
    }
    return true;
  }
}

class DownloadCheckBox {
  bool isCheck = false;
  late Download download;

  DownloadCheckBox(this.isCheck, this.download);
}

RxList<Download> progressTasks = List<Download>.empty(growable: true).obs;
List<String> ahadeth = [
  'sunan_abn_majah.pdf',
  'sunan_abu_dawud.pdf',
  'sunan_altirmidhii.pdf',
  'sunan_alnasayi.pdf',
  'sahih_albukharii.pdf',
  'sahih_muslim.pdf',
  'muataa_malik.pdf'
];
