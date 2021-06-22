package com.nikolai.imagedraw.draw_on_image_plugin

import androidx.annotation.NonNull
import com.nikolai.imagedraw.draw_on_image_plugin.codec.DrawOnImageCodec
import com.nikolai.imagedraw.draw_on_image_plugin.helpers.ImageHelper
import com.nikolai.imagedraw.draw_on_image_plugin.model.DrawOnImageData
import com.nikolai.imagedraw.draw_on_image_plugin.utils.CHANNEL_NAME
import com.nikolai.imagedraw.draw_on_image_plugin.utils.DRAW_METHOD_NAME
import com.nikolai.imagedraw.draw_on_image_plugin.utils.errorMessages
import com.nikolai.imagedraw.draw_on_image_plugin.utils.wrongParameterType

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

class DrawOnImagePlugin: FlutterPlugin, MethodCallHandler {
    private lateinit var channel : MethodChannel
    private lateinit var imageHelper: ImageHelper

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
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
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
