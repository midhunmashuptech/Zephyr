// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:flutter_timezone/flutter_timezone.dart';

// class NotificationService {
//   final notificationPlugin = FlutterLocalNotificationsPlugin();
//   bool _isInitialized = false;
//   bool get isInitialized => _isInitialized;

//   Future<void> initNotification() async {
//     if (_isInitialized) return;

//     tz.initializeTimeZones();

//     String currentTimeZone = await FlutterTimezone.getLocalTimezone();

//     // Fix known deprecated or invalid timezone names
//     if (currentTimeZone == "Asia/Calcutta") {
//       currentTimeZone = "Asia/Kolkata";
//     }

//     try {
//       tz.setLocalLocation(tz.getLocation(currentTimeZone));
//     } catch (e) {
//       // Fallback to a safe default if something goes wrong
//       print("Unknown timezone: $currentTimeZone, defaulting to UTC");
//       tz.setLocalLocation(tz.getLocation("UTC"));
//     }

//     const initSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const initSettingsIOS = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     const initSettings = InitializationSettings(
//         android: initSettingsAndroid, iOS: initSettingsIOS);

//     await notificationPlugin.initialize(initSettings);

//     // Request permissions for Android 13+
//     await notificationPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestNotificationsPermission();

//     // Request exact alarm permission for Android 12+
//     await notificationPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestExactAlarmsPermission();

//     await notificationPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );

//     _isInitialized = true;
//   }

//   NotificationDetails notificationDetails() {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'daily_channel_id',
//         'Daily Notifications',
//         channelDescription: 'Daily Notification Channel',
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//       iOS: DarwinNotificationDetails(),
//     );
//   }

//   Future<void> showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//   }) async {
//     return notificationPlugin.show(id, title, body, notificationDetails());
//   }

//   Future<void> scheduleNotification({
//     int id = 0,
//     required String title,
//     required String body,
//     required int hour,
//     required int minute,
//   }) async {
//     final now = tz.TZDateTime.now(tz.local);


//     // 5 minutes from now
//     var scheduledDate = now.add(Duration(minutes: 3));

//     // Create scheduled date
//     // var scheduledDate =
//     //     tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

//     // If the scheduled time is in the past, schedule for tomorrow
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }

//     await notificationPlugin.zonedSchedule(
//       id + hour,
//       title,
//       body,
//       scheduledDate,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'reminder_channel',
//           'Reminders',
//           channelDescription: 'Reminder notifications',
//           importance: Importance.max,
//           priority: Priority.high,
//           ticker: 'ticker',
//           showWhen: true,
//           enableVibration: true,
//           playSound: true,
//           autoCancel: false,
//           ongoing: false,
//           visibility: NotificationVisibility.public,
//         ),
//         iOS: DarwinNotificationDetails(
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         ),
//       ),
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     );

//     print("Notification scheduled for: $scheduledDate");

//     // Test with immediate notification to verify setup
//     if (scheduledDate.difference(now).inMinutes < 2) {
//       print("Scheduling test notification in 10 seconds...");
//       await notificationPlugin.zonedSchedule(
//         999,
//         "Live Class Notification Created",
//         "You will be notified 10 minutes before it starts",
//         now.add(const Duration(seconds: 10)),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'test_channel',
//             'Test Notifications',
//             importance: Importance.max,
//             priority: Priority.high,
//           ),
//         ),
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       );
//     }
//   }

//   Future<void> cancelNotification(int id) async {
//     await notificationPlugin.cancel(id);
//   }

//   Future<void> cancelAllNotifications() async {
//     await notificationPlugin.cancelAll();
//   }

