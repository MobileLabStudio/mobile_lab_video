package lab.mobile.mobile_lab_video.threading

interface MediaThreadFactory {
    fun newMediaThread(videoUri: String): VideoPlayerThread
}