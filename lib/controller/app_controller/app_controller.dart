import 'package:dr_alshaal/config/functions.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppController extends GetxController with GetxServiceMixin {
  final navBarIndex = 0.obs;
  final fullScreen = false.obs;
  RxBool isAutoPlay = false.obs;
  late String appVersion;
  RxDouble fontSize = 12.0.obs;
  RxString selectedDownloadDirectory = ''.obs;
  RxBool drawerState = false.obs;
  RxBool closeDrawer = false.obs;
  final navBarIsVisible = true.obs;

  @override
  onInit() async {
    await getAppVersion();
    await getDefaultFontSize();
    await getDefaultAutoPlayMedia();
    await getDefaultDownloadDirectory();
    await getDefaultFullScreen();
    super.onInit();
  }

  changeNavBarIndex(int index) {
    navBarIndex.value = index;
  }

  getDefaultFullScreen() {
    bool value = getFullScreen();
    fullScreen.value = value;
  }

  changeDefaultFullScreen(bool value) {
    setFullScreen(value);
    fullScreen.value = value;
  }

  getDefaultFontSize() {
    var value = getFontSize();
    fontSize.value = value;
  }

  changeFontSize(double size) {
    setFontSize(size);
    fontSize.value = size;
  }

  getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
  }

  getDefaultAutoPlayMedia() {
    bool value = getAutoPlayMedia();
    isAutoPlay.value = value;
  }

  changeAutoPlayMedia(bool value) {
    changeAutoPlay(value);
    isAutoPlay.value = value;
  }

  getDefaultDownloadDirectory() async {
    String path = await getDownloadDirectory();
    selectedDownloadDirectory.value = path;
  }

  changeDownloadDirectoryPath(String path) {
    changeDownloadDirectory(path);
    selectedDownloadDirectory.value = path;
  }

  changeDrawerState() {
    drawerState.value = !drawerState.value;
  }

  closeDrawerState() {
    closeDrawer.value = !closeDrawer.value;
  }
}
