import Foundation
import UIKit
import SnapKit

class RoundMatchesHeaderView: UITableViewHeaderFooterView {
    
    private let roundLabel = UILabel()
    private let eventsCountLabel = UILabel()
    
    static let identifier = "roundHeader"

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Private methods
extension RoundMatchesHeaderView {
    
    private func setupViews() {
        addViews()
        styleViews()
        setupConstraints()
    }
    
    private func addViews() {
        contentView.addSubview(roundLabel)
        contentView.addSubview(eventsCountLabel)
    }
    
    private func styleViews() {
        contentView.backgroundColor = .surfaceSurface0
        roundLabel.font = .assistive
        roundLabel.textAlignment = .left
        roundLabel.textColor = .onSurfaceOnSurfaceLv1
        
        eventsCountLabel.textAlignment = .right
        eventsCountLabel.font = .assistive
        eventsCountLabel.textColor = .onSurfaceOnSurfaceLv2
    }
    
    private func setupConstraints() {
        roundLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(200)
            $0.top.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(8)
        }
        
        eventsCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(200)
            $0.top.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}

//MARK: Additional method
extension RoundMatchesHeaderView {
    
    func update(count: Int, date: String) {
        roundLabel.text = date
        eventsCountLabel.text = "\(count) Events"
    }
}
