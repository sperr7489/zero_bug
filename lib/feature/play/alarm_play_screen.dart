import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../configuration/audio/audio_service_manager.dart';
import '../../configuration/db/shared_preference.dart';
import '../../providers/alarm_status.dart';
import '../../providers/memo_model.dart';
import '../../providers/zero_base_model.dart';
import '../../util/format_time.dart';
import '../alarm/widget/alarm_stop_button.dart';
import 'widget/feeling_degree_dialog.dart';

class AlarmPlayScreen extends StatefulWidget {
  const AlarmPlayScreen({super.key});

  @override
  State<AlarmPlayScreen> createState() => _AlarmPlayScreenState();
}

class _AlarmPlayScreenState extends State<AlarmPlayScreen> {
  String satisfaction = "happy";

  void setSatisfaction(String satisfaction) {
    setState(() {
      this.satisfaction = satisfaction;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AlarmStatusModel alarmStatusModel = context.watch<AlarmStatusModel>();

    ZeroBaseModel zeroBaseModel = context.read<ZeroBaseModel>();

    MemoModel memoModel = context.read<MemoModel>();

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
      ],
    );

    void onPressed() {
      DateTime now = DateTime.now();

      // 알람 중지시간을 등록합니다.
      memoModel.setStoppedAt = now;
      memoModel.setSatisfaction = satisfaction;

      double durationSeconds = memoModel.durationSeconds!;

      DateTime currentDate = DateTime.now();

      SharedPreferencesManager pref = SharedPreferencesManager.instance;
      double? cumulativeSeconds = pref.getCumulativeTimeOnDate(currentDate);

      // 현재까지의 누적시간을 기입.
      if (cumulativeSeconds == null) {
        pref.setCumulativeTime(currentDate, durationSeconds);
        cumulativeSeconds = durationSeconds;
      } else {
        pref.setCumulativeTime(
          currentDate,
          durationSeconds + cumulativeSeconds,
        );
        cumulativeSeconds = durationSeconds + cumulativeSeconds;
      }
      //setCumulativeTime 가 변화할 때마다 ui를 rebuild하기 위해 필요
      zeroBaseModel.setCumulativeTime = cumulativeSeconds;

      memoModel.insertDb();

      AudioServiceManager.pause();
      alarmStatusModel.setAlarmStatus();
      alarmStatusModel.setStartableStatus();

      // SharedPreferencesManager.instance
      //     .setAlarmStartable(alarmStatusModel.startable);

      Navigator.popUntil(context, (Route route) => route.isFirst);
    }

    void alertDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          surfaceTintColor: const Color(0xFFFCFFFE),
          title: const Text(
            "당신의 성취도를 선택하세요",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: FeelingDegreeDialog(
            setSatisfaction: setSatisfaction,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                onPressed();
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/image/success1.jpg',
          ),
        )),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            const Text(
                              "ZeroBug 누적 시간",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            TimerBuilder.periodic(
                              const Duration(seconds: 1),
                              builder: (context) {
                                DateTime now = DateTime.now();
                                Duration cummulative = now.difference(
                                        zeroBaseModel
                                            .scheduledNotificationDateTime) +
                                    zeroBaseModel.currentCumulativeTime;
                                return Text(
                                  FormatTime.formatDurationToColon(cummulative),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: AlarmStopButton(onPressed: alertDialog),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
