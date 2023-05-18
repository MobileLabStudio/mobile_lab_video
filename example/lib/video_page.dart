import 'package:flutter/material.dart';
import 'package:mobile_lab_video/mobile_lab_video.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key, required this.uri});

  final Uri uri;

  @override
  State<VideoPage> createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  late VideoPlayer videoPlayer;
  Object? error;
  StackTrace? stackTrace;

  Future<void> initVideoPlayer() async {
    try {
      await videoPlayer.init();
    } catch (e, st) {
      error = e;
      stackTrace = st;
    }
    if (mounted) {
      setState(() {});
    }
  }


  @override
  void initState() {
    super.initState();
    videoPlayer = VideoPlayerFactory.instance().create(widget.uri.toString());
    initVideoPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayer.release();
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayer.isPrepared) {
      return VideoPlayerWidget(videoPlayer: videoPlayer);
    }

    if (error != null) {
      return Center(child: Text(error.toString()));
    }

    return const Center(child: CircularProgressIndicator());
  }
}
