package lab.mobile.mobile_lab_video

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin

/** MobileLabVideoPlugin */
class MobileLabVideoPlugin : FlutterPlugin {

    lateinit var videoPlayerDelegate: VideoPlayerDelegate

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {

        videoPlayerDelegate = VideoPlayerDelegate(
            appContext = flutterPluginBinding.applicationContext,
            textureRegistry = flutterPluginBinding.textureRegistry,
            flutterVideoPlayerApi = Pigeon.FlutterVideoPlayerApi(flutterPluginBinding.binaryMessenger),
        )
        Pigeon.VideoPlayerDelegateApi.setup(
            flutterPluginBinding.binaryMessenger,
            videoPlayerDelegate
        )
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        videoPlayerDelegate.releaseAll()
    }
}
