import 'package:pigeon/pigeon.dart';

class VideoDetails {
  final int width;
  final int height;
  final int surfaceId;

  const VideoDetails({
    required this.width,
    required this.height,
    required this.surfaceId,
  });
}

@HostApi()
abstract class VideoPlayerDelegateApi {
  String create(String uri);

  @async
  VideoDetails prepare(String playerId);
  void play(String playerId);
  void pause(String playerId);
  void release(String playerId);
  void seekTo(int milliseconds, String playerId);
  void reset(String playerId);
  @async
  bool isPlaying(String playerId);

  void releaseAll();
}

@FlutterApi()
abstract class FlutterVideoPlayerApi {
  /// Called when player enters error state.
  /// The [error] param is index of the [VideoPlayerError] enum.
  /// The [nativePlayerInfo] is info about player which enters error state
  void onError(int error, int surfaceId);

  /// Called when player buffer updates
  void onBuffering(int percent, int surfaceId);

  /// Called when media completes
  void onCompleted(int surfaceId);

  /// Called when player was prepared
  void onPrepared(int surfaceId);
}

@HostApi()
enum VideoPlayerError {
  unknown,
  serverDied,
  io,
  malformed,
  unsupported,
  timedOut,
  system,
}

@HostApi()
abstract class PMediaPlayerFactory {
  @async
  PMediaPlayerInfo createHttpVideoPlayer(String httpUrl, String? tag);
  @async
  PMediaPlayerInfo createHLSVideoStream(String hlsUrl, String? tag);
}

class PMediaPlayerInfo {
  final int textureId;

  const PMediaPlayerInfo({required this.textureId});
}

@HostApi()
abstract class PMediaPlayer {
  void prepare();
  void play();
  void pause();
  void playPause();
  void seekTo(int millisecond);
  void reuse();
  void release();
  PVideoMeta getVideoMeta();
}

@HostApi()
abstract class PMediaPlayerProxy {
  void prepare(PMediaPlayerInfo mediaPlayerInfo);
  void play(PMediaPlayerInfo mediaPlayerInfo);
  void pause(PMediaPlayerInfo mediaPlayerInfo);
  void playPause(PMediaPlayerInfo mediaPlayerInfo);
  void seekTo(PMediaPlayerInfo mediaPlayerInfo, int millisecond);
  void reuse(PMediaPlayerInfo mediaPlayerInfo);
  void release(PMediaPlayerInfo mediaPlayerInfo);
  PVideoMeta getVideoMeta(PMediaPlayerInfo mediaPlayerInfo);
}

class PVideoMeta {
  final int width;
  final int height;

  PVideoMeta(this.width, this.height);
}

@FlutterApi()
abstract class PMediaPlayerListener {
  void onStateChanged(PMediaPlayerStateEvent stateEvent);
  void onError(PMediaPlayerNaviteError naviteError);
}

class PMediaPlayerStateEvent {
  final int textureId;
  final PMediaPlayerState state;

  const PMediaPlayerStateEvent(this.textureId, this.state);
}

enum PMediaPlayerState {
  ready,
  buffering,
  ended,
  idle,
}

class PMediaPlayerNaviteError {
  final int textureId;
  final Map<String?, Object?> details;

  PMediaPlayerNaviteError(this.textureId, this.details);
}
