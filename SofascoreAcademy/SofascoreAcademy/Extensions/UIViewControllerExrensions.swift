import Foundation
import UIKit

extension UIViewController {
    
    func customAddChild(child: UIViewController, parent: UIView) {
        let animation: CATransition = CATransition()
        animation.duration = 0.3
        animation.type = .push
        animation.subtype = .fromRight
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        child.view.layer.add(animation, forKey: "viewControllerTransition")
        
        addChild(child)
        parent.addSubview(child.view)
        child.view.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
