import UIKit

public enum Animations {
    
    static func pushFromRight() -> CATransition {
        let animation: CATransition = CATransition()
        animation.duration = 0.3
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromRight
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        return animation
    }
}
