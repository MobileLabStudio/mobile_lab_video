import 'package:mobile_lab_video/pigeon.dart';
import 'package:mobile_lab_video/video_player_controls.dart';

abstract class VideoPlayerBase
    implements VideoObserver, VideoPlayerControls, PlayerListenable {
  Future<String> create(String uri);
  Future<VideoDetails> init();
}

abstract class VideoObserver {
  void onCompleted();
  void onError(VideoPlayerError error);
  void onBuffered(int percent);
  void onPrepared();
}

abstract class PlayerListenable {
  void addListener(PlayerListener listener);

  void removeListener(PlayerListener listener);
}

abstract class PlayerListener {
  void onEvent(VideoPlayerEvent event);
}

abstract class VideoPlayerEvent {
  const VideoPlayerEvent();
}

class OnBufferedVideoPlayerEvent extends VideoPlayerEvent {
  const OnBufferedVideoPlayerEvent(this.percent);

  final int percent;
}

class OnCompletedVideoPlayerEvent extends VideoPlayerEvent {
  const OnCompletedVideoPlayerEvent();
}

class OnErrorVideoPlayerEvent extends VideoPlayerEvent {
  final VideoPlayerError error;

  const OnErrorVideoPlayerEvent(this.error);
}

class OnPreparedEvent extends VideoPlayerEvent {
  const OnPreparedEvent();
}
