package lab.mobile.mobile_lab_video

import android.os.Bundle

fun Pigeon.VideoDetails.toBundle(): Bundle {
    return Bundle().apply {
        putLong("width", width)
        putLong("height", height)
        putLong("surfaceId", surfaceId)
    }
}

fun Bundle.toVideoDetails(): Pigeon.VideoDetails {
    return Pigeon.VideoDetails.Builder()
        .setWidth(getLong("width"))
        .setHeight(getLong("height"))
        .setSurfaceId(getLong("surfaceId"))
        .build()
}