import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mobile_lab_video/pigeon.dart';
import 'package:rxdart/subjects.dart';

final _mediaPlayerFactory = PMediaPlayerFactory();
final _mediaPlayerProxy = PMediaPlayerProxy();

class _MediaPlayerObserver implements PMediaPlayerListener {
  _MediaPlayerObserver._() {
    PMediaPlayerListener.setup(this);
  }

  factory _MediaPlayerObserver.getInstance() {
    return _instance ??= _MediaPlayerObserver._();
  }

  static _MediaPlayerObserver? _instance;
  late final _listenerByTextureId = <int, PMediaPlayerListener>{};

  @override
  void onStateChanged(PMediaPlayerStateEvent stateEvent) {
    final mediaPlayer = _listenerByTextureId[stateEvent.textureId];
    mediaPlayer?.onStateChanged(stateEvent);
  }

  void setListener(int textureId, PMediaPlayerListener? listener) {
    if (listener == null) {
      _listenerByTextureId.remove(textureId);
    } else {
      _listenerByTextureId[textureId] = listener;
    }
  }

  @override
  void onError(PMediaPlayerNaviteError naviteError) {
    final mediaPlayer = _listenerByTextureId[naviteError.textureId];
    mediaPlayer?.onError(naviteError);
  }
}

class MediaPlayer extends ChangeNotifier
    implements PMediaPlayer, PMediaPlayerListener {
  final MediaPlayerDataSource _dataSource;
  final _mediaPlayerInfoSubject = BehaviorSubject<PMediaPlayerInfo>();
  int? _textureId;
  int? get textureId => _textureId;
  Object? _error;
  Object? get error => _error;
  StackTrace? _stackTrace;
  StackTrace? get stackTrace => _stackTrace;
  PMediaPlayerNaviteError? _naviteError;
  PMediaPlayerNaviteError? get naviteError => _naviteError;
  PMediaPlayerState? _state;
  PMediaPlayerState? get state => _state;

  MediaPlayer(this._dataSource);

  void _cleanupState() {
    if (_textureId != null) {
      _MediaPlayerObserver.getInstance().setListener(_textureId!, null);
    }
    _textureId = null;
    _error = null;
    _stackTrace = null;
    _naviteError = null;
    _state = null;
  }

  Future<PMediaPlayerInfo> _getMediaPlayerInfo() =>
      _mediaPlayerInfoSubject.first;

  Future<void> init([String? tag]) async {
    assert(_textureId == null, 'Init must be called exactly once');
    _cleanupState();

    final dataSource = _dataSource;
    try {
      if (dataSource is HttpVideoDataSource) {
        final mediaPlayerInfo = await _mediaPlayerFactory.createHttpVideoPlayer(
          dataSource.url.toString(),
          tag,
        );
        _textureId = mediaPlayerInfo.textureId;
        _MediaPlayerObserver.getInstance().setListener(
          mediaPlayerInfo.textureId,
          this,
        );
        _mediaPlayerInfoSubject.add(mediaPlayerInfo);
        await prepare();
      } else {
        final error = UnimplementedError(
          'Unsupported data source: $_dataSource',
        );
        throw error;
      }
    } catch (e, st) {
      _error = e;
      _stackTrace = st;
      notifyListeners();
    }
  }

  @override
  Future<PVideoMeta> getVideoMeta() async =>
      _mediaPlayerProxy.getVideoMeta(await _getMediaPlayerInfo());

  @override
  Future<void> pause() async =>
      _mediaPlayerProxy.pause(await _getMediaPlayerInfo());

  @override
  Future<void> play() async =>
      _mediaPlayerProxy.play(await _getMediaPlayerInfo());

  @protected
  @override
  Future<void> release() async {
    _cleanupState();
    final mediaPlayerInfo = await _getMediaPlayerInfo();
    await _mediaPlayerProxy.release(mediaPlayerInfo);
  }

  @override
  Future<void> seekTo(int millisecond) async => _mediaPlayerProxy.seekTo(
        await _getMediaPlayerInfo(),
        millisecond,
      );

  @override
  void onStateChanged(PMediaPlayerStateEvent stateEvent) {
    _state = stateEvent.state;
    notifyListeners();
  }

  @protected
  @override
  Future<void> prepare() async =>
      _mediaPlayerProxy.prepare(await _getMediaPlayerInfo());

  @override
  Future<void> playPause() async =>
      _mediaPlayerProxy.playPause(await _getMediaPlayerInfo());

  @override
  void onError(PMediaPlayerNaviteError naviteError) {
    _naviteError = naviteError;
    notifyListeners();
  }

  @override
  Future<void> reuse() async =>
      _mediaPlayerProxy.reuse(await _getMediaPlayerInfo());

  @override
  void dispose() {
    release();
    super.dispose();
  }
}

abstract class MediaPlayerDataSource {}

class HttpVideoDataSource extends MediaPlayerDataSource {
  final Uri url;

  HttpVideoDataSource(this.url);

  @override
  String toString() {
    return url.toString();
  }
}
