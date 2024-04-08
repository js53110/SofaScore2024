//
//  MainViewController.swift
//  SofascoreAcademy
//
//  Created by Akademija on 08.04.2024..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class MainViewController : UINavigationController {
    
    let blueContainer = UIView()
    let appHeader = AppHeader()
    let containerView = UIView()
    let childVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(blueContainer)
        view.addSubview(appHeader)
        view.addSubview(containerView)
        
        addChild(childVC)
        containerView.addSubview(childVC.view)
        blueContainer.backgroundColor = colors.colorPrimaryDefault
        blueContainer.snp.makeConstraints() {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        appHeader.snp.makeConstraints() {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
       
        containerView.snp.makeConstraints() {
            $0.top.equalTo(appHeader.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        
    }
}
