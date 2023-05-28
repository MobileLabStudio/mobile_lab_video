package lab.mobile.mobile_lab_video

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import lab.mobile.mobile_lab_video.media3.ExoPlayerPool
import lab.mobile.mobile_lab_video.media3.MediaPlayerFactoryImpl
import lab.mobile.mobile_lab_video.media3.MediaPlayerProxyImpl
import lab.mobile.mobile_lab_video.media3.MediaPlayerRegistry
import lab.mobile.mobile_lab_video.media3.MediaPlayerRegistryImpl

/** MobileLabVideoPlugin */
class MobileLabVideoPlugin : FlutterPlugin, ActivityAware {

    lateinit var mediaPlayerFactory: Pigeon.PMediaPlayerFactory
    lateinit var mediaPlayerProxy: Pigeon.PMediaPlayerProxy
    lateinit var exoPlayerPool: ExoPlayerPool
    lateinit var mediaPlayerRegistry: MediaPlayerRegistry
    private val compositeDisposable by lazy { CompositeDisposable() }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        exoPlayerPool = ExoPlayerPool(
            flutterPluginBinding.textureRegistry,
            flutterPluginBinding.applicationContext,
            LoggerImpl.getInstance()
        )
        mediaPlayerRegistry = MediaPlayerRegistryImpl().also(compositeDisposable::add)
        mediaPlayerFactory = MediaPlayerFactoryImpl(
            pool = exoPlayerPool,
            mediaPlayerRegistry = mediaPlayerRegistry,
            mediaPlayerListener = Pigeon.PMediaPlayerListener(flutterPluginBinding.binaryMessenger),
        )
        mediaPlayerProxy = MediaPlayerProxyImpl(mediaPlayerRegistry)
        Pigeon.PMediaPlayerProxy.setup(flutterPluginBinding.binaryMessenger, mediaPlayerProxy)
        Pigeon.PMediaPlayerFactory.setup(flutterPluginBinding.binaryMessenger, mediaPlayerFactory)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        compositeDisposable.dispose()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }
}
