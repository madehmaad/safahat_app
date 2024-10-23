import 'package:dr_alshaal/controller/app_controller/app_controller.dart';
import 'package:dr_alshaal/view/main/favorite/view_model/favorite_view_model.dart';
import 'package:dr_alshaal/view/main/question/view_model/question_view_model.dart';
import 'package:get/get.dart';

import '../../view/main/download/view_model/download_view_model.dart';
import '../../view/main/home/view_model/home_view_model.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppController(), fenix: true);
    Get.lazyPut(() => HomeViewModel(), fenix: true);
    Get.lazyPut(() => QuestionViewModel(), fenix: true);
    Get.lazyPut(() => FavoriteViewModel(), fenix: true);
    Get.put(DownloadViewModel(), permanent: true);
  }
}
