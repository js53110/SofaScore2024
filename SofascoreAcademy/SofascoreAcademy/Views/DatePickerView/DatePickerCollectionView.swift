import Foundation
import SofaAcademic
import UIKit


class DatePickerCollectionView: UICollectionView {
        
    private var firstStart: Bool = true
    
    static let middleIndexPath: IndexPath = [0, 7]
    weak var datePickDelegate: DatePickDelegate?
    private var selectedDate: String
    private let datesToDisplay: [DateData]
    
    
    init(selectedDate: String, datesToDisplay: [DateData]) {
        self.selectedDate = selectedDate
        self.datesToDisplay = datesToDisplay
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        setupCollectionView()
    }
    
    // Override designated initializer
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        self.selectedDate = ""
        self.datesToDisplay = []
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: UICollectionViewDataSource
extension DatePickerCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        datesToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "DateCell", for: indexPath) as? DateViewCell {
            let dataForCell = datesToDisplay[indexPath.row]
            cell.update(data: dataForCell)
            
            if(cell.fullDate != selectedDate) {
                cell.setSelected(false)
            }
            
            cell.backgroundColor = Colors.colorPrimaryVariant
            
            if(firstStart) {
                scrollToTodayDate()
                if(indexPath == DatePickerCollectionView.middleIndexPath) {
                    cell.setSelected(true)
                    firstStart = !firstStart
                }
            }
            return cell
        } else {
            fatalError("Failed to dequeue cell")
        }
    }
}

//MARK: UICollectionViewDelegate
extension DatePickerCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 56, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToCenterForItem(at: indexPath, animated: true)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? DateViewCell {
            if(selectedDate != cell.fullDate){
                selectedDate = cell.fullDate ?? selectedDate
                
                collectionView.visibleCells.forEach {
                    ($0 as? DateViewCell)?.setSelected(false)
                }
                
                cell.setSelected(true)
                
                datePickDelegate?.displayEventsForSelectedDate(selectedDate: cell.fullDate ?? selectedDate)
            }
        }
    }
}

//MARK: UICollectionView - Private methods
private extension UICollectionView {
    
    func scrollToCenterForItem(at indexPath: IndexPath, animated: Bool) {
        scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
    }
}

//MARK: Private methods
private extension DatePickerCollectionView {
    
    func setupCollectionView() {
        self.register(DateViewCell.self, forCellWithReuseIdentifier: "DateCell")
        self.showsHorizontalScrollIndicator = false
        
        //MARK: Assigning delegates
        self.delegate = self
        self.dataSource = self
        
        backgroundColor = Colors.colorPrimaryVariant
    }
    
    func scrollToTodayDate() {
        scrollToCenterForItem(at: DatePickerCollectionView.middleIndexPath, animated: true)
    }
}
