import 'package:mobile_lab_video/pigeon.dart';
import 'package:mobile_lab_video/video_player.dart';

class VideoPlayerFactory implements FlutterVideoPlayerApi {
  VideoPlayerFactory._() {
    FlutterVideoPlayerApi.setup(this);
  }

  static VideoPlayerFactory? _instance;

  factory VideoPlayerFactory.instance() {
    return _instance ??= VideoPlayerFactory._()..releaseAll();
  }

  late final _delegateApi = VideoPlayerDelegateApi();
  late final _playerById = <String, VideoPlayer>{};

  VideoPlayer create(String uri) {
    final player = VideoPlayer(uri, _delegateApi);
    player.create(uri).then((playerId) {
      _playerById[playerId] = player;
    }).ignore();
    return player;
  }

  Future<void> releaseAll() async {
    _playerById.clear();
    await _delegateApi.releaseAll();
  }

  @override
  void onBuffering(int percent, int surfaceId) {
    _playerById[surfaceId]?.onBuffered(percent);
  }

  @override
  void onCompleted(int surfaceId) {
    _playerById[surfaceId]?.onCompleted();
  }

  @override
  void onError(int error, int surfaceId) {
    _playerById[surfaceId]?.onError(VideoPlayerError.values[error]);
  }

  @override
  void onPrepared(int surfaceId) {
    _playerById[surfaceId]?.onPrepared();
  }
}
