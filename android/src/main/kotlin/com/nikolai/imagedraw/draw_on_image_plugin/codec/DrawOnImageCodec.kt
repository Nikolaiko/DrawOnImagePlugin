package com.nikolai.imagedraw.draw_on_image_plugin.codec

import com.nikolai.imagedraw.draw_on_image_plugin.utils.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodCodec
import java.lang.Exception
import java.nio.ByteBuffer

class DrawOnImageCodec : MethodCodec {
    private val reader = DrawOnImageReader()

    override fun decodeMethodCall(methodCall: ByteBuffer): MethodCall {
        val type = methodCall.get()
        val methodName = reader.readValueOfType(type, methodCall) as String
        val arguments = reader.decodeMessage(methodCall)
        return MethodCall(methodName, arguments)
    }

    override fun encodeSuccessEnvelope(result: Any?): ByteBuffer {
        val buffer = (result as String).toByteArray(Charsets.UTF_8)
        val resultBuffer = ByteBuffer.allocateDirect(buffer.size + 3)
        return resultBuffer.put(SUCCESS_ENVELOPE_CODE)
                .put(STRING_DATA_TYPE)
                .put(buffer.size.toByte())
                .put(buffer)
    }

    override fun encodeErrorEnvelope(errorCode: String, errorMessage: String?, errorDetails: Any?): ByteBuffer {
        val code: String = errorCode ?: unknownErrorCode
        val errorCodeBuffer = code.toByteArray(Charsets.UTF_8)

        val message: String = errorMessage ?: errorMessages[unknownErrorCode]!!
        val errorMessageBuffer = message.toByteArray(Charsets.UTF_8)

        val errorBuffer = ByteBuffer.allocateDirect(
                errorCodeBuffer.size + errorMessageBuffer.size + 5)

        errorBuffer.put(ERROR_ENVELOPE_CODE)
                .put(STRING_DATA_TYPE)
                .put(errorCodeBuffer.size.toByte())
                .put(errorCodeBuffer)
                .put(STRING_DATA_TYPE)
                .put(errorMessageBuffer.size.toByte())
                .put(errorMessageBuffer)
        return errorBuffer
    }

    override fun encodeErrorEnvelopeWithStacktrace(errorCode: String, errorMessage: String?, errorDetails: Any?, errorStacktrace: String?): ByteBuffer {
        return encodeErrorEnvelope(errorCode, errorMessage, errorDetails)
    }

    override fun encodeMethodCall(methodCall: MethodCall): ByteBuffer {
        TODO("Not yet implemented")
    }

    override fun decodeEnvelope(envelope: ByteBuffer) = Any()
}