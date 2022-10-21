import 'package:flutter/material.dart';
import 'package:mobile_lab_video_example/video_page.dart';

class VideoPager extends StatefulWidget {
  const VideoPager({super.key, required this.videos});

  final List<Uri> videos;

  @override
  State<VideoPager> createState() => _VideoPagerState();
}

class _VideoPagerState extends State<VideoPager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: widget.videos.length,
        itemBuilder: (context, index) => Center(
          child: VideoPage(
            key: ValueKey(index),
            uri: widget.videos[index],
          ),
        ),
      ),
    );
  }
}
