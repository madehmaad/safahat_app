import 'dart:async';
import 'dart:io';
import 'package:dr_alshaal/resources/colors.dart';
import 'package:dr_alshaal/resources/routes.dart';
import 'package:dr_alshaal/service/app_service.dart';
import 'package:dr_alshaal/service/bindings/app_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'config/functions.dart';
import 'lang/locale.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => AppService().init());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    const tabletOrientation = [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ];
    const mobileOrientation = [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ];
    SystemChrome.setPreferredOrientations(
        isTablet() ? tabletOrientation : mobileOrientation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: GetMaterialApp(
        initialBinding: AppBinding(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ar')],
        locale: const Locale('ar'),
        translations: Language(),
        getPages: AppPages.pages,
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Sukar',
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: DesignColors.primary,
          ),
          primarySwatch: DesignColors.whitePrimarySwatch,
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
