import Foundation
import SnapKit
import UIKit
import SofaAcademic

class TimeStatusView: BaseView {
        
    private let timeView = UILabel()
    private let statusView = UILabel()
    
    func update(matchTime: TimeInterval, status: matchStatus) {
        timeView.text = helpers.convertTimestampToTime(timeStamp: matchTime)
        statusView.text = helpers.determineMatchStatusString(matchStatus: status)
        
        switch status {
        case .inProgress:
            statusView.textColor = .red
        default:
            statusView.textColor = colors.surfaceLv2
        }
    }
    
    override func addViews() {
        addSubview(timeView)
        addSubview(statusView)
    }

    override func styleViews() {
        timeView.font = fonts.RobotoCondensedRegularMicro
        timeView.textColor = colors.surfaceLv2
        timeView.textAlignment = .center
        statusView.font = fonts.RobotoCondensedRegularMicro
        statusView.textAlignment = .center
    }

    override func setupConstraints() {
        timeView.snp.makeConstraints() {
            $0.height.equalTo(16)
            $0.top.leading.trailing.equalToSuperview()
        }
        
        statusView.snp.makeConstraints() {
            $0.height.equalTo(16)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension TimeStatusView {
    
    func updateMatchStatus(status: matchStatus) {
        switch status {
        case .inProgress:
            statusView.textColor = .red
        default:
            statusView.textColor = colors.surfaceLv2
        }
        statusView.text = helpers.determineMatchStatusString(matchStatus: status)
    }
    
    func updateMatchTime(time: Int) {
        statusView.text = String(time) + "'"
    }
}
