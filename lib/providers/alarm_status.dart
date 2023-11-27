import 'package:flutter/material.dart';

class AlarmStatusModel with ChangeNotifier {
  bool _alarmStatus = false; // 현재 알람이 울리고 있는 지 아닌 지
  bool _startable = true;
  String _alarmAudio = "Dark Anxious Tension";

  bool get alarmStatus => _alarmStatus;
  bool get startable => _startable;
  String get alarmAudio => _alarmAudio;

  void setAlarmStatus() {
    // 반대로 status로 설정하도록 한다.
    _alarmStatus = !_alarmStatus;

    notifyListeners();
  }

  set setAlarmAudio(String value) {
    _alarmAudio = value;
    notifyListeners();
  }

  void setStartableStatus() {
    // 반대로 status로 설정하도록 한다.
    _startable = !_startable;

    notifyListeners();
  }
}
