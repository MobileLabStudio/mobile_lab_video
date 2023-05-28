package lab.mobile.mobile_lab_video.media3

import androidx.media3.common.PlaybackException
import androidx.media3.common.Player
import androidx.media3.exoplayer.ExoPlayer
import lab.mobile.mobile_lab_video.Pigeon
import lab.mobile.mobile_lab_video.pool.Reusable

class ExoPlayerDelegate(
    val textureId: Long,
    private val reusableExoPlayer: ReusableExoPlayer,
    private val mediaPlayerListener: Pigeon.PMediaPlayerListener,
    private val mediaPlayerRegistry: MediaPlayerRegistry,
) : ExoPlayer by reusableExoPlayer,
    Player.Listener, Reusable by reusableExoPlayer {

    init {
        reusableExoPlayer.addListener(this)
    }

    override fun onPlaybackStateChanged(playbackState: Int) {
        mediaPlayerListener.onStateChanged(
            Pigeon.PMediaPlayerStateEvent.Builder()
                .setTextureId(textureId)
                .setState(
                    when (playbackState) {
                        Player.STATE_READY -> Pigeon.PMediaPlayerState.READY
                        Player.STATE_BUFFERING -> Pigeon.PMediaPlayerState.BUFFERING
                        Player.STATE_ENDED -> Pigeon.PMediaPlayerState.ENDED
                        Player.STATE_IDLE -> Pigeon.PMediaPlayerState.IDLE
                        else -> throw IllegalStateException("Unknown ExoPlayer event")
                    }
                )
                .build()
        ) {}
    }

    override fun onPlayerError(error: PlaybackException) {
        mediaPlayerListener.onError(
            Pigeon.PMediaPlayerNaviteError.Builder()
                .setTextureId(textureId)
                .setDetails(
                    mapOf(
                        "errorCode" to error.errorCode,
                        "errorCodeName" to error.errorCodeName,
                        "timestampMs" to error.timestampMs,
                        "message" to error.message
                    )
                )
                .build()
        ) {}
    }

    override fun release() {
        reusableExoPlayer.release()
        mediaPlayerRegistry.unregister(textureId)
    }
}