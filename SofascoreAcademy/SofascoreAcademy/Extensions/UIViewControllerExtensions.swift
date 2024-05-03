import UIKit

extension UIViewController {
    
    func customAddChild(child: UIViewController, parent: UIView, animation: CATransition?) {
        if let animation = animation {
            child.view.layer.add(animation, forKey: "viewControllerTransition")
        }
        
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