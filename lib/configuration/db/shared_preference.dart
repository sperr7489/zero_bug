import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._privateConstructor();

  late SharedPreferences _prefs;

  SharedPreferencesManager._privateConstructor();

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
}
