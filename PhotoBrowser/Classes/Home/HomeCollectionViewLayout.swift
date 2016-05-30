//
//  HomeCollectionViewLayout.swift
//  PhotoBrowser
//
//  Created by 张战威 on 16/4/27.
//  Copyright © 2016年 张战威. All rights reserved.
//

import UIKit

class HomeCollectionViewLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        
        // 1.定义常量
        let cols : CGFloat = 3
        let margin : CGFloat = 10
        
        // 2.计算item的WH
        let itemWH = (UIScreen.mainScreen().bounds.width - (cols + 1) * margin) / cols
        
        // 3.设置布局内容
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumInteritemSpacing = margin
        minimumLineSpacing = margin
        
        // 4.设置collectionView的属性
        collectionView?.contentInset = UIEdgeInsets(top: margin + 64, left: margin, bottom: margin, right: margin)
    }
}
