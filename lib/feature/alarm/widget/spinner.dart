import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'spinner_custom.dart';

class Spinner extends StatelessWidget {
  final double cumulativeTime;
  final DateTime lastDate;

  const Spinner(
      {super.key, required this.cumulativeTime, required this.lastDate});

  @override
  Widget build(BuildContext context) {
    SpinnerViewModel spinnerCustom = SpinnerViewModel(
      appearance: getAppearance(lastDate),
      min: 0, // 시작점
      max: 21600, // 아래의 zerobasefh
      value: cumulativeTime,
      pageColors: [Colors.black, const Color.fromARGB(255, 27, 21, 21)],
    );

    // print('${spinnerCustom.value} 를 확인');
    return IgnorePointer(
      ignoring: true,
      child: SafeArea(
        child: Center(
            child: SleekCircularSlider(
          onChangeStart: (double value) {},
          onChangeEnd: (double value) {},
          appearance: spinnerCustom.appearance,
          min: spinnerCustom.min,
          max: spinnerCustom.max, // 영충 시간으로 설정한 것을 바탕으로 계산한다.
          initialValue: spinnerCustom.value,
        )),
      ),
    );
  }

  InfoProperties getInfoProperties(DateTime lastDate) {
    return InfoProperties(
        topLabelStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        topLabelText: 'MAX 6 HOUR',
        bottomLabelStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        bottomLabelText:
            'Cumulative time\n${DateFormat('yyyy-MM-dd').format(lastDate)}',
        mainLabelStyle: const TextStyle(
            color: Colors.black, fontSize: 50.0, fontWeight: FontWeight.w600),
        modifier: (double value) {
          final time = printDuration(Duration(seconds: value.toInt()));
          return time;
        });
  }
}

CircularSliderAppearance getAppearance(DateTime lastDate) {
  return CircularSliderAppearance(
    customWidths: customWidth05,
    customColors: customColors05,
    infoProperties: getInfoProperties(lastDate),
    startAngle: 270,
    angleRange: 360,
    size: 350.0,
  );
}

InfoProperties getInfoProperties(DateTime lastDate) {
  return InfoProperties(
      topLabelStyle: const TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
      topLabelText: 'MAX 6 HOUR',
      bottomLabelStyle: const TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
      bottomLabelText:
          'Cumulative time\n${DateFormat('yyyy-MM-dd').format(lastDate)}',
      mainLabelStyle: const TextStyle(
          color: Colors.black, fontSize: 50.0, fontWeight: FontWeight.w600),
      modifier: (double value) {
        final time = printDuration(Duration(seconds: value.toInt()));
        return time;
      });
}
