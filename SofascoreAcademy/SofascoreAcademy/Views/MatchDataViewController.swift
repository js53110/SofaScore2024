import Foundation
import UIKit
import SnapKit
import SofaAcademic

class MatchDataViewController: UIViewController {
    
    private let blueContainer = UIView()
    private let matchData: Event
    
    init(matchData: Event){
        self.matchData = matchData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
}

extension MatchDataViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(blueContainer)
    }
    
    func styleViews() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "\(matchData.homeTeam) vs \(matchData.awayTeam)"
        navigationItem.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .white
        blueContainer.backgroundColor = Colors.colorPrimaryDefault
    }
    
    func setupConstraints() {
        blueContainer.snp.makeConstraints() {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}


