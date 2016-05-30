//
//  HomeViewCell.swift
//  PhotoBrowser
//
//  Created by 张战威 on 16/4/27.
//  Copyright © 2016年 张战威. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var shop : Shop? {
        didSet {
            
            // 1.nil值校验
            guard let urlString = shop?.q_pic_url else {
                return
            }
            
            // 2.创建URL
            let url = NSURL(string: urlString);
            
            // 3.设置图片
            imageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "empty_picture"))
        }
    }
}
