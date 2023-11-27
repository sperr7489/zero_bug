import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../spinner/util.dart';

class SpinnerViewModel {
  final List<Color> pageColors;
  final CircularSliderAppearance appearance;
  final double min;
  final double max;
  final double value;
  final InnerWidget? innerWidget;

  SpinnerViewModel({
    required this.pageColors,
    required this.appearance,
    required this.value,
    this.min = 0,
    this.max = 43200,
    this.innerWidget,
  });
}

final customWidth05 =
    CustomSliderWidths(trackWidth: 8, progressBarWidth: 30, shadowWidth: 60);
final customColors05 = CustomSliderColors(
  dotColor: HexColor('#c3c3e8'),
  trackColor: HexColor('#e4e4f5'),
  progressBarColors: [HexColor('#c3c3e8'), HexColor('#6363e0')],
  shadowColor: HexColor('#c3c3e8'),
  shadowMaxOpacity: 0.05,
);

final info05 = InfoProperties(
    topLabelStyle: const TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
    topLabelText: 'MAX 6 HOUR',
    bottomLabelStyle: const TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
    bottomLabelText:
        'Cumulative time\n${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
    mainLabelStyle: const TextStyle(
        color: Colors.black, fontSize: 50.0, fontWeight: FontWeight.w600),
    modifier: (double value) {
      final time = printDuration(Duration(seconds: value.toInt()));
      return time;
    });
final CircularSliderAppearance appearance05 = CircularSliderAppearance(
  customWidths: customWidth05,
  customColors: customColors05,
  infoProperties: info05,
  startAngle: 270,
  angleRange: 360,
  size: 350.0,
);

// final spinnerCustom = SpinnerViewModel(
//   appearance: appearance05,
//   min: 0, // 시작점
//   max: 43200, // 아래의 zerobasefh
//   value: 21600,
//   pageColors: [Colors.black, const Color.fromARGB(255, 27, 21, 21)],
// );
String printDuration(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  int seconds = duration.inSeconds;
  int hours = seconds ~/ 3600;
  int minutes = (seconds % 3600) ~/ 60;
  int remainingSeconds = seconds % 60;
  String formattedTime = "${hours.toString().padLeft(2, '0')}:"
      "${minutes.toString().padLeft(2, '0')}:"
      "${remainingSeconds.toString().padLeft(2, '0')}";

  return formattedTime;
}
