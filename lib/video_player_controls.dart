abstract class VideoPlayerControls {
  void play();
  void pause();
  void seekTo(Duration point);
  void release();
  void reset();
  Future<bool> isPlaying();
}
