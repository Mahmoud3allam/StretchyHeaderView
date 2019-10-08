//
//  StretchyLayout.swift
//  StretchyHeaderSample
//
//  Created by Alchemist on 10/8/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

class StretchyLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        layoutAttributes?.forEach({ (attributes) in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0{
                guard let collectionView = collectionView else {return}
                guard  collectionView.contentOffset.y < 0 else {return}
                let width = collectionView.frame.width
                let height = attributes.frame.height - collectionView.contentOffset.y
                attributes.frame = CGRect(x: 0, y: collectionView.contentOffset.y, width: width, height: height)
            }
        })
        return layoutAttributes
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
