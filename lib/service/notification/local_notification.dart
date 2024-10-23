import 'dart:convert';
import 'dart:io';

import 'package:dr_alshaal/resources/routes.dart';
import 'package:dr_alshaal/service/notification/push_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../models/notification/notification.dart';
import '../../resources/colors.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'Dr-Shaal',
  'Dr-Shaal',
  importance: Importance.max,
);

class LocalNotification {
  static Future<void> init() async {
    await setupLocalNotification();
  }

  static Future<void> setupLocalNotification() async {
    /// 1. set the AndroidInitializationSettings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/notification');

    /// 2. set the IOSInitializationSettings
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
            onDidReceiveLocalNotification: null);

    /// 3. set the InitializationSettings
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);

    /// 4. initialize FlutterLocalNotificationsPlugin
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    /// create custom channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(channel);

    final enabled = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .areNotificationsEnabled();
    if (!(enabled ?? false)) {
      final plugin =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (plugin != null) {
        // await plugin.requestPermission();
      } else {
        await iosNotificationPermission();
      }
    }
  }

  /// a function to request ios permission for receiving notifications
  static Future<void> iosNotificationPermission() async {
    if (Platform.isIOS) {
      NotificationSettings settings = await messaging.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true);

      if (kDebugMode)
        print('User granted permission: ${settings.authorizationStatus}');
    }
  }

  /// if press on notification on foreground or background
  static void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
      NotificationModel notificationModel =
          NotificationModel.fromJson(jsonDecode(payload!));
      Get.toNamed(AppRoutes.notification);
    }
  }

  /// detect if app opened by selecting a notification
  /// return selected notification payload
  Future<String?> didNotificationLaunchApp() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    return notificationAppLaunchDetails?.notificationResponse?.payload;
  }

  /// a function to display notifications
  static void displayNotification(RemoteMessage message) {
    if (kDebugMode) {
      print('Message data: ${message.data}');
      print('Message notification title: ${message.data['title']}');
      print('Message notification body: ${message.data['body_message']}');
    }
    NotificationModel notificationObj =
        NotificationModel.fromJson(message.data);

    _showNotification(notificationObj);
  }

  static Future<void> _showNotification(NotificationModel notification) async {
    /// 1. set AndroidNotificationDetails
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channel.id, channel.name,
            color: DesignColors.primary,
            styleInformation: const BigTextStyleInformation('',
                htmlFormatBigText: true,
                htmlFormatContent: true,
                htmlFormatContentTitle: true,
                htmlFormatSummaryText: true));

    /// 2. set IOSNotificationDetails
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            sound: 'default',
            badgeNumber: 0,
            attachments: [],
            subtitle: null,
            threadIdentifier: '');

    /// 3. set NotificationDetails
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    String payload = jsonEncode(notification.toJson());
    flutterLocalNotificationsPlugin.show(
      num.parse(notification.id).toInt(),
      notification.title,
      notification.body,
      notificationDetails,
      payload: payload, // this payload will be sent to selectNotification
    );
  }
}
