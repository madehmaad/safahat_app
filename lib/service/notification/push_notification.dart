import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_notification.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

class PushNotification {
  static Future<void> init() async {
    await Firebase.initializeApp();
    messaging.subscribeToTopic("dr_shaal_app");
    await setupPushNotification();
  }

  static Future setupPushNotification() async {
    /// handling foreground notifications
    await handlingForegroundNotifications();

    /// handling background or terminated notifications
    await handlingBackgroundNotifications();
  }

  static Future<void> handlingForegroundNotifications() async {
    ///1. setting foreground notifications
    await messaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

    ///2. listening to foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('****START: GOT A FOREGROUND NOTIFICATION!****');
      }
      LocalNotification.displayNotification(message);
      if (kDebugMode) {
        print('****END: GOT A FOREGROUND NOTIFICATION!****');
      }
    });
  }

  static Future<void> handlingBackgroundNotifications() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    DartPluginRegistrant.ensureInitialized();
    await Firebase.initializeApp();
    Get.put(await SharedPreferences.getInstance());
    if (kDebugMode) {
      print('****START: GOT A BACKGROUND NOTIFICATION!****');
    }
    LocalNotification.displayNotification(message);
    if (kDebugMode) {
      print('****END: GOT A BACKGROUND NOTIFICATION!****');
    }
  }
}
