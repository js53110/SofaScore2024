import UIKit

class CustomScrollView: UIScrollView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureScrollView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureScrollView()
    }
    
    override var contentOffset: CGPoint {
        get {
            return super.contentOffset
        }
        set {
            if newValue.y > 0 {
                super.contentOffset.y = 0
            } else {
                super.contentOffset = newValue
            }
        }
    }
}

//MARK: Private Methods
private extension CustomScrollView {
    
    func configureScrollView() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
}
