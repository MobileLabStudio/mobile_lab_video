package lab.mobile.mobile_lab_video.threading

import android.content.Context
import android.graphics.SurfaceTexture
import android.media.AudioAttributes
import android.media.MediaPlayer
import android.net.Uri
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.Message
import android.view.Surface
import lab.mobile.mobile_lab_video.Pigeon
import lab.mobile.mobile_lab_video.toBundle

class VideoPlayerThreadHandler(
    looper: Looper,
    private val appContext: Context,
    private val videoUri: String,
    private val textureId: Long,
    private val texture: SurfaceTexture,
) :
    Handler(looper),
    MediaPlayer.OnErrorListener,
    MediaPlayer.OnCompletionListener,
    MediaPlayer.OnBufferingUpdateListener,
    MediaPlayer.OnPreparedListener {

    private var mediaPlayer: MediaPlayer? = null

    override fun handleMessage(msg: Message) {
        when (msg.arg1) {
            VideoPlayerThread.Event.PREPARE -> {
                val videoPlayerDetails = createVideoPlayer()
                val reply = Message.obtain().apply {
                    data = videoPlayerDetails.toBundle()
                }
                msg.replyTo.send(reply)
            }
            VideoPlayerThread.Event.RELEASE -> release()
            VideoPlayerThread.Event.RESET -> mediaPlayer?.reset()
            VideoPlayerThread.Event.PLAY -> mediaPlayer?.start()
            VideoPlayerThread.Event.PAUSE -> mediaPlayer?.pause()
            VideoPlayerThread.Event.IS_PLAYING -> {
                val reply = Message.obtain().apply {
                    data = Bundle().apply {
                        putBoolean(Arg.IS_PLAYING, mediaPlayer?.isPlaying ?: false)
                    }
                }
                msg.replyTo.send(reply)
            }
        }
    }

    private fun createVideoPlayer(): Pigeon.VideoDetails {
        mediaPlayer = MediaPlayer().apply {
            setSurface(Surface(texture))
            setAudioAttributes(
                AudioAttributes.Builder()
                    .setContentType(AudioAttributes.CONTENT_TYPE_MOVIE)
                    .setUsage(AudioAttributes.USAGE_MEDIA)
                    .build()
            )
            setDataSource(appContext, Uri.parse(videoUri))
            setOnErrorListener(this@VideoPlayerThreadHandler)
            setOnCompletionListener(this@VideoPlayerThreadHandler)
            setOnBufferingUpdateListener(this@VideoPlayerThreadHandler)
            setOnPreparedListener(this@VideoPlayerThreadHandler)
        }
        // TODO(sb): Throws exceptions, handle
        mediaPlayer!!.prepare()
        return Pigeon.VideoDetails.Builder()
            .setWidth(mediaPlayer!!.videoWidth.toLong())
            .setHeight(mediaPlayer!!.videoHeight.toLong())
            .setSurfaceId(textureId)
            .build()
    }

    override fun onError(mp: MediaPlayer?, what: Int, extra: Int): Boolean {
        return true
    }

    override fun onCompletion(mp: MediaPlayer?) {
    }

    override fun onBufferingUpdate(mp: MediaPlayer?, percent: Int) {
    }

    override fun onPrepared(percent: MediaPlayer?) {
    }

    private fun mapMediaPlayerError(what: Int, extra: Int): Pigeon.VideoPlayerError {
        return when (extra) {
            MediaPlayer.MEDIA_ERROR_IO -> Pigeon.VideoPlayerError.IO
            MediaPlayer.MEDIA_ERROR_MALFORMED -> Pigeon.VideoPlayerError.MALFORMED
            MediaPlayer.MEDIA_ERROR_UNSUPPORTED -> Pigeon.VideoPlayerError.UNKNOWN
            MediaPlayer.MEDIA_ERROR_TIMED_OUT -> Pigeon.VideoPlayerError.TIMED_OUT
            else -> when (what) {
                MediaPlayer.MEDIA_ERROR_SERVER_DIED -> Pigeon.VideoPlayerError.SERVER_DIED
                else -> Pigeon.VideoPlayerError.UNKNOWN
            }
        }
    }

    fun release() {
        mediaPlayer?.release()
        looper.quit()
    }

    object Arg {
        const val SURFACE_ID = "surfaceId"
        const val IS_PLAYING = "isPlaying"
        const val VIDEO_DETAILS = "videoDetails"
    }
}