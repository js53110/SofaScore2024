import UIKit
import SnapKit
class MatchViewCell: UITableViewCell {
    
    static let identifier = "MatchViewCell"
        
    private let matchView = MatchView()
    private var matchId: Int = 0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(data: matchData) {
        matchId = data.matchId
        matchView.update(data: data)
    }
    
    func addViews() {
        contentView.addSubview(matchView)
    }

    func setupConstraints() {
        matchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MatchViewCell {
    
    func updateScore(score: Int, side: teamSide){
        matchView.updateScore(score: score, side: side)
    }
}
