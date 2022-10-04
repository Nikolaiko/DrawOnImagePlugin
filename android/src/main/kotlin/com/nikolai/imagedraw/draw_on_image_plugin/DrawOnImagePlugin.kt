package com.nikolai.imagedraw.draw_on_image_plugin

import android.app.Application
import android.content.Context
import androidx.annotation.NonNull
import com.nikolai.imagedraw.draw_on_image_plugin.codec.DrawOnImageCodec
import com.nikolai.imagedraw.draw_on_image_plugin.helpers.ImageHelper
import com.nikolai.imagedraw.draw_on_image_plugin.model.DrawOnImageData
import com.nikolai.imagedraw.draw_on_image_plugin.utils.*

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.util.PathUtils
import java.io.File

class DrawOnImagePlugin: FlutterPlugin, MethodCallHandler {
    private lateinit var channel : MethodChannel
    private lateinit var imageHelper: ImageHelper
    private lateinit var appContext: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        appContext = flutterPluginBinding.applicationContext
        imageHelper = ImageHelper(flutterPluginBinding.applicationContext.dataDir)
        channel = MethodChannel(
                flutterPluginBinding.binaryMessenger,
                CHANNEL_NAME,
                DrawOnImageCodec()
        )
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            DRAW_METHOD_NAME -> {
                when(call.arguments is DrawOnImageData) {
                    true -> {
                        val fileName = imageHelper.drawOnImage(call.arguments as DrawOnImageData)
                        result.success(fileName)
                    }
                    false -> {
                        result.error(wrongParameterType, errorMessages[wrongParameterType], null)
                    }
                }
            }
            TARGET_PATH_NAME -> result.success(PathUtils.getDataDirectory(appContext))
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
