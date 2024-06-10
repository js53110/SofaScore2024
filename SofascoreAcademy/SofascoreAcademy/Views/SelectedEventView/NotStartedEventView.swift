import Foundation
import UIKit
import SofaAcademic
import SnapKit

class NotStartedEventView: BaseView {
    
    private let textContainer = UIView()
    private let textLabel = UILabel()
    private let tournamentDetailsBox = UIView()
    private let tournamentDetailsText = UILabel()
    
    weak var delegate: LeagueTapDelegate?
    
    override func addViews() {
        addSubview(textContainer)
        textContainer.addSubview(textLabel)
        addSubview(tournamentDetailsBox)
        tournamentDetailsBox.addSubview(tournamentDetailsText)
    }
    
    override func styleViews() {
        backgroundColor = .white
        textContainer.backgroundColor = .surfaceSurface2
        textContainer.layer.cornerRadius = 10.0 
        textContainer.layer.masksToBounds = true
        
        textLabel.text = "No results yet."
        textLabel.font = .bodyParagraph
        textLabel.textColor = .onSurfaceOnSurfaceLv2
        textLabel.textAlignment = .center
        
        tournamentDetailsBox.layer.borderColor = UIColor.colorPrimaryDefault.cgColor
        tournamentDetailsBox.layer.borderWidth = 2.0
        
        tournamentDetailsText.text = "View Tournament Details"
        tournamentDetailsText.font = .headline2
        tournamentDetailsText.textColor = .colorPrimaryDefault
        tournamentDetailsText.textAlignment = .center
    }
    
    override func setupConstraints() {
        textContainer.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.trailing.top.equalToSuperview().inset(8)
        }
        
        textLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(42)
            $0.height.equalTo(20)
            $0.centerY.equalToSuperview()
        }
        
        tournamentDetailsBox.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(32)
            $0.top.equalTo(textContainer.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(74)
        }
        
        tournamentDetailsText.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    override func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tournamentButtonTapped))
        tournamentDetailsBox.addGestureRecognizer(tapGesture)
    }
}

//MARK: Gesture methods
extension NotStartedEventView {
    
    @objc func tournamentButtonTapped() {
        delegate?.reactToLeagueHeaderTap(tournamentId: 0)
    }
}
