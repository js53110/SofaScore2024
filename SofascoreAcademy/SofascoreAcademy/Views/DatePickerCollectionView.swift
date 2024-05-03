import Foundation
import SofaAcademic
import UIKit

class DatePickerCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        super.init(frame: frame, collectionViewLayout: layout)
        
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        self.register(DateViewCell.self, forCellWithReuseIdentifier: "DateCell")
        self.showsHorizontalScrollIndicator = false
        
        self.delegate = self
        self.dataSource = self
    }
}

extension DatePickerCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "DateCell", for: indexPath) as? DateViewCell {
            let dataForCell = Helpers.getDataForDateCell(index: indexPath.row)
            cell.update(data: dataForCell)
            cell.backgroundColor = Colors.colorPrimaryVariant
            return cell
        } else {
            fatalError("Failed to dequeue cell")
        }
    }
}

extension DatePickerCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 56, height: 48)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToCenterForItem(at: indexPath, animated: true)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? DateViewCell {
            print(cell.fullDate)
        }
    }

}

extension UICollectionView {
    
    func scrollToCenterForItem(at indexPath: IndexPath, animated: Bool) {
        guard let layoutAttributes = layoutAttributesForItem(at: indexPath) else {
            return
        }
        
        let cellCenterX = layoutAttributes.frame.midX
        let collectionViewCenterX = bounds.width / 2
        
        let offsetX = cellCenterX - collectionViewCenterX
        let contentOffset = CGPoint(x: max(offsetX, 0), y: 0)
        
        setContentOffset(contentOffset, animated: animated)
    }
}
