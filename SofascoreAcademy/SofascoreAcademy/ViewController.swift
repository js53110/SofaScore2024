import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController, BaseViewProtocol {
    
    private let leaguesView = LeaguesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leaguesView.update()
                
        addViews()
        styleViews()
        setupConstraints()
        setupGestureRecognizers()
    }
    
    func addViews() {
        view.addSubview(leaguesView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        leaguesView.snp.makeConstraints() {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupGestureRecognizers() {
    }
}
