import Foundation
import UIKit

extension UIView {
    
    func changeBackgroundColorWithFade(to color: UIColor) {
        UIView.animate(withDuration: 1.5) {
            self.backgroundColor = color
        }
    }
}