//   Future<List<PendingNotificationRequest>> getPendingNotifications() async {
//     return await notificationPlugin.pendingNotificationRequests();
//   }
// }
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final notificationPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    // Initialize timezone database
    tzdata.initializeTimeZones();

    // Get device timezone
    String currentTimeZone = await FlutterTimezone.getLocalTimezone();

    // Fix known deprecated timezone names
    if (currentTimeZone == "Asia/Calcutta") {
      currentTimeZone = "Asia/Kolkata";
    }

    try {
      tz.setLocalLocation(tz.getLocation(currentTimeZone));
    } catch (e) {
      print("Unknown timezone: $currentTimeZone, defaulting to UTC");
      tz.setLocalLocation(tz.getLocation("UTC"));
    }

    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final initSettings = InitializationSettings(
      android: initSettingsAndroid, 
      iOS: initSettingsIOS
    );

    // Initialize with callback for when notification is tapped
    await notificationPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle notification tap
        print('Notification tapped: ${response.payload}');
      },
    );

    // Request notification permission (Android 13+)
    final androidImplementation = notificationPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    
    if (androidImplementation != null) {
      await androidImplementation.requestNotificationsPermission();
      await androidImplementation.requestExactAlarmsPermission();
      
      // Create notification channel
      await androidImplementation.createNotificationChannel(
        const AndroidNotificationChannel(
          'reminder_channel',
          'Reminders',
          description: 'Reminder notifications',
          importance: Importance.max,
          enableVibration: true,
          playSound: true,
        ),
      );
    }

    // iOS permissions
    await notificationPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    _isInitialized = true;
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'reminder_channel',
        'Reminders',
        channelDescription: 'Reminder notifications',
        importance: Importance.max,
        priority: Priority.high,
        enableVibration: true,
        playSound: true,
        autoCancel: true,
        ongoing: false,
        visibility: NotificationVisibility.public,
        // Add these for better background handling
        showWhen: true,
        ticker: 'Reminder',
        styleInformation: BigTextStyleInformation(''),
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  /// Show immediate notification
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return notificationPlugin.show(
      id, 
      title, 
      body, 
      notificationDetails(),
      payload: payload,
    );
  }

  /// Schedule by exact time
  Future<void> scheduleNotification({
    int id = 0,
    required String title,
    required String body,
    required int hour,
    required int minute,
    String? payload,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _zonedSchedule(id, title, body, scheduledDate, payload);
  }

  /// Schedule X minutes from now
  Future<void> scheduleNotificationInMinutes({
    int id = 0,
    required String title,
    required String body,
    required int minutesFromNow,
    String? payload,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = now.add(Duration(minutes: minutesFromNow));
    await _zonedSchedule(id, title, body, scheduledDate, payload);
  }

  Future<void> _zonedSchedule(
    int id, 
    String title, 
    String body, 
    tz.TZDateTime scheduledDate,
    String? payload,
  ) async {
    await notificationPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminders',
          channelDescription: 'Reminder notifications',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'Reminder',
          showWhen: true,
          enableVibration: true,
          playSound: true,
          autoCancel: true,
          ongoing: false,
          visibility: NotificationVisibility.public,
          // These settings help with background delivery
          fullScreenIntent: false,
          category: AndroidNotificationCategory.reminder,
          styleInformation: BigTextStyleInformation(''),
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          categoryIdentifier: 'reminder',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );

    print("Notification scheduled for: $scheduledDate (ID: $id)");
    
    // Log all pending notifications for debugging
    final pending = await getPendingNotifications();
    print("Total pending notifications: ${pending.length}");
    for (var notification in pending) {
      print("- ID: ${notification.id}, Title: ${notification.title}");
    }
  }

  Future<void> cancelNotification(int id) async {
    await notificationPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await notificationPlugin.cancelAll();
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await notificationPlugin.pendingNotificationRequests();
  }

  /// Check if exact alarm permission is granted (Android 12+)
  Future<bool> isExactAlarmPermissionGranted() async {
    final androidImplementation = notificationPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    
    if (androidImplementation != null) {
      return await androidImplementation.canScheduleExactNotifications() ?? false;
    }
    return true; // Assume granted for non-Android platforms
  }
}