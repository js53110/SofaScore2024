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
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().inset(8)
        }
        
        eventsCountLabel.snp.makeConstraints() {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    override func styleViews() {
        backgroundColor = Colors.surface0
        dayLabel.font = UIFont.assistive
        eventsCountLabel.font = UIFont.assistive
        eventsCountLabel.textColor = Colors.surfaceLv2
        dayLabel.textColor = .black
    }
}

extension DatesMatchesDividerView {
    
    func updateInfo(count: Int, date: String) {
        dayLabel.text = date
        eventsCountLabel.text = "\(count) Events"
    }
}
