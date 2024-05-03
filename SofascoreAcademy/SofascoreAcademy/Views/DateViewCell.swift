import UIKit
import SnapKit
import SofaAcademic

class DateViewCell: UICollectionViewCell {
    
    static let identifier = "DateCell"
    
    private let cellView = UIView()
    private let dayLabel = UILabel()
    private let dateLabel = UILabel()
    private var dayOfWeek = ""
    private var dateString = ""
    var fullDate = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        styleViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(data: DateData) {
        dayLabel.text = data.dayOfWeek
        dateLabel.text = data.dateString
        fullDate = data.fullDate
    }
    
    func addViews() {
        addSubview(cellView)
        cellView.addSubview(dayLabel)
        addSubview(dateLabel)
    }
    
    func styleViews() {
        dayLabel.text = dayOfWeek
        dateLabel.text = dateString
        dayLabel.textColor = .white
        dateLabel.textColor = .white
        dayLabel.textAlignment = .center
        dateLabel.textAlignment = .center
        dayLabel.font = Fonts.RobotoCondensedRegularMicro
        dateLabel.font = Fonts.RobotoCondensedRegularMicro
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
    }
}

