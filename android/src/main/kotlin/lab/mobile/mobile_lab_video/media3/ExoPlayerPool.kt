package lab.mobile.mobile_lab_video.media3

import android.content.Context
import android.view.Surface
import androidx.media3.database.StandaloneDatabaseProvider
import androidx.media3.datasource.DefaultDataSource
import androidx.media3.datasource.DefaultHttpDataSource
import androidx.media3.datasource.FileDataSource
import androidx.media3.datasource.cache.CacheDataSink
import androidx.media3.datasource.cache.CacheDataSource
import androidx.media3.datasource.cache.NoOpCacheEvictor
import androidx.media3.datasource.cache.SimpleCache
import androidx.media3.datasource.okhttp.OkHttpDataSource
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.source.DefaultMediaSourceFactory
import io.flutter.view.TextureRegistry
import lab.mobile.mobile_lab_video.Logger
import lab.mobile.mobile_lab_video.pool.Pool
import lab.mobile.mobile_lab_video.pool.PoolSizeExceedException
import lab.mobile.mobile_lab_video.pool.UnknownInstanceException
import java.io.File
import java.util.concurrent.ConcurrentLinkedQueue

class ExoPlayerPool(
    private val textureRegistry: TextureRegistry,
    private val context: Context,
    private val logger: Logger
) : Pool<ReusableExoPlayer>(maxSize = 5) {

    private val released = ConcurrentLinkedQueue<ReusableExoPlayer>()
    private val inUse = mutableMapOf<Long, ReusableExoPlayer>()
    private val cacheDataSourceFactory by lazy {
        val downloadContentDirectory = File(context.cacheDir, "downloads")
        val downloadCache =
            SimpleCache(
                downloadContentDirectory,
                NoOpCacheEvictor(),
                StandaloneDatabaseProvider(context)
            )

        val cacheSink = CacheDataSink.Factory()
            .setCache(downloadCache)
        val upstreamFactory = DefaultDataSource.Factory(context, DefaultHttpDataSource.Factory())
        val downStreamFactory = FileDataSource.Factory()
        CacheDataSource.Factory()
            .setCache(downloadCache)
            .setCacheWriteDataSinkFactory(cacheSink)
            .setCacheReadDataSourceFactory(downStreamFactory)
            .setUpstreamDataSourceFactory(upstreamFactory)
            .setFlags(CacheDataSource.FLAG_IGNORE_CACHE_ON_ERROR)
    }

    override fun acquire(owner: Any?): ReusableExoPlayer {
        val player = released.poll()
        if (player != null) {
            logger.log("Owner $owner reused player with textureId ${player.textureId} owned by ${player.owner}")
            player.owner = owner
            inUse[player.textureId] = player
            return player
        }
        if (maxSize != null && inUse.size >= maxSize) {
            logger.log("Owner $owner exceed pool. Current size: ${inUse.size} Max size: $maxSize")
            throw PoolSizeExceedException(maxSize)
        }
        val surfaceTextureEntry = textureRegistry.createSurfaceTexture()
        val textureId = surfaceTextureEntry.id()
        val surfaceTexture = surfaceTextureEntry.surfaceTexture()
        return ExoPlayer.Builder(context)
            .setMediaSourceFactory(
                DefaultMediaSourceFactory(context).setDataSourceFactory(
                    cacheDataSourceFactory
                )
            )
            .build()
            .run {
                ReusableExoPlayer(
                    textureId = textureId,
                    surfaceTexture = surfaceTexture,
                    exoPlayer = this,
                    pool = this@ExoPlayerPool
                )
            }
            .also {
                it.owner = owner
                it.setVideoSurface(Surface(surfaceTexture))
                inUse[it.textureId] = it
                logger.log("New player with textureId ${it.textureId} was created and is owned by ${it.owner}")
            }
    }

    override fun release(instance: ReusableExoPlayer) {
        val thisPollInstance = inUse.remove(instance.textureId)
        val owner = thisPollInstance?.owner
        released.add(thisPollInstance?.also { it.owner = null }
            ?: throw UnknownInstanceException(this, instance)
        )
        logger.log("Player with textureId ${instance.textureId} was released. Was owned by $owner")
    }
}

