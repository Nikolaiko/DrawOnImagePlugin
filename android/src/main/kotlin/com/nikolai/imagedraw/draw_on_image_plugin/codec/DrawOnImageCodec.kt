package com.nikolai.imagedraw.draw_on_image_plugin.codec

import com.nikolai.imagedraw.draw_on_image_plugin.utils.DRAW_METHOD_NAME
import com.nikolai.imagedraw.draw_on_image_plugin.utils.STRING_DATA_TYPE
import com.nikolai.imagedraw.draw_on_image_plugin.utils.SUCCESS_ENVELOPE_CODE
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodCodec
import java.lang.Exception
import java.nio.ByteBuffer

class DrawOnImageCodec : MethodCodec {
    private val reader = DrawOnImageReader()

    override fun decodeMethodCall(methodCall: ByteBuffer?): MethodCall {
        val type = methodCall?.get() ?: 0
        val methodName = reader.readValueOfType(type, methodCall) as String
        val arguments = reader.decodeMessage(methodCall)
        return MethodCall(methodName, arguments)
    }

    override fun encodeSuccessEnvelope(result: Any?): ByteBuffer {
        val buffer = (result as String).toByteArray(Charsets.UTF_8)
        val resultBuffer = ByteArray(buffer.size + 2)

        resultBuffer.set(0, SUCCESS_ENVELOPE_CODE)
        resultBuffer.set(1, STRING_DATA_TYPE)
        buffer.copyInto(resultBuffer, 2)

        return ByteBuffer.wrap(resultBuffer)
    }

    override fun encodeErrorEnvelope(errorCode: String?, errorMessage: String?, errorDetails: Any?): ByteBuffer {
        TODO("Not yet implemented")
    }

    override fun encodeErrorEnvelopeWithStacktrace(errorCode: String?, errorMessage: String?, errorDetails: Any?, errorStacktrace: String?): ByteBuffer {
        TODO("Not yet implemented")
    }

    override fun encodeMethodCall(methodCall: MethodCall?): ByteBuffer {
        TODO("Not yet implemented")
    }

    override fun decodeEnvelope(envelope: ByteBuffer?) = Any()
}