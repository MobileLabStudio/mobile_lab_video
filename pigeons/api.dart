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
abstract class VideoPlayerApi {
  @async
  VideoDetails prepare();
  void play();
  void pause();
  void release();
  void seekTo(int milliseconds);
  void reset();
  bool isPlaying();
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
