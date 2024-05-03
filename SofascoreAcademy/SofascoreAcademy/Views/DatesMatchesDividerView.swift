import Foundation
import UIKit
import SofaAcademic

class DatesMatchesDividerView: BaseView {
    
    override func setupConstraints() {
        snp.makeConstraints() {
            $0.height.equalTo(48)
        }
    }
    
    override func styleViews() {
        backgroundColor = colors.surface0
    }
}
