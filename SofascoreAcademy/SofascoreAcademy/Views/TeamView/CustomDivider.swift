import Foundation
import SnapKit
import UIKit
import SofaAcademic

class CustomDivider: BaseView {
    
    override init() {
        super.init()
    }
    
    override func styleViews() {
        self.backgroundColor = .onSurfaceOnSurfaceLv4
    }
    
    override func setupConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }
}
