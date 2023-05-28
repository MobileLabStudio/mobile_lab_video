import 'package:flutter/material.dart';
import 'package:mobile_lab_video/mobile_lab_video.dart';
import 'package:mobile_lab_video_example/preload_pager.dart';

class VideoPager extends StatefulWidget {
  const VideoPager({super.key, required this.videos});

  final List<Uri> videos;

  @override
  State<VideoPager> createState() => _VideoPagerState();
}

class _VideoPagerState extends State<VideoPager> {
  late List<GlobalKey<MediaPlayerWidgetState>> keys;

  @override
  void didChangeDependencies() {
    keys = widget.videos
        .map(
          (e) => GlobalKey<MediaPlayerWidgetState>(),
        )
        .toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PreloadPager(
        preloadSize: 1,
        onPageChanged: (page, previousPage) {
          keys[page].currentState?.mediaPlayer
            ?..seekTo(0)
            ..play();
          keys[previousPage].currentState?.mediaPlayer.pause();
        },
        children: [
          for (var i = 0; i < keys.length; i++)
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  MediaPlayerWidget(
                    key: keys[i],
                    dataSource: HttpVideoDataSource(widget.videos[i]),
                    tag: 'Video at index $i',
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      color: Colors.red,
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.videos[i].toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
