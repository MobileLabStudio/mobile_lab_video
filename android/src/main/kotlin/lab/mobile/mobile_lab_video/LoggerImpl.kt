package lab.mobile.mobile_lab_video

class LoggerImpl private constructor() : Logger {

    override fun log(message: Any) {
        println("[VideoLog]: $message")
    }

    companion object {
        private var instance: Logger? = null

        fun getInstance() = instance ?: LoggerImpl().also { instance = it }
    }
}