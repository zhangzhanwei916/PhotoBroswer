//
//  PhotoBrowserViewCell.swift
//  PhotoBrowser
//
//  Created by 张战威 on 16/4/27.
//  Copyright © 2016年 张战威. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoBrowserViewCell: UICollectionViewCell {
    // MARK:- 懒加载属性
    lazy var imageView : UIImageView = UIImageView()
    
    // MARK:- 定义的属性
    var shop : Shop? {
        didSet {
            // 1.nil值校验
            guard let urlString = shop?.q_pic_url else {
                return
            }
            
            // 2.获取小图
            var smallImage = SDWebImageManager.sharedManager().imageCache.imageFromMemoryCacheForKey(urlString)
            if smallImage == nil {
                smallImage = UIImage(named: "empty_picture")
            }
            
            // 3.计算imageView的frame
            imageView.frame = calculateFrame(smallImage)
            
            // 4.设置大图
            guard let bigURLString = shop?.z_pic_url else {
                return
            }
            let url = NSURL(string: bigURLString)
            imageView.sd_setImageWithURL(url, placeholderImage: smallImage, options: .RetryFailed) { (image, error, type, url) -> Void in
                self.imageView.frame = calculateFrame(image)
            }
        }
    }
    
    // MARK:- 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面
extension PhotoBrowserViewCell {
    private func setupUI() {
        // 1.添加子控件
        contentView.addSubview(imageView)
    }
}