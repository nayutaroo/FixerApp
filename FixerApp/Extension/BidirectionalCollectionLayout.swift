import UIKit

final class BidirectionalCollectionLayout: UICollectionViewFlowLayout {
    
    weak var delegate: UICollectionViewDelegateFlowLayout?
    
    private var layoutInfo: [IndexPath : UICollectionViewLayoutAttributes] = [:]
    private var maxRowsWidth: CGFloat = 0
    private var maxColumnHeight: CGFloat = 0
    
    //列間のマージン
    private let marginInterItemsForSection : Int = 1
    //セクション間のマージン
    private let marginInterSection : Int = 1
    
    private func calcMaxRowsWidth() {
        guard
            let collectionView = self.collectionView,
            let delegate = self.delegate
        else { return }
                var maxRowWidth: CGFloat = 0
        for section in 0..<collectionView.numberOfSections {
            var maxWidth: CGFloat = 0
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let itemSize = delegate.collectionView!(collectionView, layout: self, sizeForItemAt: indexPath)
                maxWidth += itemSize.width
            }
            maxRowWidth = maxWidth > maxRowWidth ? maxWidth : maxRowWidth
        }
        
        self.maxRowsWidth = maxRowWidth + CGFloat( marginInterItemsForSection * (collectionView.numberOfSections - 1))
    }
    
    private func calcMaxColumnHeight() {
        
        guard
            let collectionView = self.collectionView,
            let delegate = self.delegate
        else { return }
        
        var maxHeight: CGFloat = 0
        for section in 0..<collectionView.numberOfSections {
            var maxRowHeight: CGFloat = 0
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let itemSize = delegate.collectionView!(collectionView, layout: self, sizeForItemAt: indexPath)
                maxRowHeight = itemSize.height > maxRowHeight ? itemSize.height : maxRowHeight
            }
            maxHeight += maxRowHeight
        }
        
        self.maxColumnHeight = maxHeight + CGFloat( marginInterSection * (collectionView.numberOfSections - 1))
    }
    
    private func calcCellLayoutInfo() {
        
        guard
            let collectionView = self.collectionView,
            let delegate = self.delegate
        else { return }
        
        var cellLayoutInfo: [IndexPath : UICollectionViewLayoutAttributes] = [:]
        
        var originY: CGFloat = 0
        
        for section in 0..<collectionView.numberOfSections {
            
            var height: CGFloat = 0
            var originX: CGFloat = 0
            
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let itemAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                let itemSize = delegate.collectionView!(collectionView, layout: self, sizeForItemAt: indexPath)
                itemAttributes.frame = CGRect(x: originX, y: originY, width: itemSize.width, height: itemSize.height)
                cellLayoutInfo[indexPath] = itemAttributes
                
                originX += itemSize.width + CGFloat( marginInterItemsForSection )
                height = height > itemSize.height ? height : itemSize.height
            }
            originY += height + CGFloat( marginInterSection )
        }
        
        self.layoutInfo = cellLayoutInfo
    }
    
    override func prepare() {
        self.delegate = self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout
        self.calcMaxRowsWidth()
        self.calcMaxColumnHeight()
        self.calcCellLayoutInfo()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var allAttributes: [UICollectionViewLayoutAttributes] = []
        for attributes in self.layoutInfo.values {
            
            if rect.intersects(attributes.frame) {
                allAttributes.append(attributes)
            }
        }
        return allAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        return self.layoutInfo[indexPath]
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.maxRowsWidth, height: self.maxColumnHeight)
    }

}
