//
//  LeagueNameView.swift
//  SofascoreAcademy
//
//  Created by Akademija on 12.03.2024..
//

import Foundation
import SnapKit
import UIKit

class TimeStatusStackView: UIStackView {
    
    let matchTime: String
    let matchStatus: String
    let fontColor: UIColor
    
    init(matchTime: TimeInterval, status: matchStatus) {
        self.matchTime = convertTimestampToTime(timeStamp: matchTime)
        self.matchStatus = determineMatchStatus(matchStatus: status)
        switch status {
        case .inProgress:
            self.fontColor = .red
        default:
            self.fontColor = lightGrey
        }
        super.init(frame: .zero)
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        axis = .vertical
        spacing = 4
        
        let timeView = UILabel()
        timeView.text = matchTime
        timeView.font = RobotoCondensedRegularMicro
        timeView.textColor = lightGrey
        timeView.textAlignment = .center
        
        addArrangedSubview(timeView)
                
        let statusView = UILabel()
        statusView.text = matchStatus
        statusView.font = RobotoCondensedRegularMicro
        statusView.textColor = fontColor
        statusView.textAlignment = .center
        addArrangedSubview(statusView)
        
        timeView.snp.makeConstraints() {
            $0.height.equalTo(16)
        }
        
        statusView.snp.makeConstraints() {
            $0.height.equalTo(16)
        }
    }
}
