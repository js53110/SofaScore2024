import Foundation
import UIKit
import SnapKit
import SofaAcademic

class PlayerDetailsView: UIStackView {
    
    private let nationalityView = PlayerDetailCardView()
    private let positionView = PlayerDetailCardView()
    private let ageView = PlayerDetailCardView()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addViews()
        styleViews()
        setupConstraints()
    }
    
    private func addViews() {
        addArrangedSubview(nationalityView)
        addArrangedSubview(positionView)
        addArrangedSubview(ageView)
    }
    
    private func styleViews() {
        self.axis = .horizontal
        self.distribution = .fillEqually

    }
    
    private func setupConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(64)
        }
        
        nationalityView.snp.makeConstraints {
            $0.height.equalToSuperview()
        }
        
        positionView.snp.makeConstraints {
            $0.height.equalToSuperview()
        }
        
        ageView.snp.makeConstraints {
            $0.height.equalToSuperview()
        }
    }
    
    func update(player: Player) {
        nationalityView.update(cardTitle: "Nationality", data: player.country.name)
        positionView.update(cardTitle: "Position", data: player.position)
        ageView.update(cardTitle: "Age", data: "20")
    }
}
