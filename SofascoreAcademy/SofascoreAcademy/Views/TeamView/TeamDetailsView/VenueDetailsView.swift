import Foundation
import UIKit
import SnapKit
import SofaAcademic

class VenueDetailsView: BaseView {
    
    private let venueDetailLabel = UILabel()
    private let venueNameLabel = UILabel()
    private let divider = CustomDivider()
    
    override init() {
        super.init()
    }
    
    override func addViews() {
        addSubview(venueDetailLabel)
        addSubview(venueNameLabel)
        addSubview(divider)
    }
    
    override func styleViews() {
        venueDetailLabel.textColor = .onSurfaceOnSurfaceLv1
        venueDetailLabel.font = .body
        venueDetailLabel.textAlignment = .left
        
        venueNameLabel.textColor = .onSurfaceOnSurfaceLv1
        venueNameLabel.font = .body
        venueNameLabel.textAlignment = .right
    }
    
    override func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(39)
        }
        
        venueDetailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(184)
        }
        
        venueNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.equalTo(venueDetailLabel.snp.trailing)
        }
        
        divider.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//MARK: Additional methods
extension VenueDetailsView {
    
    func update(venueDesc: String, venueName: String) {
        venueDetailLabel.text = venueDesc
        venueNameLabel.text = venueName
    }
}
