package lab.mobile.mobile_lab_video.pool

abstract class Pool<T : Reusable>(val maxSize: Int?) {
    @Throws(PoolSizeExceedException::class)
    abstract fun acquire(owner: Any? = null): T

    @Throws(UnknownInstanceException::class)
    abstract fun release(instance: T)
}

class PoolSizeExceedException(maxSize: Int?) : Exception("Pool size exceeded. Max size is $maxSize")
class UnknownInstanceException(pool: Pool<*>, instance: Any) :
    Exception(
        """
        Unknown instance. Object is not created by this pool.
        Pool: $pool
        Instance: $instance
    """.trimIndent()
    )

interface Reusable {
    fun reuse()
}