import Foundation
import UIKit
import SnapKit
import SofaAcademic

class PlayerDetailCardView: BaseView {
    
    private let cardContainer = UIView()
    
    private let cardTitleLabel = UILabel()
    private let dataLabel = UILabel()
    
    override func addViews() {
        addSubview(cardContainer)
        cardContainer.addSubview(cardTitleLabel)
        cardContainer.addSubview(dataLabel)
    }
    
    override func styleViews() {
        cardContainer.backgroundColor = .colorSecondaryHighlight
        cardContainer.layer.cornerRadius = 4
        
        cardTitleLabel.textColor = .onSurfaceOnSurfaceLv2
        cardTitleLabel.font = .assistive
        cardTitleLabel.textAlignment = .center
        dataLabel.font = .headline3
        dataLabel.textColor = .onSurfaceOnSurfaceLv1
        dataLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        cardContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        cardTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(32)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
        
        dataLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(31)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
    }
    
    func update(cardTitle: String, data: String) {
        cardTitleLabel.text = cardTitle
        dataLabel.text = data
    }
}
