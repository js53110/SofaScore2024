import Foundation
import UIKit
import SnapKit
import SofaAcademic

class SettingsAboutView: BaseView {
    
    private let title = UILabel()
    private let details = UIView()
    private let detailsTitle = UILabel()
    private let detailsDescription = UILabel()
    
    private let divider1 = UIView()
    private let divider2 = UIView()
    private let divider3 = UIView()
    
    private let creditStackView = UIStackView()
        
    override func addViews() {
        addSubview(divider1)
        addSubview(title)
        addSubview(details)
        details.addSubview(detailsTitle)
        details.addSubview(detailsDescription)
        addSubview(creditStackView)
        creditStackView.addArrangedSubview(divider2)
        creditStackView.addArrangedSubview(CreditsLabelView(upperText: "App Name", lowerText: "Mini Sofascore App"))
        creditStackView.addArrangedSubview(CreditsLabelView(upperText: "Api Credit", lowerText: "Sofascore"))
        creditStackView.addArrangedSubview(CreditsLabelView(upperText: "Developer", lowerText: "Jakov Sikiric"))
        creditStackView.addArrangedSubview(divider3)
    }
    
    override func styleViews() {
        title.text = "About"
        title.font = Fonts.RobotoBold20
        title.textColor = .black
        title.textAlignment = .left
   
        detailsTitle.text = "Sofascore Academy"
        detailsTitle.font = Fonts.RobotoBold16
        detailsTitle.textColor = .black
        detailsTitle.textAlignment = .left
        
        detailsDescription.text = "Class 2024"
        detailsDescription.font = Fonts.RobotoRegular14
        detailsDescription.textColor = .black
        detailsDescription.textAlignment = .left
        
        creditStackView.axis = .vertical
        creditStackView.alignment = .fill
        creditStackView.spacing = 16
        creditStackView.translatesAutoresizingMaskIntoConstraints = false
        
        divider1.backgroundColor = .onSurfaceOnSurfaceLv4
        divider2.backgroundColor = .onSurfaceOnSurfaceLv4
        divider3.backgroundColor = .onSurfaceOnSurfaceLv4
    }
    
    override func setupConstraints() {
        title.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(28)
        }

        details.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(42)
        }
        
        detailsTitle.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        detailsDescription.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        divider1.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        divider2.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        divider3.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        creditStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(details.snp.bottom).offset(16)
        }
    }
}
