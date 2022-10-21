package lab.mobile.mobile_lab_video.threading

import android.content.Context
import android.graphics.SurfaceTexture
import android.os.*
import java.util.*

class VideoPlayerThread(
    private val appContext: Context,
    private val textureId: Long,
    private val texture: SurfaceTexture,
    private val videoUri: String,
) : Thread("VideoPlayerThread(videoUri = $videoUri)") {

    val uuid = UUID.randomUUID().toString()
    private var messenger: Messenger? = null
    private var _handler: VideoPlayerThreadHandler? = null
    val handler: Handler
        get() {
            return _handler!!
        }

    fun start(messenger: Messenger) {
        this.messenger = messenger
        start()
    }

    override fun run() {
        Looper.prepare()
        val looper = Looper.myLooper()!!
        _handler = VideoPlayerThreadHandler(
            looper,
            appContext,
            videoUri,
            textureId,
            texture,
        )
        messenger?.send(Message.obtain().apply { arg1 = Reply.READY })
        Looper.loop()
    }

    fun sendEvent(event: Int, extra: Bundle? = null) {
        _handler?.apply {
            val newMessage = Message.obtain().apply {
                arg1 = event
                data = extra
            }
            sendMessage(newMessage)
        }
    }

    fun releaseAndDestroy() {
        _handler?.release()
    }

    object Arg {
        const val SEEK_TO_POSITION = "seekToPosition"
    }

    object Reply {
        const val READY = 0
    }

    object Event {
        const val PREPARE = 0
        const val RELEASE = 1
        const val RESET = 2
        const val PLAY = 3
        const val PAUSE = 4
        const val IS_PLAYING = 5
        const val SEEK_TO = 6
    }
}