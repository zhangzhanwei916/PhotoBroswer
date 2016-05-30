//
//  Shop.swift
//  PhotoBrowser
//
//  Created by xiaomage on 16/4/27.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit

class Shop: NSObject {
    var q_pic_url : String = ""
    var z_pic_url : String = ""
    
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}
