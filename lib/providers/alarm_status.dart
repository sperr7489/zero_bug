import 'package:flutter/material.dart';
import 'package:test/configuration/db/shared_preference.dart';

class AlarmStatusModel with ChangeNotifier {
  bool _alarmStatus = SharedPreferencesManager.instance
      .getAlarmStatus(); // 현재 알람이 울리고 있는 지 아닌 지
  bool _startable = SharedPreferencesManager.instance.getAlarmStartable();
  String _alarmAudio = "Dark Anxious Tension";

  bool get alarmStatus => _alarmStatus;
  bool get startable => _startable;
  String get alarmAudio => _alarmAudio;

  void setInitialStatus() {
    bool startble = SharedPreferencesManager.instance.getAlarmStatus();

    _startable = startble;
    notifyListeners();
  }

  void setAlarmStatus() {
    // 반대로 status로 설정하도록 한다.
    _alarmStatus = !_alarmStatus;
    SharedPreferencesManager.instance.setAlarmStatus(_startable);

    notifyListeners();
  }

  set setAlarmAudio(String value) {
    _alarmAudio = value;
    notifyListeners();
  }

  void setInitialStartable() {
    bool startble = SharedPreferencesManager.instance.getAlarmStartable();
    _startable = startble;
    notifyListeners();
  }

  void setStartableStatus() {
    // 반대로 status로 설정하도록 한다.
    _startable = !_startable;
    SharedPreferencesManager.instance.setAlarmStartable(_startable);
    notifyListeners();
  }
}
