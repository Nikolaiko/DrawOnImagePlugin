extension UIColor {
    static func fromInt(argbValue: Int) -> UIColor {        
        let alpha = CGFloat((argbValue & 0xFF000000) >> 24) / 0xFF
        let red =   CGFloat((argbValue & 0x00FF0000) >> 16) / 0xFF
        let green = CGFloat((argbValue & 0x0000FF00) >> 8) / 0xFF
        let blue =  CGFloat(argbValue & 0x000000FF) / 0xFF
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
