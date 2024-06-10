import Foundation
import UIKit
import SofaAcademic

class DatesMatchesDividerView: BaseView {
    
    private let dayLabel = UILabel()
    private let eventsCountLabel = UILabel()
    
    override func addViews() {
        addSubview(dayLabel)
        addSubview(eventsCountLabel)
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
        
        eventsCountLabel.snp.makeConstraints() {
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(200)
            $0.top.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    override func styleViews() {
        backgroundColor = .surfaceSurface0
        dayLabel.font = .assistive
        dayLabel.textAlignment = .left
        dayLabel.textColor = .black
        eventsCountLabel.textAlignment = .right
        eventsCountLabel.font = .assistive
        eventsCountLabel.textColor = .onSurfaceOnSurfaceLv2
        dayLabel.textColor = .black
    }
}

//MARK: Additional methods
extension DatesMatchesDividerView {
    
    func updateInfo(count: Int, date: String) {
        dayLabel.text = date
        eventsCountLabel.text = "\(count) Events"
    }
}
