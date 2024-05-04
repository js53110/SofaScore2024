import Foundation
import SnapKit
import UIKit
import SofaAcademic

class TimeStatusView: BaseView {
        
    private let timeView = UILabel()
    private let statusView = UILabel()
    
    func update(matchTime: TimeInterval, status: String) {
        timeView.text = Helpers.convertTimestampToTime(timeStamp: matchTime)
        statusView.text = Helpers.determineMatchStatusString(matchStatus: status)
        
        switch status {
//        case .inProgress:
//            statusView.textColor = .red
        default:
            statusView.textColor = Colors.surfaceLv2
        }
    }
    
    override func addViews() {
        addSubview(timeView)
        addSubview(statusView)
    }

    override func styleViews() {
        timeView.font = Fonts.RobotoCondensedRegularMicro
        timeView.textColor = Colors.surfaceLv2
        timeView.textAlignment = .center
        statusView.font = Fonts.RobotoCondensedRegularMicro
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

// MARK: Additional methods
extension TimeStatusView {
    
    func updateMatchStatus(status: String) {
        switch status {
//        case .inProgress:
//            statusView.textColor = .red
        default:
            statusView.textColor = Colors.surfaceLv2
        }
        statusView.text = Helpers.determineMatchStatusString(matchStatus: status)
    }
    
    func updateMatchTime(time: Int) {
        statusView.text = String(time) + "'"
    }
}
