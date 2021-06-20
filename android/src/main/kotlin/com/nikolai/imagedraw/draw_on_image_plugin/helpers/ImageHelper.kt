package com.nikolai.imagedraw.draw_on_image_plugin.helpers

import android.graphics.*
import android.text.Layout
import android.text.StaticLayout
import android.text.TextPaint
import com.nikolai.imagedraw.draw_on_image_plugin.model.DrawOnImageData
import java.io.File
import java.io.FileOutputStream

class ImageHelper(
        private val filesDirectory: File
) {

    fun drawOnImage(data: DrawOnImageData): String {
        //val stream = assetsManager.open(imageNames[imageIndex])

        val newImgFile = File("${filesDirectory.path}/app_flutter/test.png")
        if (newImgFile.exists()) {
            newImgFile.delete()
        }
        val out = FileOutputStream(newImgFile)

        val initialBitmap = BitmapFactory.decodeByteArray(data.imageCanvas, 0, data.imageCanvas.size)
        val copyBitmap = initialBitmap.copy(Bitmap.Config.ARGB_8888, true)

        val paint = Paint()
        paint.color = Color.WHITE
        paint.textSize = data.size.toFloat()
        paint.xfermode = PorterDuffXfermode(PorterDuff.Mode.SRC_OVER)

        val canvas = Canvas(copyBitmap)
        canvas.drawBitmap(copyBitmap, 0.0f, 0.0f, paint)

        val rect = RectF(
                data.left.toFloat(),
                data.top.toFloat(),
                initialBitmap.width - data.right.toFloat(),
                initialBitmap.height - data.bottom.toFloat()
        )
        val textPaint = TextPaint(paint)
        val sl = StaticLayout(
                data.text,
                textPaint,
                rect.width().toInt(),
                Layout.Alignment.ALIGN_NORMAL,
                1.0f,
                1.0f,
                false
        )

        canvas.save()
        canvas.translate(rect.left, rect.top)

        sl.draw(canvas)
        canvas.restore()
        copyBitmap.compress(Bitmap.CompressFormat.JPEG, 90, out)

        out.flush()
        out.close()

        return newImgFile.absolutePath
    }
}