//
//  CustomFlowLayout.swift
//  CollectionTransition
//
//  Created by Alexander Blokhin on 11.01.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        self.minimumLineSpacing = 1.0
        self.minimumInteritemSpacing = 1.0
        self.scrollDirection = .Vertical
    }
    
    override var itemSize: CGSize {
        set {
            
        }
        get {
            let numberOfColumns: CGFloat = 3
            
            let itemWidth = (CGRectGetWidth(self.collectionView!.frame) - (numberOfColumns - 1)) / numberOfColumns
            return CGSizeMake(itemWidth, itemWidth)
        }
    }
}
