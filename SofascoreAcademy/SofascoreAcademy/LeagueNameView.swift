//
//  LeagueNameView.swift
//  SofascoreAcademy
//
//  Created by Akademija on 12.03.2024..
//

import Foundation
import SnapKit
import UIKit
import SofaAcademic

class LeagueNameView: BaseView {

    let countryName: String
    let leagueName: String
    let leagueLogo: String
    let arrow: String = "pointer"
    let stackView: UIStackView
    
    private let countryNameLabel = UILabel()
    private let leagueNameLabel = UILabel()
    
    private let leagueLogoImageView = UIImageView()
    private let arrowImageView = UIImageView()

    init(countryName: String, leagueName: String, leagueLogo: String) {
        
        self.countryName = countryName
        self.leagueName = leagueName
        self.leagueLogo = leagueLogo
        
        self.stackView = UIStackView(arrangedSubviews: [countryNameLabel, arrowImageView, leagueNameLabel])

        super.init()
    }
    
    override func addViews() {
        
        addSubview(stackView)
        addSubview(leagueLogoImageView)
    }

    override func styleViews() {
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        countryNameLabel.text = countryName
        countryNameLabel.font = RobotoBold
        
        leagueNameLabel.text = leagueName
        leagueNameLabel.textColor = lightGrey
        leagueNameLabel.font = RobotoBold

        leagueLogoImageView.image = UIImage(named: leagueLogo)
        arrowImageView.image = UIImage(named: arrow)
    }

    override func setupConstraints() {
        
        snp.makeConstraints() {
            $0.height.equalTo(56)
        }
        
        arrowImageView.snp.makeConstraints(){
            $0.height.width.equalTo(24)
        }
        
        leagueLogoImageView.snp.makeConstraints {
            $0.width.height.equalTo(32) // Set size to 32x32 points
            $0.leading.equalToSuperview().offset(16) // 16 points from the left edge of superview
            $0.centerY.equalToSuperview() // Center vertically in superview
        }
        
        stackView.snp.makeConstraints(){
            $0.leading.equalToSuperview().offset(80)
            $0.centerY.equalToSuperview() // Center vertically in superview
        } 
    }
}