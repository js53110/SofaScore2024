import Foundation
import UIKit
import SnapKit
import SofaAcademic

class DateViewCell: UICollectionViewCell {
    
    static let identifier = "DateCell"
    
    private let cellView = UIView()
    private let dayLabel = UILabel()
    private let dateLabel = UILabel()
    private let selectedIndicator = UIView()
    
    private var dayOfWeek: String?
    private var dateString: String?
    var fullDate: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        styleViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Additional Methods
extension DateViewCell {
    
    func setSelected(_ selected: Bool) {
        selectedIndicator.isHidden = !selected
    }
    
    func update(data: DateData) {
        dayLabel.text = data.dayOfWeek
        dateLabel.text = data.dateString
        fullDate = data.fullDate
    }
}

//MARK: BaseView Methods
extension DateViewCell: BaseViewProtocol {
    
    func addViews() {
        addSubview(cellView)
        cellView.addSubview(dayLabel)
        cellView.addSubview(dateLabel)
        cellView.addSubview(selectedIndicator)
    }
    
    func styleViews() {
        dayLabel.text = dayOfWeek
        dayLabel.font = Fonts.RobotoCondensedRegularMicro
        dayLabel.textColor = .white
        dayLabel.textAlignment = .center
        
        dateLabel.text = dateString
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center
        dateLabel.font = Fonts.RobotoCondensedRegularMicro
        
        selectedIndicator.backgroundColor = .white
        selectedIndicator.layer.cornerRadius = 2
        selectedIndicator.isHidden = true
    }
    
    func setupConstraints() {
        cellView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        dayLabel.snp.makeConstraints() {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().inset(24)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
        
        dateLabel.snp.makeConstraints() {
            $0.top.equalToSuperview().offset(22)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
        
        selectedIndicator.snp.makeConstraints() {
            $0.height.equalTo(4)
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.bottom.equalToSuperview()
        }
    }
}
