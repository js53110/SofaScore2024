import Foundation
import UIKit
import SnapKit
import SofaAcademic

class PlayerHeaderView: BaseView {
    
    private let backButtonContainer = UIView()
    private let backButtonImage = UIImageView()
    private let playerNameLabel = UILabel()
        
    private let playerImageView = UIImageView()
    private let playerImageContainer = UIView()
    
    weak var eventDelegate: ReturnButtonDelegate?
    
    override func addViews() {
        addSubview(backButtonContainer)
        addSubview(playerImageContainer)
        addSubview(playerNameLabel)
        playerImageContainer.addSubview(playerImageView)
        backButtonContainer.addSubview(backButtonImage)
    }
    
    override func styleViews() {
        backgroundColor = .colorPrimaryDefault
        
        backButtonImage.image = UIImage(named: "back_icon_white")
        backButtonImage.contentMode = .scaleAspectFit
      
        playerImageContainer.backgroundColor = .onColorOnColorPrimary
        playerImageContainer.layer.cornerRadius = 8
        
        playerNameLabel.textColor = .white
        playerNameLabel.font = .headline1
        
        playerImageView.contentMode = .scaleAspectFit
    }
    
    override func setupConstraints() {
        backButtonContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(4)
            $0.size.equalTo(48)
        }
        
        playerImageContainer.snp.makeConstraints {
            $0.size.equalTo(56)
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(48)
        }
        
        playerImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.edges.equalToSuperview().inset(8)
        }
        
        playerNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(62)
            $0.bottom.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(88)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        backButtonImage.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
    }
    
    override func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        backButtonContainer.addGestureRecognizer(tapGesture)
    }
}

//MARK: Class methods
extension PlayerHeaderView {
    
    @objc func backButtonTapped() {
        eventDelegate?.reactToReturnTap()
    }
    
    func update(player: Player) {
        updatePlayerImage(playerId: player.id)
        playerNameLabel.text = player.name
    }
    
    private func updatePlayerImage(playerId: Int) {
        Task {
            do {
                playerImageView.image = await ImageService().getPlayerImage(playerId: playerId)
            }
        }
    }
}


