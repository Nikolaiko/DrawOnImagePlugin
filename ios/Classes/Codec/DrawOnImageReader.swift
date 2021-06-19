class DrawOnImageReader : FlutterStandardReader {
    override func readValue(ofType type: UInt8) -> Any? {
        switch type {
        case drawOnImageTypeId:
            let stringToWrite = super.readValue() as! String
            let left = super.readValue() as! NSNumber
            let right = super.readValue() as! NSNumber
            let top = super.readValue() as! NSNumber
            let bottom = super.readValue() as! NSNumber
            let color = super.readValue() as! NSNumber
            let size = super.readValue() as! NSNumber
            let imageCanvas = super.readValue() as! FlutterStandardTypedData
            return DrawOnImageData(
                stringToWrite: stringToWrite,
                leftPadding: left.intValue,
                rightPadding: right.intValue,
                topPadding: top.intValue,
                bottomPadding: bottom.intValue,
                fontColor: color.intValue,
                fontSize: size.intValue,
                imageCanvas: imageCanvas.data
            )
        default:
            return super.readValue(ofType: type)
        }
    }
}
