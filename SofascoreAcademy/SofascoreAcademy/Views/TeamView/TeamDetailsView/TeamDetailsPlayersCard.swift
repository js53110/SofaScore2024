import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TeamDetailsPlayersCard: BaseView {
    
    private let imageView = UIImageView()
    private let playersCountLabel = UILabel()
    private let cardDescriptionLabel = UILabel()
    
    override init() {
        super.init()
    }
    
    override func addViews() {
        addSubview(imageView)
        addSubview(playersCountLabel)
        addSubview(cardDescriptionLabel)
    }
    
    override func styleViews() {
        imageView.contentMode = .scaleAspectFit
        
        playersCountLabel.textColor = .colorPrimaryDefault
        playersCountLabel.font = .headline3
        playersCountLabel.textAlignment = .center
        
        cardDescriptionLabel.textColor = .onSurfaceOnSurfaceLv2
        cardDescriptionLabel.font = .micro
        cardDescriptionLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
    
        imageView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.top.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
        }
        
        playersCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(56)
            $0.bottom.equalToSuperview().inset(44)
            $0.leading.trailing.equalToSuperview().inset(70)
        }
        
        cardDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(76)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
    }
}

//MARK: Additional methods
extension TeamDetailsPlayersCard {
    
    func update(image: UIImage, playersCount: Int, descriptionText: String) {
        imageView.image = image
        playersCountLabel.text = "\(playersCount)"
        cardDescriptionLabel.text = descriptionText
    }
}
