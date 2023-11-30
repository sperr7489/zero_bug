import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._privateConstructor();

  late SharedPreferences _prefs;

  SharedPreferencesManager._privateConstructor();

  void setNotNormalExit() {
    _prefs.setString('notNormal', '강제종료되었다.');
  }

  String getNotNormalExit() {
    return _prefs.getString('notNormal') ?? 'unknown';
  }

  void setPreferences(SharedPreferences prefs) {
    _prefs = prefs;
  }

  static SharedPreferencesManager get instance => _instance;

// 특정 날짜에 대한 누적시간 가져오기.
  double getCumulativeTimeOnDate(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return _prefs.getDouble(formattedDate) ?? 0;
  }

  // 특정 날짜에 대한 누적시간 upsert
  void setCumulativeTime(DateTime date, double cumulativeSeconds) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    _prefs.setDouble(formattedDate, cumulativeSeconds);
  }

  void setOnBoardingValid() {
    _prefs.setBool('onBoarding', true);
  }

  Future<bool> getOnBoardingValid() async {
    return _prefs.getBool('onBoarding') ?? false;
  }

  bool getAlarmStartable() {
    String startble = _prefs.getString('alarmStartable') ?? 'true';
    if (startble == 'false') {
      return false;
    } else {
      return true;
    }
  }

  void setInitialAlarmStatus() {
    _prefs.setString('alarmStartable', 'true');
    _prefs.setString('alarmStatus', 'false');
  }

  void setAlarmStartable(bool startable) {
    if (startable) {
      _prefs.setString('alarmStartable', 'true');
    } else {
      _prefs.setString('alarmStartable', 'false');
    }
  }

  // alarmstatus는 현재 알람이 울리고 있는지 아닌지.
  bool getAlarmStatus() {
    String alarmStatus = _prefs.getString('alarmStatus') ?? 'false';
    if (alarmStatus == 'false') {
      return false;
    } else {
      return true;
    }
  }

  void setAlarmStatus(bool alarmStatus) {
    if (alarmStatus) {
      _prefs.setString('alarmStatus', 'true');
    } else {
      _prefs.setString('alarmStatus', 'false');
    }
  }
}
