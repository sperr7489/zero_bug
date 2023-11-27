import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../configuration/local_notification.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../providers/alarm_status.dart';
import '../../../providers/memo_model.dart';
import '../../../providers/zero_base_model.dart';

class ZeroBugStartModal extends StatefulWidget {
  const ZeroBugStartModal({
    super.key,
  });

  @override
  State<ZeroBugStartModal> createState() => _ZeroBugStartModalState();
}

class _ZeroBugStartModalState extends State<ZeroBugStartModal> {
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ZeroBaseModel>().setScheduledNotificationDateTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    ZeroBaseModel zeroBaseModel = context.watch<ZeroBaseModel>();

    AlarmStatusModel alarmStatus = context.watch<AlarmStatusModel>();
    MemoModel memoModel = context.read<MemoModel>();

    DateTime alarmedTime = zeroBaseModel.scheduledNotificationDateTime;

    String formattedTime =
        DateFormat('HH:mm').format(zeroBaseModel.scheduledNotificationDateTime);

    void setAlarmStatus() => alarmStatus.setAlarmStatus();

    void onScheduledAlarm() {
      DateTime now = DateTime.now();
      zeroBaseModel.setScheduledNotificationDateTime();
      LocalNotification.scheduleAlarm(alarmedTime, setAlarmStatus);
      alarmStatus.setStartableStatus();

      // start 버튼을 눌렀을 때 현재 알람을 등록한 시간을 등록한다.
      memoModel.setCreatedAt = now;
      Navigator.pop(context);
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text(
                '${zeroBaseModel.zeroBase}분 기준으로 설정되어 있습니다.\n당신의 알람은 $formattedTime에 울립니다',
                style: const TextStyle(fontSize: 24.0),
              ),
            ],
          ),
          Gaps.v32,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: Sizes.size24,
              ),
              elevation: 3,
              padding: const EdgeInsets.all(
                8.0,
              ),
            ),
            onPressed: alarmStatus.startable ? onScheduledAlarm : null,
            child: const Text("START"),
          )
        ],
      ),
    );
  }
}
