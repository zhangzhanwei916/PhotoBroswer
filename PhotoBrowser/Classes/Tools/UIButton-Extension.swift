//
//  UIButton-Extension.swift
//  PhotoBrowser
//
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit


extension UIButton {
    // 必须使用`便利构造`函数
    /*
     便利构造函数的特点
        1.必须在init前面加载convenience
        2.在init方法中必须调用self.init()
    */
    convenience init(title : String, bgColor : UIColor, fontSize : CGFloat) {
        self.init()
        
        setTitle(title, forState: .Normal)
        backgroundColor = bgColor
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
}