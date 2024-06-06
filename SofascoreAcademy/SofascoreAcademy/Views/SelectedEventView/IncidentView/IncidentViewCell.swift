import Foundation
import UIKit
import SofaAcademic
import SnapKit


class IncidentViewCell: UITableViewCell {
    
    static let identifier = "IncidentViewCell"
    
    private var incidentView: (UIView & IncidentViewProtocol)?
    private var incidentId: Int = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Additional methods
extension IncidentViewCell {
    
    func setupCell(data: FootballIncident, matchData: Event) {
        
        if(data.type == "card") {
            incidentView = IncidentCardView()
            
        } else if(data.type == "goal") {
            incidentView = IncidentGoalView()
            
        } else {
            incidentView = PeriodView()
        }
        
        addViews()
        styleViews()
        setupConstraints()
        
        incidentId = data.id
        guard let incidentView = incidentView else { return }
        incidentView.update(data: data, matchData: matchData)
    }
}

//MARK: BaseViewProtocol
extension IncidentViewCell: BaseViewProtocol {
    
    func addViews() {
        guard let incidentView = incidentView else { return }
        contentView.addSubview(incidentView)
    }
    
    func setupConstraints() {
        guard let incidentView = incidentView else { return }
        incidentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func styleViews() {
        backgroundColor = .white
    }
}


