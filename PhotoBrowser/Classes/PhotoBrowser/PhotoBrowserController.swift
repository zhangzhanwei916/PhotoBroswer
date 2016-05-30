//
//  PhotoBrowserController.swift
//  PhotoBrowser
//
//  Created by xiaomage on 16/4/27.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit

class PhotoBrowserController: UIViewController {
    // MARK:- 定义属性
    let PhotoBrowserCell = "PhotoBrowserCell"
    var indexPath : NSIndexPath?
    var shops : [Shop]?
    
    // MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: PhotoBrowserCollectionLayout())
    private lazy var closeBtn : UIButton = UIButton(title: "关 闭", bgColor: UIColor.darkGrayColor(), fontSize: 14.0)
    private lazy var saveBtn : UIButton = UIButton(title: "保 存", bgColor: UIColor.darkGrayColor(), fontSize: 14.0)
    
    // MARK:- 系统回调函数
    override func loadView() {
        super.loadView()
        
        view.frame.size.width += 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.设置UI界面
        setupUI()
        
        // 2.滚到对应的位置
        collectionView.scrollToItemAtIndexPath(indexPath!, atScrollPosition: .Left, animated: false)
    }
}

// MARK:- 实现dimissDelegat中的方法
extension PhotoBrowserController : DismissDelegate {
    func currentIndexPath() -> NSIndexPath {
        // 1.获取正在显示的cell
        let cell = collectionView.visibleCells().first!
        
        // 2.获取indexPath
        return collectionView.indexPathForCell(cell)!
    }
    
    func imageView() -> UIImageView {
        // 1.创建UIImageView对象
        let imageView = UIImageView()
        
        // 2.设置对象的图片
        // 2.1.获取正在显示的cell
        let cell = collectionView.visibleCells().first as! PhotoBrowserViewCell
        
        // 2.2.取出图片
        imageView.image = cell.imageView.image
        
        // 3.设置imageView的属性
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
}


// MARK:- 设置UI界面
extension PhotoBrowserController {
    func setupUI() {
        // 1.添加子控件
        view.addSubview(collectionView)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
        
        // 2.设置控件的frame
        collectionView.frame = view.bounds
        let btnW : CGFloat = 90
        let btnH : CGFloat = 32
        let btnY = UIScreen.mainScreen().bounds.height - btnH - 20
        closeBtn.frame = CGRect(x: 20, y: btnY, width: btnW, height: btnH)
        let saveBtnX = UIScreen.mainScreen().bounds.width - btnW - 20
        saveBtn.frame = CGRect(x: saveBtnX, y: btnY, width: btnW, height: btnH)
        
        // 3.设置两个按钮的属性
        closeBtn.addTarget(self, action: "closeBtnClick", forControlEvents: .TouchUpInside)
        saveBtn.addTarget(self, action: "saveBtnClick", forControlEvents: .TouchUpInside)
        
        // 4.设置collectionView相关的属性
        // AnyClass : UIButton.self
        collectionView.registerClass(PhotoBrowserViewCell.self, forCellWithReuseIdentifier: PhotoBrowserCell)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}


// MARK:- 事件监听函数
extension PhotoBrowserController {
    @objc private func closeBtnClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func saveBtnClick() {
        // 1.取出正在屏幕中显示的Cell
        let cell = collectionView.visibleCells().first as! PhotoBrowserViewCell
        
        // 2.取出image
        let image = cell.imageView.image
        
        // 3.写入相册
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
}


// MARK:- 实现collectionView的数据源方法
extension PhotoBrowserController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // ?? 一般用在可选链后面
        // 如果前面的可选类型有一个没有值,那么直接使用??后面的值
        // 如果前面的可选类型都有值,那么对最终的解决进行解包
        return shops?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserCell, forIndexPath: indexPath) as! PhotoBrowserViewCell
        
        // 2.设置cell中的数据
        cell.shop = shops?[indexPath.item]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        closeBtnClick()
    }
}

