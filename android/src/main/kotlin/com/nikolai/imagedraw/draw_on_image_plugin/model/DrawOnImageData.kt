package com.nikolai.imagedraw.draw_on_image_plugin.model

data class DrawOnImageData (
        val text: String,
        val left: Int,
        val right: Int,
        val top: Int,
        val bottom: Int,
        val color: Int,
        val size: Int,
        val imageCanvas: ByteArray
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as DrawOnImageData

        if (text != other.text) return false
        if (left != other.left) return false
        if (right != other.right) return false
        if (top != other.top) return false
        if (bottom != other.bottom) return false
        if (color != other.color) return false
        if (size != other.size) return false
        if (!imageCanvas.contentEquals(other.imageCanvas)) return false

        return true
    }

    override fun hashCode(): Int {
        var result = text.hashCode()
        result = 31 * result + left
        result = 31 * result + right
        result = 31 * result + top
        result = 31 * result + bottom
        result = 31 * result + color
        result = 31 * result + size
        result = 31 * result + imageCanvas.contentHashCode()
        return result
    }
}