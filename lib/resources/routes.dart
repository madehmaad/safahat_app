import 'package:dr_alshaal/view/drawer/drawer_screen.dart';
import 'package:dr_alshaal/view/main/ahadeth/ahadeth_screen.dart';
import 'package:dr_alshaal/view/main/download/download_screen.dart';
import 'package:dr_alshaal/view/main/favorite/favorite_screen.dart';
import 'package:dr_alshaal/view/main/home/home_screen.dart';
import 'package:dr_alshaal/view/main/live_stream/live_stream_screen.dart';
import 'package:dr_alshaal/view/main/notification/notification_screen.dart';
import 'package:dr_alshaal/view/main/search/search_screen.dart';
import 'package:dr_alshaal/view/menu/about_app/about_app_screen.dart';
import 'package:dr_alshaal/view/menu/privacy_policy/privacy_policy_screen.dart';
import 'package:dr_alshaal/view/menu/settings/settings_screen.dart';
import 'package:dr_alshaal/view/menu/settings/widget/change_font_size_screen.dart';
import 'package:get/get.dart';

import '../view/main/document_viewer/document_local_viewer_screen.dart';
import '../view/main/document_viewer/document_network_viewer_screen.dart';
import '../view/main/material/material_screen.dart';
import '../view/main/materials/materials_screen.dart';
import '../view/main/notification/notification_details_screen.dart';
import '../view/main/player/local_player_screen.dart';
import '../view/main/player/network_player_screen.dart';
import '../view/main/question/question_category_screen.dart';
import '../view/main/question/question_details_screen.dart';
import '../view/main/question/question_list_screen.dart';
import '../view/main/series/series_screen.dart';
import '../view/menu/contact_us/contact_us_screen.dart';
import '../view/splash/splash_screen.dart';
//GetPage(name: '/main', page: () => DrawerScreen(body: const MainScreen())),

class AppPages {
  static List<GetPage<dynamic>> pages = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/home', page: () => const DrawerScreen(body: HomeScreen())),
    GetPage(
        name: '/question',
        page: () => DrawerScreen(body: QuestionCategoryScreen())),
    GetPage(
        name: '/download',
        page: () => const DrawerScreen(body: DownloadScreen())),
    GetPage(
        name: '/favorite',
        page: () => const DrawerScreen(body: FavoriteScreen())),
    GetPage(name: '/live_stream', page: () => const LiveStreamScreen()),
    GetPage(name: '/about_app', page: () => const AboutAppScreen()),
    GetPage(name: '/contact_us', page: () => const ContactUsScreen()),
    GetPage(name: '/privacy_policy', page: () => const PrivacyPolicyScreen()),
    GetPage(name: '/settings', page: () => const SettingsScreen()),
    GetPage(name: '/search', page: () => const SearchScreen()),
    GetPage(name: '/notification', page: () => const NotificationScreen()),
    GetPage(
        name: '/notification_details', page: () => NotificationDetailsScreen()),
    GetPage(name: '/change_font', page: () => ChangeFontSizeScreen()),
    GetPage(name: '/series', page: () => const SeriesScreen()),
    GetPage(name: '/materials', page: () => const MaterialsScreen()),
    GetPage(name: '/ahadeth', page: () => const AhadethScreen()),
    GetPage(name: '/material', page: () => const MaterialScreen()),
    GetPage(name: '/network_player', page: () => const NetworkPlayerScreen()),
    GetPage(name: '/local_player', page: () => const LocalPlayerScreen()),
    GetPage(
        name: '/network_document', page: () => DocumentNetworkViewerScreen()),
    GetPage(name: '/local_document', page: () => DocumentLocalViewerScreen()),
    GetPage(
        name: '/question_list',
        page: () {
          return QuestionListScreen(
            isSub: Get.arguments[0] == 'sub' ? true : false,
          );
        }),
    GetPage(
        name: '/question_details',
        page: () => QuestionDetailsScreen(
              isSub: Get.arguments[0] == 'sub' ? true : false,
            )),
  ];
}

class AppRoutes {
  static String splash = '/';
  static String main = '/main';
  static String home = '/home';
  static String favorite = '/favorite';
  static String download = '/download';
  static String question = '/question';
  static String liveStream = '/live_stream';
  static String aboutApp = '/about_app';
  static String contactUs = '/contact_us';
  static String settings = '/settings';
  static String search = '/search';
  static String notification = '/notification';
  static String notificationDetails = '/notification_details';
  static String changeFont = '/change_font';
  static String series = '/series';
  static String privacyPolicy = '/privacy_policy';
  static String materials = '/materials';
  static String material = '/material';
  static String ahadeth = '/ahadeth';
  static String ahadethDetails = '/ahadeth_details';
  static String networkPlayer = '/network_player';
  static String localPlayer = '/local_player';
  static String networkDoc = '/network_document';
  static String localDoc = '/local_document';
  static String questionList = '/question_list';
  static String questionDetails = '/question_details';
}
