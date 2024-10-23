import 'package:dr_alshaal/service/notification/push_notification.dart';

import 'local_notification.dart';

class NotificationService {
  @pragma('vm:entry-point')
  static Future<void> init() async {
    await LocalNotification.init();
    await PushNotification.init();
  }
}
