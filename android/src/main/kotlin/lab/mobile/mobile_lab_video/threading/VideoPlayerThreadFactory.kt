package lab.mobile.mobile_lab_video.threading

import android.content.Context
import androidx.annotation.UiThread
import io.flutter.view.TextureRegistry

class VideoPlayerThreadFactory(
    private val appContext: Context,
    private val textureRegistry: TextureRegistry,
) : MediaThreadFactory {

    @UiThread
    override fun newMediaThread(videoUri: String): VideoPlayerThread {
        val surfaceTextureEntry = textureRegistry.createSurfaceTexture()
        return VideoPlayerThread(
            appContext = appContext,
            textureId = surfaceTextureEntry.id(),
            texture = surfaceTextureEntry.surfaceTexture(),
            videoUri = videoUri,
        )
    }
}