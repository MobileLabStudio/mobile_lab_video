package lab.mobile.mobile_lab_video.media3

import lab.mobile.mobile_lab_video.Pigeon

class MediaPlayerImpl(
    private val exoPlayerDelegate: ExoPlayerDelegate
) : Pigeon.PMediaPlayer {
    override fun prepare() {
        try {
            exoPlayerDelegate.prepare()
        } catch (e: Exception) {
            print(e)
        }
    }

    override fun play() {
        exoPlayerDelegate.play()
    }

    override fun pause() {
        exoPlayerDelegate.pause()
    }

    override fun playPause() {
        if (exoPlayerDelegate.isPlaying) {
            pause()
        } else {
            play()
        }
    }

    override fun reuse() {
        exoPlayerDelegate.reuse()
    }

    override fun release() {
        exoPlayerDelegate.release()
    }

    override fun getVideoMeta(): Pigeon.PVideoMeta {
        return Pigeon.PVideoMeta.Builder().setWidth(exoPlayerDelegate.videoSize.width.toLong())
            .setHeight(exoPlayerDelegate.videoSize.height.toLong()).build()
    }

    override fun seekTo(millisecond: Long) {
        exoPlayerDelegate.seekTo(millisecond)
    }
}

