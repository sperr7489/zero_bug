import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configuration/db/shared_preference.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../providers/alarm_status.dart';
import '../../providers/memo_model.dart';
import '../../providers/zero_base_model.dart';
import 'widget/spinner.dart';
import 'widget/zero_bug_start_modal.dart';
import 'widget/zero_mode_setup.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  void _showBottomSheet(
    BuildContext context,
  ) {
    // @todo : 이 모달 bottomSheet부분을 외부 컴포넌트로 관리하도록 한다.
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          20,
        ),
      )),
      builder: (BuildContext _) {
        // 여기에서 Bottom Sheet의 내용을 구성합니다.
        AlarmStatusModel alarmStatusModel =
            Provider.of<AlarmStatusModel>(context, listen: false);
        ZeroBaseModel zeroBaseModel =
            Provider.of<ZeroBaseModel>(context, listen: false);
        MemoModel memoModel = Provider.of<MemoModel>(context, listen: false);
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<AlarmStatusModel>.value(
              value: alarmStatusModel,
            ),
            ChangeNotifierProvider<ZeroBaseModel>.value(
              value: zeroBaseModel,
            ),
            ChangeNotifierProvider<MemoModel>.value(
              value: memoModel,
            ),
          ],
          child: const ZeroBugStartModal(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ZeroBaseModel zeroBaseModel = context.watch<ZeroBaseModel>();
    double cumulativeSeconds = SharedPreferencesManager.instance
        .getCumulativeTimeOnDate(zeroBaseModel.lastDate);
    onScaffoldTap() {
      FocusScope.of(context).unfocus();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: onScaffoldTap,
        onHorizontalDragEnd: (details) {
          // 수직 드래그 감지: 사용자가 위에서 아래로 드래그할 때
          if (details.primaryVelocity! < -1200) {
            // 드래그 거리가 일정 기준을 초과하면 Bottom Sheet를 띄웁니다.
            _showBottomSheet(
              context,
            );
          }
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Gaps.v32,
                  Spinner(
                    cumulativeTime: cumulativeSeconds,
                    lastDate: zeroBaseModel.lastDate,
                  ),
                  Gaps.v32,
                  const ZeroModeSetupContainer(),
                  Gaps.v16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "당신의 영충의 기준을 먼저 선택해주세요!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.size16,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showBottomSheet(
                            context,
                          );
                        },
                        child: const Text("START"),
                      )
                    ],
                  ),
                  Gaps.v10,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
