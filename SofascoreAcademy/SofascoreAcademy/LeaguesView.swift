//
//  LeagueView.swift
//  SofascoreAcademy
//
//  Created by Akademija on 12.03.2024..
//

import Foundation
import UIKit
import SofaAcademic

class LeaguesView: BaseView {
        
    private let tableView = UITableView()
    
    override init() {
        super.init()
        
        tableView.register(MatchViewCell.self, forCellReuseIdentifier: MatchViewCell.identifier)
        tableView.register(LeagueInfoViewHeader.self, forHeaderFooterViewReuseIdentifier: LeagueInfoViewHeader.identifier)
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
    
    func update(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
    
    override func addViews() {
        addSubview(tableView)
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension LeaguesView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        leaguesData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leaguesData[section].matches.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: MatchViewCell.identifier,
            for: indexPath) as? MatchViewCell {
                let dataForRow = leaguesData[indexPath.section].matches[indexPath.row]
                cell.update(data: dataForRow)
                return cell
        } else {
            fatalError("Failed to equeue cell")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: LeagueInfoViewHeader.identifier) as? LeagueInfoViewHeader {
                let sectionData = leaguesData[section]
                headerView.update(
                    countryName: sectionData.countryName,
                    leagueName: sectionData.leagueName,
                    leagueLogo: sectionData.leagueLogo)
                return headerView
        } else {
            fatalError("Failed to dequeue header")
        }
    }
}

extension LeaguesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
}


