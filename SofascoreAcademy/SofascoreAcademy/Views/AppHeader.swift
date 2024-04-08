//
//  AppHeader.swift
//  SofascoreAcademy
//
//  Created by Akademija on 08.04.2024..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class AppHeader : BaseView {
    
    private let logoPath = "sofascore_lockup"
    private let headerButtonIcon1Path = "Icon 1"
    private let headerButtonIcon2Path = "Icon 2"
    
    let appLogo = UIImageView()
    let headerButton1 = UIButton()
    let headerButton2 = UIButton()
    let headerButtonIcon1 = UIImageView()
    let headerButtonIcon2 = UIImageView()
    
    override func addViews() {
        addSubview(appLogo)
        addSubview(headerButton1)
        addSubview(headerButton2)
        headerButton1.addSubview(headerButtonIcon1)
        headerButton2.addSubview(headerButtonIcon2)
    }
    
    override func styleViews() {
        appLogo.image = UIImage(named: logoPath)
        appLogo.contentMode = .scaleAspectFit
        backgroundColor = colors.colorPrimaryDefault
        headerButtonIcon1.image = UIImage(named: headerButtonIcon1Path)
        headerButtonIcon2.image = UIImage(named: headerButtonIcon2Path)

    }
    
    override func setupConstraints() {
        snp.makeConstraints(){
            $0.height.equalTo(48)
        }
        
        appLogo.snp.makeConstraints() {
            $0.height.equalTo(20)
            $0.width.equalTo(132)
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(16)
        }
        
        headerButton1.snp.makeConstraints() {
            $0.size.equalTo(48)
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(4)
        }
        
        headerButton2.snp.makeConstraints() {
            $0.size.equalTo(48)
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(52)
        }
        
        headerButtonIcon1.snp.makeConstraints() {
            $0.size.equalTo(24)
            $0.top.edges.equalToSuperview().inset(12)
        }
        
        headerButtonIcon2.snp.makeConstraints() {
            $0.size.equalTo(24)
            $0.top.edges.equalToSuperview().inset(12)
        }

    }
}

