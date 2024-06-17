import Foundation
import UIKit
import SnapKit
import SofaAcademic

class LeaguesHeaderView: BaseView {
    
    private let backButtonContainer = UIView()
    private let backButtonImage = UIImageView()
    private let title = UILabel()
    
    weak var eventDelegate: ReturnButtonDelegate?
    
    override func addViews() {
        addSubview(backButtonContainer)
        backButtonContainer.addSubview(backButtonImage)
        addSubview(title)
    }
    
    override func styleViews() {
        title.textColor = .white
        title.text = "Leagues"
        title.font = .headline1
        title.textAlignment = .left
        
        backButtonImage.image = UIImage(named: "back_icon_white")
        backButtonImage.contentMode = .scaleAspectFit
    }
    
    override func setupConstraints() {
        backButtonContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(4)
            $0.size.equalTo(48)
        }
        
        backButtonImage.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
        
        title.snp.makeConstraints {
            $0.leading.equalTo(backButtonContainer.snp.trailing).offset(20)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    override func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        backButtonContainer.addGestureRecognizer(tapGesture)
    }
}

//MARK: Gesture methods
extension LeaguesHeaderView {
    
    @objc func backButtonTapped() {
        eventDelegate?.reactToReturnTap()
    }
}
