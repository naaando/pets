import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../notifications.dart';
import 'package:timezone/timezone.dart' as tz;

part 'alarm_provider.g.dart';

@riverpod
class Alarms extends _$Alarms {
  @override
  FutureOr<List<dynamic>> build() async {
    return [];
  }

  Future<void> add(
    int id,
    String notificationTitle,
    String notificationBody,
    DateTime dateTime,
  ) async {
    state = const AsyncValue.loading();

    var diff = dateTime.difference(DateTime.now()).inSeconds;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      notificationTitle,
      notificationBody,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: diff)),
      const NotificationDetails(
        android: androidNotificationDetails,
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    state = await AsyncValue.guard(() async => []);
  }
}
