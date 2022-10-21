export 'view/video_player_widget.dart';

import 'dart:async';

import 'package:mobile_lab_video/pigeon.dart';

import 'video_player_base.dart';

class VideoPlayer implements VideoPlayerBase {
  /// Create video player.
  /// DO NOT create this player directly. Instead use [VideoPlayerFactory]
  VideoPlayer(String uri, this.videoPlayerDelegateApi);

  VideoDetails? _videoDetails;
  VideoDetails get videoDetails => _videoDetails!;

  final VideoPlayerDelegateApi videoPlayerDelegateApi;
  late final _playerIdCompleter = Completer<String>();

  bool get isPrepared => _videoDetails != null;

  final _listeners = <PlayerListener>{};

  @override
  void addListener(PlayerListener listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(PlayerListener listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners(VideoPlayerEvent event) {
    for (final l in _listeners) {
      l.onEvent(event);
    }
  }

  @override
  Future<String> create(String uri) async {
    final playerId = await videoPlayerDelegateApi.create(uri);
    _playerIdCompleter.complete(playerId);
    return playerId;
  }

  @override
  Future<VideoDetails> init() async {
    final surfaceId = await _playerIdCompleter.future;
    return _videoDetails = await videoPlayerDelegateApi.prepare(surfaceId);
  }

  @override
  void pause() async {
    if (!_playerIdCompleter.isCompleted) return;
    await videoPlayerDelegateApi.pause(await _playerIdCompleter.future);
  }

  @override
  void play() async {
    if (!_playerIdCompleter.isCompleted) return;
    await videoPlayerDelegateApi.play(await _playerIdCompleter.future);
  }

  @override
  void release() async {
    await videoPlayerDelegateApi.release(await _playerIdCompleter.future);
  }

  @override
  void reset() async {
    await videoPlayerDelegateApi.reset(await _playerIdCompleter.future);
  }

  @override
  void seekTo(Duration point) async {
    if (!_playerIdCompleter.isCompleted) return;
    await videoPlayerDelegateApi.seekTo(
        point.inMilliseconds, await _playerIdCompleter.future);
  }

  @override
  void onBuffered(int percent) {
    _notifyListeners(OnBufferedVideoPlayerEvent(percent));
  }

  @override
  void onCompleted() {
    _notifyListeners(const OnCompletedVideoPlayerEvent());
  }

  @override
  void onError(VideoPlayerError error) {
    _notifyListeners(OnErrorVideoPlayerEvent(error));
  }

  @override
  void onPrepared() {
    _notifyListeners(const OnPreparedEvent());
  }

  @override
  Future<bool> isPlaying() async {
    if (!_playerIdCompleter.isCompleted) return false;
    return videoPlayerDelegateApi.isPlaying(await _playerIdCompleter.future);
  }
}
