import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/zero_base_model.dart';

enum ZeroBase { ten, thirty, hour }

class ZeroModeButton extends StatelessWidget {
  const ZeroModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    var baseTime = context.watch<ZeroBaseModel>();

    void onClickButtonSegment(int zeroBase) {
      baseTime.setZeroBase = zeroBase;
      baseTime.setScheduledNotificationDateTime();
    }

    return FractionallySizedBox(
      widthFactor: 0.8,
      child: SegmentedButton(
          segments: const <ButtonSegment<ZeroBase>>[
            ButtonSegment(
              value: ZeroBase.ten,
              label: Text("10분"),
              icon: Icon(
                Icons.hourglass_top_rounded,
              ),
            ),
            ButtonSegment(
              value: ZeroBase.thirty,
              label: Text("30분"),
              icon: Icon(
                Icons.hourglass_top_rounded,
              ),
            ),
            ButtonSegment(
              value: ZeroBase.hour,
              label: Text("60분"),
              icon: Icon(
                Icons.hourglass_top_rounded,
              ),
            ),
          ],
          selected: <ZeroBase>{
            intToZeroBase(baseTime.zeroBase)
          },
          onSelectionChanged: (Set<ZeroBase> newSelection) {
            var selectedNum = zeroBaseToInt(newSelection.first);
            onClickButtonSegment(selectedNum);
          }),
    );
  }
}

int zeroBaseToInt(ZeroBase value) {
  switch (value) {
    case ZeroBase.ten:
      return 10;
    case ZeroBase.thirty:
      return 30;
    case ZeroBase.hour:
      return 60;
  }
}

ZeroBase intToZeroBase(int value) {
  switch (value) {
    case 10:
      return ZeroBase.ten;
    case 30:
      return ZeroBase.thirty;
    case 60:
      return ZeroBase.hour;
  }
  return ZeroBase.ten;
}
