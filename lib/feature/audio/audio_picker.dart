import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configuration/audio/audio_player_hander.dart';
import '../../configuration/audio/audio_service_manager.dart';
import '../../providers/alarm_status.dart';

class AudioPickerScreen extends StatefulWidget {
  const AudioPickerScreen({super.key});

  @override
  State<AudioPickerScreen> createState() => _AudioPickerScreenState();
}

class _AudioPickerScreenState extends State<AudioPickerScreen> {
  String? _selectedAudio;

  final Map<String, String> audioFiles = <String, String>{
    'Dark Anxious Tension':
        'assets/audio/dark-anxious-tension-dramatic-suspense-112169.wav',
    'Electronic Future Beats':
        'assets/audio/electronic-future-beats-117997.wav',
    'inspiring cinematic ambient':
        'assets/audio/inspiring-cinematic-ambient-116199.wav',
    'memphis': 'assets/audio/memphis-155671.wav',
    'stomping rock four shots ':
        'assets/audio/stomping-rock-four-shots-111444.wav',
    'wake up call': 'assets/audio/wake-up-call-111748.wav',
    'winning elevation': 'assets/audio/winning-elevation-111355.wav',
  };

  @override
  Widget build(BuildContext context) {
    AlarmStatusModel alarmStatusModel = context.watch<AlarmStatusModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select an Audio File'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 여기에 back 버튼의 기능을 구현합니다.
            AudioServiceManager.stop();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: audioFiles.length,
        itemBuilder: (context, index) {
          String title = audioFiles.keys.elementAt(index);
          return RadioListTile(
            groupValue: alarmStatusModel.alarmAudio,
            value: audioFiles[title],
            title: Text(title),
            onChanged: (value) {
              alarmStatusModel.setAlarmAudio = value!;
              // setState(() {
              //   _selectedAudio = value;
              // });
              // 여기에 오디오 파일을 재생하는 로직을 추가
              AudioPlayerHandler.playSelectedAudio(audioFiles[title]!);
            },
          );
        },
      ),
    );
  }
}
