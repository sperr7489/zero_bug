import 'package:intl/intl.dart';

class FormatTime {
  FormatTime._init();
  static String formatDatetime(DateTime dateTime) {
    final DateFormat formatter =
        DateFormat('yyyy/MM/dd hh:mm a'); // 'a'는 AM/PM을 나타냅니다.
    return formatter.format(dateTime); // 예: "2023-10-11 3:00 PM"
    // We want to round up the remaining time to the nearest second
  }

  static String formatDurationToColon(Duration duration) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    // We want to round up the remaining time to the nearest second
    duration += const Duration(microseconds: 999999);
    return "${f(duration.inHours)}:${f(duration.inMinutes)}:${f(duration.inSeconds % 60)}";
  }

  static String formatDurationToTime(Duration duration) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    // duration += const Duration(microseconds: 999999);
    return "${f(duration.inMinutes)}:${f(duration.inSeconds % 60)}";
  }
}
