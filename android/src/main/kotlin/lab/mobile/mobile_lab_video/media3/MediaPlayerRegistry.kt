package lab.mobile.mobile_lab_video.media3

import lab.mobile.mobile_lab_video.Disposable
import lab.mobile.mobile_lab_video.Pigeon

interface MediaPlayerRegistry : Disposable {
    fun register(textureId: Long, player: Pigeon.PMediaPlayer)
    fun unregister(textureId: Long)
    fun get(textureId: Long): Pigeon.PMediaPlayer
    fun getAll(): List<Pigeon.PMediaPlayer>
}