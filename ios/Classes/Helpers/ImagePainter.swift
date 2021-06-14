import Foundation

struct ImagePainter {
    func drawOnImage(drawData: DrawOnImageData) -> UIImage? {
        guard let image = UIImage(data: drawData.imageCanvas) else { return nil }
        let textColor = UIColor.fromInt(argbValue: drawData.fontColor)
        let textFont = buildFont(drawData: drawData)
        let scale = UIScreen.main.scale
        let rect = buildTextRect(drawData: drawData, imageSize: image.size)
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ] as [NSAttributedString.Key : Any]
        
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        drawData.stringToWrite.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    fileprivate func buildFont(drawData: DrawOnImageData) -> UIFont {
        let fontSize = drawData.fontSize == defaultFontSize
            ? UIFont.systemFontSize
            : CGFloat(drawData.fontSize)
        return UIFont.systemFont(ofSize: fontSize)
    }
    
    fileprivate func buildTextRect(drawData: DrawOnImageData, imageSize: CGSize) -> CGRect {
        let xOrigin = drawData.leftPadding < Int(imageSize.width)
            ? drawData.leftPadding
            : 0
        let yOrigin = drawData.topPadding < Int(imageSize.height)
            ? drawData.topPadding
            : 0
        
        let horPadding = drawData.leftPadding + drawData.rightPadding
        let vertPadding = drawData.topPadding + drawData.bottomPadding
        
        let width = Int(imageSize.width) - horPadding > 0
            ? Int(imageSize.width) - horPadding
            : Int(imageSize.width)
        
        let height = Int(imageSize.height) - vertPadding > 0
            ? Int(imageSize.height) - vertPadding
            : Int(imageSize.height)
        
        return CGRect(x: xOrigin, y: yOrigin, width: width, height: height)
    }
}
