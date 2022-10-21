import 'package:flutter/material.dart';
import 'package:mobile_lab_video/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({super.key, required this.videoPlayer});

  final VideoPlayer videoPlayer;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final details = videoPlayer.videoDetails;
      final surfaceId = details.surfaceId;

      final double height;
      final double width;
      if (constraints.maxWidth > constraints.maxHeight) {
        final screenHeight = constraints.maxHeight;
        final ratio = screenHeight / details.height;
        height = screenHeight;
        width = details.width * ratio;
      } else {
        final screenWidth = constraints.maxWidth;
        final ratio = screenWidth / details.width;
        width = screenWidth;
        height = details.height * ratio;
      }

      return SizedBox(
        width: width,
        height: height,
        child: VideoPlayerWithControls(
          surfaceId: surfaceId,
          videoPlayer: videoPlayer,
        ),
      );
    });
  }
}

class VideoPlayerWithControls extends StatefulWidget {
  const VideoPlayerWithControls({
    super.key,
    required this.surfaceId,
    required this.videoPlayer,
  });

  final int surfaceId;
  final VideoPlayer videoPlayer;

  @override
  State<VideoPlayerWithControls> createState() =>
      _VideoPlayerWithControlsState();
}

class _VideoPlayerWithControlsState extends State<VideoPlayerWithControls> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: widget.videoPlayer.isPlaying(),
      builder: (context, snapshot) {
        final isPlaying = snapshot.data ?? false;
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isPlaying) {
                widget.videoPlayer.pause();
              } else {
                widget.videoPlayer.play();
              }
            });
          },
          child: Texture(textureId: widget.surfaceId),
        );
      },
    );
  }
}
