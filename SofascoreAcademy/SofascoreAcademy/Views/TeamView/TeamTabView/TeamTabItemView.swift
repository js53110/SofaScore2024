import Foundation
import UIKit
import SofaAcademic
import SnapKit

class TeamTabItemView: BaseView {
        
    let title: String
    private let tabLabel = UILabel()
    
    init(title : String) {
        self.title = title
        super.init()
    }
    
    override func addViews() {
        addSubview(tabLabel)
    }
    
    override func styleViews() {
        tabLabel.text = title
        tabLabel.textColor = .white
        tabLabel.textAlignment = .center
        tabLabel.font = .body
    }
    
    override func setupConstraints() {
        tabLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
    }
}
