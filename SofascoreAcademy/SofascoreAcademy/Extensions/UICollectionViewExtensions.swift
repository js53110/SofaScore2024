import Foundation
import UIKit

extension UICollectionView {
    
    func scrollToCenterForItem(at indexPath: IndexPath, animated: Bool) {
        scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
    }
}
