import Foundation
import SnapKit
import UIKit
import SofaAcademic


class PeriodView: UIView {
    
    private var incidentId: Int?
    private var homeScore: Score?
    private var awayScore: Score?
    private var time: Int?
    
    private let statusLabel = UILabel()
}

// MARK: Additional methods
extension PeriodView: IncidentViewProtocol {
    
    func update(data: EventIncident, matchData: Event) {
        incidentId = data.id
        time = data.time
        homeScore = matchData.homeScore
        awayScore = matchData.awayScore
        
        addViews()
        styleViews()
        setupConstraints()
    }
}

// MARK: BaseViewProtocol
extension PeriodView: BaseViewProtocol {
    
    func addViews() {
        addSubview(statusLabel)
    }
    
    func styleViews() {
        backgroundColor = .white
        statusLabel.backgroundColor = .colorSecondaryHighlight
        statusLabel.layer.cornerRadius = 15
        statusLabel.layer.masksToBounds = true
        if(time ?? 0 >= 90) {
            statusLabel.text = "FT (\(homeScore?.total ?? 0) - \(awayScore?.total ?? 0))"
        } else {
            statusLabel.text = "HT (\(homeScore?.period1 ?? 0) - \(awayScore?.period1 ?? 0))"
        }
        statusLabel.textAlignment = .center
        statusLabel.font = .assistive
        statusLabel.textColor = .onSurfaceOnSurfaceLv1
    }
    
    func setupConstraints() {
        snp.makeConstraints() {
            $0.height.equalTo(40)
        }
        
        statusLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }
}
