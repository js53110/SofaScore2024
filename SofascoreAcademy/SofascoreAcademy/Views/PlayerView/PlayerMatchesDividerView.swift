import Foundation
import UIKit
import SofaAcademic

class PlayerMatchesDividerView: BaseView {
    
    private let dayLabel = UILabel()
    
    override func addViews() {
        addSubview(dayLabel)
    }
    
    override func setupConstraints() {
        snp.makeConstraints() {
            $0.height.equalTo(48)
        }
        
        dayLabel.snp.makeConstraints() {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(200)
            $0.top.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    override func styleViews() {
        backgroundColor = .surfaceSurface0
        dayLabel.font = .assistive
        dayLabel.textAlignment = .left
        dayLabel.textColor = .black
        dayLabel.text = "Matches"
    }
}

