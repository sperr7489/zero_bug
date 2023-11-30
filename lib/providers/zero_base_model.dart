import 'package:flutter/material.dart';

class ZeroBaseModel with ChangeNotifier {
  int _zeroBase = 10;
  DateTime? _scheduledNotificationDateTime;
  DateTime _lastDate = DateTime.now();
  double _cumulativeTime = 0;

  //_scheduledNotificationDateTime이 설정된 시간과 _scheduledNotificationDateTime의 차이 Duration
  Duration _currentCumulativeTime = const Duration(seconds: 0); //

  int get zeroBase => _zeroBase;
  DateTime get scheduledNotificationDateTime =>
      _scheduledNotificationDateTime ?? DateTime.now();
  DateTime get lastDate => _lastDate;
  double get cumulativeTime => _cumulativeTime;
  Duration get currentCumulativeTime => _currentCumulativeTime;

  // zerobase에 대한 값을 수정하는 것.
  set setZeroBase(int value) {
    _zeroBase = value;
    notifyListeners();
  }

  set setLastDate(DateTime date) {
    _lastDate = date;
    notifyListeners();
  }

// 날이 지나면 _cumulativeTime를 0으로 초기화하기 위함
  void checkAndResetCumulativeTime() {
    DateTime now = DateTime.now();
    DateTime nowDate = DateTime(now.year, now.month, now.day); // 오늘 날짜의 자정

    // 마지막 리셋 날짜를 저장하는 변수 추가 필요
    if (_lastDate != nowDate) {
      _cumulativeTime = 0;
      setLastDate = DateTime.now();
      notifyListeners();
    }
  }

  set setCumulativeTime(double value) {
    _cumulativeTime = value;
    notifyListeners();
  }

  void setScheduledNotificationDateTime() {
    DateTime now = DateTime.now();
    int min = now.minute;

    int quotient = min ~/ _zeroBase;
//  ( quotient + 1 ) * zeroBase 는 zeroBase가 60분일땐 무조건 1이된다.
    int addMin = (quotient + 1) * _zeroBase - min;
    DateTime alarmTime =
        DateTime(now.year, now.month, now.day, now.hour, now.minute, 0, 0)
            .add(Duration(minutes: addMin));
    _scheduledNotificationDateTime = alarmTime;

    _currentCumulativeTime = _scheduledNotificationDateTime!.difference(now);

    notifyListeners();
  }
}
