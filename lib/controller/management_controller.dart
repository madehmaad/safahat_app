import 'package:get/get.dart';

class ManagementController {
  final mainLoading = false.obs;
  final actionLoading = false.obs;
  final paginationLoading = false.obs;
  final paginationLoadingOne = false.obs;

  String? message;
  bool status = false;

  setMainLoading(value) {
    mainLoading.value = value;
  }

  setActionLoading(value) {
    actionLoading.value = value;
  }

  setPaginationLoading(value) {
    paginationLoading.value = value;
  }

  setPaginationLoadingOne(value) {
    paginationLoadingOne.value = value;
  }

  get getMainLoading => mainLoading.value;

  get getActionLoading => actionLoading.value;

  get getPaginationLoading => paginationLoading.value;
  get getPaginationLoadingOne => paginationLoadingOne.value;
}
