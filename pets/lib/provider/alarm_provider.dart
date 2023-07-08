import 'package:alarm/alarm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alarm_provider.g.dart';

@riverpod
class Alarms extends _$Alarms {
  @override
  FutureOr<List<AlarmSettings>> build() async {
    return getAlarms();
  }

  Future<bool> add(int id, String notificationTitle, String notificationBody,
      DateTime dateTime) async {
    state = const AsyncValue.loading();

    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: dateTime,
      assetAudioPath: 'assets/alarm.mp3',
      loopAudio: true,
      vibrate: true,
      fadeDuration: 3.0,
      notificationTitle: notificationTitle,
      notificationBody: notificationBody,
      enableNotificationOnKill: true,
    );

    var result = await Alarm.set(alarmSettings: alarmSettings);

    state = await AsyncValue.guard(() async => getAlarms());

    return result;
  }

  AlarmSettings? get(int id) {
    return Alarm.getAlarm(id);
  }

  Future<bool> remove(id) async {
    state = const AsyncValue.loading();

    var result = await Alarm.stop(id);

    state = await AsyncValue.guard(() async => getAlarms());

    return result;
  }

  List<AlarmSettings> getAlarms() {
    return Alarm.getAlarms();
  }
}
