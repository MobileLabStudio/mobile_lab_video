package lab.mobile.mobile_lab_video

import java.lang.ref.WeakReference

interface Disposable {
    fun dispose()
}

class CompositeDisposable : Disposable {
    private val disposables = mutableListOf<Disposable>()
    fun add(disposable: Disposable) {
        disposables.add(disposable)
    }

    override fun dispose() {
        for (disposable in disposables) {
            disposable.dispose()
        }
        disposables.clear()
    }
}