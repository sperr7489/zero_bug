import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler {
  // static final AudioPlayerHandler _instance = AudioPlayerHandler();

  static final _player = AudioPlayer();

  static AudioPlayer get audioPlayer => _player;

  AudioPlayerHandler() {
    _init();

    _player.playerStateStream.listen(
      (state) {
        if (state.processingState == ProcessingState.completed) {
          // 재생이 완료되면 상태 업데이트
          playbackState.add(playbackState.value.copyWith(
            playing: false,
            processingState: AudioProcessingState.completed,
          ));
        }
      },
    );
    playbackState.add(playbackState.value.copyWith(
      controls: [MediaControl.play],
      processingState: AudioProcessingState.loading,
    ));
  }

  void _init() {
    try {
      // 에셋에서 오디오 파일 로드
      _player.setAsset('assets/audio/winning-elevation-111355.wav').then(
            (_) => {
              // Broadcast that we've finished loading
              playbackState.add(
                playbackState.value.copyWith(
                  processingState: AudioProcessingState.ready,
                ),
              )
            },
          );
    } catch (e) {
      print("오디오 파일 로드 중 에러 발생: $e");
    }
  }

  static Future<void> playSelectedAudio(String assetPath) async {
    try {
      // 에셋에서 오디오 파일을 로드하여 설정
      await _player.setAsset(assetPath);
      // 오디오 재생 시작
      _player.play();
    } catch (e) {
      // 에러 처리
      print("An error occurred while playing the audio: $e");
    }
  }

  @override
  Future<void> play() async {
    if (_player.processingState == ProcessingState.completed) {
      // 재생이 완료된 경우, 시작 지점으로 되돌리기
      await _player.seek(Duration.zero);
    }
    playbackState.add(playbackState.value.copyWith(
      playing: true,
      controls: [MediaControl.pause],
    ));
    await _player.play();
  }

  @override
  Future<void> pause() async {
    playbackState.add(playbackState.value.copyWith(
      playing: false,
      controls: [MediaControl.play],
    ));
    await _player.pause().then(
          (value) => _player.seek(Duration.zero),
        );
  }

  @override
  Future<void> stop() async {
    // Release any audio decoders back to the system
    await _player.stop().then(
          (value) => _player.seek(
            Duration.zero,
          ),
        );

    // Set the audio_service state to `idle` to deactivate the notification.
    playbackState.add(playbackState.value.copyWith(
      processingState: AudioProcessingState.idle,
    ));
  }
}
