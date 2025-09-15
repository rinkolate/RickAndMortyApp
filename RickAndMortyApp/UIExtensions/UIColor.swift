import UIKit

extension UIColor {
    static let rickDarkBlue = UIColor(red: 4/255, green: 12/255, blue: 30/255, alpha: 1.0)
    static let rickCellBackground = UIColor(red: 38/255, green: 42/255, blue: 56/255, alpha: 1.0)
    static let rickGreen = UIColor(red: 71/255, green: 198/255, blue: 11/255, alpha: 1.0)
    static let rickLightGray = UIColor(red: 147/255, green: 152/255, blue: 156/255, alpha: 1.0)
    static let rickWhite = UIColor.white
}

extension UIFont {
    static func gilroySemiBold(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
}
