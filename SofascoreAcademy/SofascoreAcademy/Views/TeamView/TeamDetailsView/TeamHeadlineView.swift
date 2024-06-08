import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TeamHeadlineView: BaseView {
    
    private let title: String
    private let headlineLabel = UILabel()
    
    init(title: String) {
        self.title = title
        super.init()
    }
    
    override func addViews() {
        addSubview(headlineLabel)
    }
    
    override func styleViews() {
        headlineLabel.text = title
        headlineLabel.textAlignment = .center
        headlineLabel.font = .headline2
    }
    
    override func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        headlineLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(32)
        }
    }
}
