package lab.mobile.mobile_lab_video

import android.content.Context
import android.os.*
import io.flutter.view.TextureRegistry
import lab.mobile.mobile_lab_video.threading.VideoPlayerThread
import lab.mobile.mobile_lab_video.threading.VideoPlayerThreadFactory
import lab.mobile.mobile_lab_video.threading.VideoPlayerThreadHandler

class VideoPlayerDelegate(
    appContext: Context,
    textureRegistry: TextureRegistry,
    private val flutterVideoPlayerApi: Pigeon.FlutterVideoPlayerApi,
) : Pigeon.VideoPlayerDelegateApi {

    private val playerByThreadUUID = mutableMapOf<String, VideoPlayerThread>()
    private val videoPlayerThreadFactory: VideoPlayerThreadFactory = VideoPlayerThreadFactory(
        appContext = appContext,
        textureRegistry = textureRegistry,
    )

    override fun create(uri: String): String {
        val thread = videoPlayerThreadFactory.newMediaThread(uri)
        playerByThreadUUID[thread.uuid] = thread
        return thread.uuid
    }

    override fun isPlaying(playerId: String, result: Pigeon.Result<Boolean>) {
        val thread = playerByThreadUUID[playerId] ?: return result.success(false)
        val handler = Handler(Looper.getMainLooper()) {
            val isPlaying = it.data.getBoolean(VideoPlayerThreadHandler.Arg.IS_PLAYING)
            result.success(isPlaying)
            true
        }
        val message = Message.obtain().apply {
            arg1 = VideoPlayerThread.Event.IS_PLAYING
            replyTo = Messenger(handler)
        }
        thread.handler.sendMessage(message)
    }

    override fun reset(playerId: String) {
        playerByThreadUUID[playerId]?.sendEvent(VideoPlayerThread.Event.RESET)
    }

    override fun seekTo(milliseconds: Long, playerId: String) {
        val thread = playerByThreadUUID[playerId] ?: return
        thread.sendEvent(VideoPlayerThread.Event.SEEK_TO, extra = Bundle().apply {
            putLong(VideoPlayerThread.Arg.SEEK_TO_POSITION, milliseconds)
        })
    }

    override fun release(playerId: String) {
        playerByThreadUUID[playerId]?.sendEvent(VideoPlayerThread.Event.RELEASE)
    }

    override fun pause(playerId: String) {
        playerByThreadUUID[playerId]?.sendEvent(VideoPlayerThread.Event.PAUSE)
    }

    override fun play(playerId: String) {
        playerByThreadUUID[playerId]?.sendEvent(VideoPlayerThread.Event.PLAY)
    }

    @Suppress("UNCHECKED_CAST")
    override fun prepare(playerId: String, result: Pigeon.Result<Pigeon.VideoDetails>) {
        val thread = playerByThreadUUID[playerId]
            ?: return result.error(IllegalStateException("Player thread not found"))
        if (thread.isAlive) {
            throw IllegalStateException("prepare can be called once")
        }

        // Handler used to signal when thread is ready
        val onReadyHandler = Handler(Looper.getMainLooper()) {
            // VideoDetails handler
            val handler = Handler(Looper.getMainLooper()) {
                val videoDetails = it.data.toVideoDetails()
                result.success(videoDetails)
                true
            }
            // Sending prepare request
            val message = Message.obtain().apply {
                arg1 = VideoPlayerThread.Event.PREPARE
                replyTo = Messenger(handler)
            }
            thread.handler.sendMessage(message)
            true
        }
        // Started thread
        thread.start(Messenger(onReadyHandler))
    }

    override fun releaseAll() {
        for (player in playerByThreadUUID.values) {
            player.releaseAndDestroy()
        }
        playerByThreadUUID.clear()
    }
}