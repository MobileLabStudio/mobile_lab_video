package lab.mobile.mobile_lab_video.media3

import android.net.Uri
import androidx.media3.common.C
import androidx.media3.common.MediaItem
import androidx.media3.exoplayer.ExoPlayer
import lab.mobile.mobile_lab_video.Pigeon
import lab.mobile.mobile_lab_video.pool.Pool

class MediaPlayerFactoryImpl(
    private val pool: Pool<ReusableExoPlayer>,
    private val mediaPlayerRegistry: MediaPlayerRegistry,
    private val mediaPlayerListener: Pigeon.PMediaPlayerListener,
) : Pigeon.PMediaPlayerFactory {

    override fun createHttpVideoPlayer(
        httpUrl: String,
        tag: String?,
        result: Pigeon.Result<Pigeon.PMediaPlayerInfo>
    ) {
        try {
            val exoPlayerDelegate = pool.acquire(tag)
                .apply {
                    playWhenReady = false
                    repeatMode = ExoPlayer.REPEAT_MODE_ONE
                    setMediaItem(
                        MediaItem.Builder()
                            .setUri(Uri.parse(httpUrl))
                            .setTag(tag)
                            .build()
                    )
                }
                .run {
                    ExoPlayerDelegate(
                        textureId = textureId,
                        reusableExoPlayer = this,
                        mediaPlayerListener = mediaPlayerListener,
                        mediaPlayerRegistry = mediaPlayerRegistry
                    )
                }

            mediaPlayerRegistry.register(
                exoPlayerDelegate.textureId,
                MediaPlayerImpl(exoPlayerDelegate)
            )

            result.success(
                Pigeon.PMediaPlayerInfo.Builder()
                    .setTextureId(exoPlayerDelegate.textureId)
                    .build()
            )
        } catch (e: Exception) {
            result.error(e)
        }
    }

    override fun createHLSVideoStream(
        hlsUrl: String,
        tag: String?,
        result: Pigeon.Result<Pigeon.PMediaPlayerInfo>
    ) {
        TODO("Not yet implemented")
    }
}

