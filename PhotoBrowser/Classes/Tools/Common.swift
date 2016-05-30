//
//  Common.swift
//  PhotoBrowser
//
//  Copyright © 2016年 张战威. All rights reserved.
//

import UIKit

func calculateFrame(image : UIImage) -> CGRect {
    let x : CGFloat = 0
    let width : CGFloat = UIScreen.mainScreen().bounds.width
    let height = width / image.size.width * image.size.height
    let y = (UIScreen.mainScreen().bounds.height - height) * 0.5
    
    return CGRect(x: x, y: y, width: width, height: height)
}