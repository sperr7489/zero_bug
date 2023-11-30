import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/gaps.dart';
import '../constants/sizes.dart';
import '../providers/alarm_status.dart';
import '../providers/memo_model.dart';
import '../providers/zero_base_model.dart';
import 'alarm/alarm_screen.dart';
import 'audio/audio_picker.dart';
import 'log/log_screen.dart';
import 'play/alarm_play_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    AlarmScreen(),
    LogScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // 현재 알람 상태에 대한 초깃값을 로컬 저장소에서 가져오도록 한다.
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // TODO: implement didChangeAppLifecycleState
  //   super.didChangeAppLifecycleState(state);
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       print('resumed');
  //       break;
  //     case AppLifecycleState.inactive:
  //       print('inactive');
  //       break;
  //     case AppLifecycleState.detached:
  //       print('detached');
  //       SharedPreferencesManager.instance.setNotNormalExit();
  //       // DO SOMETHING!
  //       break;
  //     case AppLifecycleState.paused:
  //       print('paused');
  //       break;
  //     default:
  //       print("넌 뭐지?");
  //       break;
  //   }
  // }

  void navigateToAudioScreen(AlarmStatusModel alarmStatusModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ChangeNotifierProvider.value(
            value: alarmStatusModel,
            child: const AudioPickerScreen(),
          );
        },
      ),
    );
  }

  Future<void> openDatePicker(BuildContext context) async {
    ZeroBaseModel zeroBaseModel = context.read<ZeroBaseModel>();

    await showDatePicker(
      context: context,
      initialDate: zeroBaseModel.lastDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      helpText: '날짜를 선택하세요',
    ).then((value) {
      context.read<ZeroBaseModel>().setLastDate = (value ?? DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    AlarmStatusModel alarmStatusModel = context.watch<AlarmStatusModel>();
    ZeroBaseModel zeroBaseModel = context.watch<ZeroBaseModel>();
    MemoModel memoModel = context.read<MemoModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (alarmStatusModel.alarmStatus) {
        print(alarmStatusModel.alarmStatus);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MultiProvider(
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
            child: const AlarmPlayScreen(),
          ),
        ));
      }
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () {
            navigateToAudioScreen(alarmStatusModel);
          },
          child: const Icon(
            Icons.queue_music_outlined,
            size: Sizes.size32,
          ),
        ),
        shadowColor: Theme.of(context).shadowColor,
        centerTitle: true,
        title: const Text(
          'Zero Bug',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size24,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onTertiary,
        actions: [
          GestureDetector(
            onTap: () async {
              openDatePicker(context);
            },
            child: const Icon(
              Icons.calendar_month_outlined,
              size: Sizes.size32,
            ),
          ),
          Gaps.h14,
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          zeroBaseModel.checkAndResetCumulativeTime();
        },
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: alarmStatusModel.alarmStatus
          ? null
          : BottomNavigationBar(
              elevation: 5,
              type: BottomNavigationBarType.shifting,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Theme.of(context).colorScheme.onTertiary,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.list),
                  label: 'BugLog',
                  backgroundColor: Theme.of(context).colorScheme.onTertiary,
                ),
              ],
              currentIndex: _selectedIndex,
              unselectedItemColor: Theme.of(context).colorScheme.inversePrimary,
              selectedItemColor: Theme.of(context).colorScheme.surfaceTint,
              onTap: _onItemTapped,
            ),
    );
  }
}
