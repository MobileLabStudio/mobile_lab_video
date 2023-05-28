import 'package:flutter/material.dart';
import 'package:mobile_lab_video/pigeon.dart';

import 'media_player.dart';

class MediaPlayerWidget extends StatefulWidget {
  const MediaPlayerWidget({
    super.key,
    required this.dataSource,
    this.tag,
  });

  final MediaPlayerDataSource dataSource;
  final String? tag;

  @override
  State<MediaPlayerWidget> createState() => MediaPlayerWidgetState();
}

class MediaPlayerWidgetState extends State<MediaPlayerWidget> {
  late MediaPlayer _mediaPlayer;
  MediaPlayer get mediaPlayer => _mediaPlayer;
  late PVideoMeta _videoMeta;
  bool _isReady = false;
  Object? _error;

  void onPlayerStateChanged() {
    if (_mediaPlayer.error != null || _mediaPlayer.naviteError != null) {
      setState(() {
        _error = _mediaPlayer.error ?? _mediaPlayer.naviteError;
      });
    } else if (_mediaPlayer.state == PMediaPlayerState.ready) {
      mediaPlayer.getVideoMeta().then((value) {
        setState(() {
          _videoMeta = value;
          _isReady = true;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _mediaPlayer = MediaPlayer(widget.dataSource)
      ..addListener(onPlayerStateChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mediaPlayer.init(widget.tag);
    });
  }

  @override
  void dispose() {
    mediaPlayer.removeListener(onPlayerStateChanged);
    mediaPlayer.reuse();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return ClipRect(child: ErrorWidget(_error!));
    }

    if (_isReady) {
      return ClipRect(
        child: AspectRatio(
          aspectRatio: _videoMeta.width / _videoMeta.height,
          child: GestureDetector(
            onTap: () => mediaPlayer.playPause(),
            child: Texture(
              textureId: mediaPlayer.textureId!,
            ),
          ),
        ),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
