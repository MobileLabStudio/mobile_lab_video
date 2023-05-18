import 'package:flutter/material.dart';
import 'package:mobile_lab_video_example/video_page.dart';
import 'package:mobile_lab_video_example/preload_pager.dart';

class VideoPager extends StatefulWidget {
  const VideoPager({super.key, required this.videos});

  final List<Uri> videos;

  @override
  State<VideoPager> createState() => _VideoPagerState();
}

class _VideoPagerState extends State<VideoPager> {
  late List<GlobalKey<VideoPageState>> keys;

  @override
  void didChangeDependencies() {
    keys = widget.videos.map((e) => GlobalKey<VideoPageState>()).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PreloadPager(
        preloadSize: 3,
        onPageChanged: (page, previousPage) {
          keys[page].currentState?.videoPlayer.play();
          keys[previousPage].currentState?.videoPlayer.pause();
        },
        children: [
          for (var i = 0; i < keys.length; i++)
            Center(
              child: VideoPage(
                key: keys[i],
                uri: widget.videos[i],
              ),
            )
        ],
      ),
    );
  }
}
