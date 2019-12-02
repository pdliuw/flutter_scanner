package com.air.flutter_scanner

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/**
 * <p>
 * Created by air on 2019-12-02.
 * </p>
 */
class AndroidScannerViewFactory(private var binaryMessenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return AndroidScannerView(binaryMessenger, context, viewId, args);
    }
}