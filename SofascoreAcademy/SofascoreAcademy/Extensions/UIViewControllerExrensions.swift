import Foundation
import UIKit

extension UIViewController {
    
    func addChild(child: UIViewController, parent: UIView) {
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
