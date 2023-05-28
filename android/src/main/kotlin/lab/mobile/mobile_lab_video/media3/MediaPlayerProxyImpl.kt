package lab.mobile.mobile_lab_video.media3

import lab.mobile.mobile_lab_video.Pigeon

/**
 * Proxy for MediaPlayers. Is accessor to concrete player.
 * Communication with player must go through this class
 */
class MediaPlayerProxyImpl(private val mediaPlayerRegistry: MediaPlayerRegistry) :
    Pigeon.PMediaPlayerProxy {
    override fun prepare(mediaPlayerInfo: Pigeon.PMediaPlayerInfo) {
        mediaPlayerRegistry.get(mediaPlayerInfo.textureId).prepare()
    }

    override fun play(mediaPlayerInfo: Pigeon.PMediaPlayerInfo) {
        mediaPlayerRegistry.get(mediaPlayerInfo.textureId).play()
    }

    override fun pause(mediaPlayerInfo: Pigeon.PMediaPlayerInfo) {
        mediaPlayerRegistry.get(mediaPlayerInfo.textureId).pause()
    }

    override fun playPause(mediaPlayerInfo: Pigeon.PMediaPlayerInfo) {
        mediaPlayerRegistry.get(mediaPlayerInfo.textureId).playPause()
    }

    override fun reuse(mediaPlayerInfo: Pigeon.PMediaPlayerInfo) {
        mediaPlayerRegistry.get(mediaPlayerInfo.textureId).reuse()
    }

    override fun release(mediaPlayerInfo: Pigeon.PMediaPlayerInfo) {
        mediaPlayerRegistry.get(mediaPlayerInfo.textureId).release()
    }

    override fun getVideoMeta(mediaPlayerInfo: Pigeon.PMediaPlayerInfo): Pigeon.PVideoMeta {
        return mediaPlayerRegistry.get(mediaPlayerInfo.textureId).videoMeta
    }

    override fun seekTo(mediaPlayerInfo: Pigeon.PMediaPlayerInfo, millisecond: Long) {
        mediaPlayerRegistry.get(mediaPlayerInfo.textureId).seekTo(millisecond)
    }
}