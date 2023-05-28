package lab.mobile.mobile_lab_video.media3

import lab.mobile.mobile_lab_video.Pigeon

class MediaPlayerRegistryImpl : MediaPlayerRegistry {

    private val map = mutableMapOf<Long, Pigeon.PMediaPlayer>()

    override fun register(textureId: Long, player: Pigeon.PMediaPlayer) {
        map[textureId] = player
    }

    override fun unregister(textureId: Long) {
        map.remove(textureId)
    }

    override fun get(textureId: Long): Pigeon.PMediaPlayer = map[textureId]!!

    override fun getAll(): List<Pigeon.PMediaPlayer> = map.values.toList()

    override fun dispose() {
        val iterator = map.iterator()
        while (iterator.hasNext()) {
            iterator.next().value.release()
            iterator.remove()
        }
    }
}