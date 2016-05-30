//
//  Shop.swift
//  PhotoBrowser
//
//  Created by 张战威 on 16/4/27.
//  Copyright © 2016年 张战威. All rights reserved.
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
