import Foundation
import SnapKit
import UIKit
import SofaAcademic

class ScoreLabel: BaseView {
    
    private var textColor: UIColor = .black
    private var scoreLabel = UILabel()
    
    func update(matchId: Int, status: String, score: Int?, color: UIColor) {
        if let score = score {
            scoreLabel.text = String(score)
            scoreLabel.textColor = color
        }
    }
    
    override func addViews() {
        addSubview(scoreLabel)
    }
    
    override func styleViews() {
        scoreLabel.textColor = textColor
        scoreLabel.textAlignment = .right
        scoreLabel.font = .bodyParagraph
        scoreLabel.contentMode = .center
    }
    
    override func setupConstraints() {
        snp.makeConstraints() { 
            $0.width.equalTo(32)
            $0.height.equalTo(16)
        }
        
        scoreLabel.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: Additional methods
extension ScoreLabel {
    
    func updateScore(score: Int) {
        scoreLabel.text = String(score)
    }
}
