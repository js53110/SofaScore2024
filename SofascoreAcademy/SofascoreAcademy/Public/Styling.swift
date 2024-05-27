import Foundation
import UIKit

public enum Fonts {
    static let RobotoBold = UIFont(name: "Roboto-Bold", size: 14)
    static let RobotoRegular14 = UIFont(name: "Roboto-Regular", size: 14)
    static let RobotoRegular12 = UIFont(name: "Roboto-Regular", size: 12)
    static let RobotoCondensedRegularMicro = UIFont(name: "RobotoCondensed-Regular", size: 12)
}

public enum Colors {
    static let surfaceLv2 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    static let surface0 = UIColor(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)
    static let red = UIColor.red
    static let surfaceLv4 = UIColor(white: 18.0 / 255.0, alpha: 0.1)
    static let colorPrimaryDefault = UIColor(red: 55.0/255.0, green: 77.0/255.0, blue: 245.0/255.0, alpha: 1.0)
    static let colorPrimaryVariant = UIColor(red: 19.0 / 255.0, green: 39.0 / 255.0, blue: 186.0 / 255.0, alpha: 1.0)
}

//ovo sam kopirao sa zeplina, ali mi neki fontovi ne rade pa sam ostavio i ovo i moj Enum gore :/
extension UIFont {
  class var headline1Desktop: UIFont {
    return UIFont(name: "Roboto-Bold", size: 32.0)!
  }
  class var headline1: UIFont {
    return UIFont(name: "Roboto-Bold", size: 20.0)!
  }
  class var headline2: UIFont {
    return UIFont(name: "Roboto-Bold", size: 16.0)!
  }
  class var action: UIFont {
    return UIFont(name: "Roboto-Bold", size: 16.0)!
  }
  class var headline3: UIFont {
    return UIFont(name: "Roboto-Bold", size: 14.0)!
  }
  class var tabular: UIFont {
    return UIFont(name: "Roboto-CondensedRegular", size: 14.0)!
  }
  class var bodyParagraph: UIFont {
    return UIFont(name: "Roboto-Regular", size: 14.0)!
  }
  class var body: UIFont {
    return UIFont(name: "Roboto-Regular", size: 14.0)!
  }
  class var assistive: UIFont {
    return UIFont(name: "Roboto-Bold", size: 12.0)!
  }
  class var micro: UIFont {
    return UIFont(name: "Roboto-CondensedRegular", size: 12.0)!
  }
}



