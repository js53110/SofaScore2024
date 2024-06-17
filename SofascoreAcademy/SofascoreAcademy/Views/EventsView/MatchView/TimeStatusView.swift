import Foundation
import SnapKit
import UIKit
import SofaAcademic

class TimeStatusView: BaseView {
    
    private let timeView = UILabel()
    private let statusView = UILabel()
    
    override func addViews() {
        addSubview(timeView)
        addSubview(statusView)
    }
    
    override func styleViews() {
        timeView.font = .micro
        timeView.textColor = .onSurfaceOnSurfaceLv2
        timeView.textAlignment = .center
        statusView.font = .micro
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
    
    func update(matchTime: TimeInterval, status: String, displayDate: Bool) {
        
        if(displayDate) {
            timeView.text = Helpers.convertTimestampToDate(timeStamp: matchTime)
            statusView.text = Helpers.convertTimestampToTime(timeStamp: matchTime)
        } else {
            timeView.text = Helpers.convertTimestampToTime(timeStamp: matchTime)
            statusView.text = Helpers.determineMatchStatusString(matchStatus: status)
        }
        
        switch status {
        case "inprogress":
            statusView.textColor = .red
        case "finished":
            statusView.text = "FT"
            statusView.textColor = .onSurfaceOnSurfaceLv2
        default:
            statusView.textColor = .onSurfaceOnSurfaceLv2
        }
    }
    
    func updateMatchStatus(status: String) {
        switch status {
        case "inprogress":
            statusView.textColor = .red
        default:
            statusView.textColor = .onSurfaceOnSurfaceLv2
        }
        statusView.text = Helpers.determineMatchStatusString(matchStatus: status)
    }
    
    func updateMatchTime(time: Int) {
        statusView.text = String(time) + "'"
    }
}
