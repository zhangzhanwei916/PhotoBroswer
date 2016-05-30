//
//  PhotoBrowserCollectionLayout.swift
//  PhotoBrowser
//
//  Created by xiaomage on 16/4/27.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit

class PhotoBrowserCollectionLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        
        // 1.设置布局相关的属性
        itemSize = collectionView!.bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .Horizontal
        
        // 2.设置collectionView的属性
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
    }
}
