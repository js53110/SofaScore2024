import Foundation
import UIKit
import SnapKit
import SofaAcademic

class CreditsLabelView: BaseView {
    
    private let upperLabel = UILabel()
    private let lowerLabel = UILabel()
    
    init(upperText: String, lowerText: String) {
        upperLabel.text = upperText
        lowerLabel.text = lowerText
        super.init()
    }
    
    override func addViews() {
        addSubview(upperLabel)
        addSubview(lowerLabel)
        
    }
    
    override func styleViews() {
        upperLabel.font = .assistive
        upperLabel.textColor = .onSurfaceOnSurfaceLv2
        upperLabel.textAlignment = .left
        
        lowerLabel.font = .headline3
        lowerLabel.textColor = .black
        lowerLabel.textAlignment = .left
    }
    
    override func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(38)
        }
        
        upperLabel.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.top.leading.trailing.equalToSuperview()
        }
        
        lowerLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}
