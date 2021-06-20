package com.nikolai.imagedraw.draw_on_image_plugin.codec

import com.nikolai.imagedraw.draw_on_image_plugin.model.DrawOnImageData
import com.nikolai.imagedraw.draw_on_image_plugin.utils.DRAW_ON_IMAGE_DATA_TYPE
import io.flutter.plugin.common.StandardMessageCodec
import java.nio.ByteBuffer

class DrawOnImageReader : StandardMessageCodec() {
    public override fun readValueOfType(type: Byte, buffer: ByteBuffer?): Any {
        println("It's type : $type")
        return when (type) {
            DRAW_ON_IMAGE_DATA_TYPE -> {
                val text = super.readValue(buffer) as String
                val left = super.readValue(buffer) as Int
                val right = super.readValue(buffer) as Int
                val top = super.readValue(buffer) as Int
                val bottom = super.readValue(buffer) as Int
                val color = super.readValue(buffer) as Long
                val size = super.readValue(buffer) as Int
                val imageCanvas = super.readValue(buffer) as ByteArray

                DrawOnImageData(
                        text,
                        left,
                        right,
                        top,
                        bottom,
                        color.toInt(),
                        size,
                        imageCanvas
                )
            }
            else -> super.readValueOfType(type, buffer)
        }
    }
}