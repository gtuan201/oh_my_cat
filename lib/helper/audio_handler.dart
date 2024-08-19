import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler{
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
  Future<void> stop() async {
    _player.stop();
    _handleCompletion();
  }

  @override
  Future<dynamic> customAction(String name, [Map<String, dynamic>? extras]) async {
    if (name == 'toggleLoop') {
      final loopMode = _player.loopMode == LoopMode.one ? LoopMode.off : LoopMode.one;
      await _player.setLoopMode(loopMode);
      playbackState.add(playbackState.value.copyWith(
        repeatMode: loopMode == LoopMode.one ? AudioServiceRepeatMode.one : AudioServiceRepeatMode.none,
      ));
      return loopMode.toString();
    }
    return super.customAction(name, extras);
  }

  @override
  Future<void> playMediaItem(MediaItem mediaItem) async {
    this.mediaItem.add(mediaItem);
    await setAudioSource(mediaItem.id, isLocal: mediaItem.extras?['isLocal'] ?? false);
    play();
  }


  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.stop,
        if (playing) MediaControl.pause else MediaControl.play,
      ],
      systemActions: {
        MediaAction.stop,
        if (playing) MediaAction.pause else MediaAction.play,
      },
      repeatMode: _player.loopMode == LoopMode.one ? AudioServiceRepeatMode.one : AudioServiceRepeatMode.none,
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
