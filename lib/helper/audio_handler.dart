import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  AudioPlayerHandler() {
    _player.playbackEventStream.listen(_broadcastState);
    _player.playerStateStream.listen((state) {
      _broadcastState(_player.playbackEvent);
      final processingState = _player.processingState;
      if (processingState == ProcessingState.completed) {
        _handleCompletion();
      }
    });
  }

  Duration? get getDuration => _player.duration;

  Duration? get getPosition => _player.position;

  Stream<bool> get playingStream => _player.playingStream;

  Stream<Duration> get positionStream => _player.positionStream;

  Stream<LoopMode> get loopStream => _player.loopModeStream;

  Stream<ProcessingState> get processingStateStream => _player.processingStateStream;

  void toggleLoopMode(bool turnOn){
    turnOn ? _player.setLoopMode(LoopMode.one) : _player.setLoopMode(LoopMode.off);
  }

  Future<void> setAudioSource(String audioPath, {bool isLocal = false}) async {
    late AudioSource audioSource;
    if (isLocal) {
      audioSource = AudioSource.file(audioPath);
    } else {
      audioSource = AudioSource.uri(Uri.parse(audioPath));
    }

    await _player.setAudioSource(audioSource);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> playMediaItem(MediaItem mediaItem) async {
    await setAudioSource(mediaItem.id, isLocal: mediaItem.extras?['isLocal'] ?? false);
    play();
  }

  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.rewind,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    ));
  }
    void _handleCompletion() {
      _player.pause();
      _player.seek(Duration.zero);
    }
}
