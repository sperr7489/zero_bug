import 'package:audio_service/audio_service.dart';

import 'audio_player_hander.dart';

class AudioServiceManager {
  static late final AudioHandler _audioHandler;

  static Future<void> init() async {
    _audioHandler = await AudioService.init(
      builder: () => AudioPlayerHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.yourcompany.yourapp.channel.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
      ),
    );
  }

  static AudioHandler get audioHandler => _audioHandler;

  static get playbackState => _audioHandler.playbackState;

  static Future<void> play() async {
    return _audioHandler.play();
  }

  static Future<void> pause() async {
    return _audioHandler.pause();
  }

  static Future<void> stop() async {
    return _audioHandler.stop();
  }
}
