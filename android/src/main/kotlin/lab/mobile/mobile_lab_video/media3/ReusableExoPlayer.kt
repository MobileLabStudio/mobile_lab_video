package lab.mobile.mobile_lab_video.media3

import android.graphics.SurfaceTexture
import androidx.media3.exoplayer.ExoPlayer
import lab.mobile.mobile_lab_video.Disposable
import lab.mobile.mobile_lab_video.pool.Pool
import lab.mobile.mobile_lab_video.pool.Reusable

class ReusableExoPlayer(
    val textureId: Long,
    private val surfaceTexture: SurfaceTexture,
    private val exoPlayer: ExoPlayer,
    private val pool: Pool<ReusableExoPlayer>
) : ExoPlayer by exoPlayer, Reusable, Disposable {

    var owner: Any? = null

    override fun dispose() = exoPlayer.release()

    override fun reuse() = pool.release(this)

    override fun release() {
        exoPlayer.release()
        surfaceTexture.release()
    }
}