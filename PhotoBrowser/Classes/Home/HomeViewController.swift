//
//  HomeViewController.swift
//  PhotoBrowser
//
//  Created by 张战威 on 16/4/27.
//  Copyright © 2016年 张战威. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeViewController: UICollectionViewController {
    
    // MARK:- 懒加载属性
    private lazy var shops : [Shop] = [Shop]()
    private lazy var photoBrowserAnimator = PhotoBrowserAnimator()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(0)
    }
}

// MARK:- 自定义的函数
extension HomeViewController {
    /// 展示图片浏览器
    private func showPhotoBrowser(indexPath : NSIndexPath) {
        // 1.创建图片浏览器的控制器
        let photoBrowserVc = PhotoBrowserController()
        
        // 2.给photoBrowserVc设置属性
        photoBrowserVc.indexPath = indexPath
        photoBrowserVc.shops = shops
        
        // 3.设置modal样式
        photoBrowserVc.modalPresentationStyle = .Custom
        photoBrowserVc.transitioningDelegate = photoBrowserAnimator
        
        // 4.给photoBrowserAnimator设置值
        photoBrowserAnimator.indexPath = indexPath
        photoBrowserAnimator.presentDelegate = self
        photoBrowserAnimator.dismissDelegate = photoBrowserVc
        
        // 5.弹出图片浏览器
        presentViewController(photoBrowserVc, animated: true, completion: nil)
    }
}

// MARK:- 实现presentDelegate中的方法
extension HomeViewController : PresentDelegate {
    func homeRect(indexPath: NSIndexPath) -> CGRect {
        // 1.取出cell
        let cell = (collectionView?.cellForItemAtIndexPath(indexPath))!
        
        // 2.将cell的frame转成cell如果是在window中坐标
        let homeFrame = collectionView!.convertRect(cell.frame, toCoordinateSpace: UIApplication.sharedApplication().keyWindow!)
        
        return homeFrame
    }
    
    func photoBrowserRect(indexPath: NSIndexPath) -> CGRect {
        // 1.取出cell
        let cell = (collectionView?.cellForItemAtIndexPath(indexPath) as? HomeViewCell)!
        
        // 2.取出cell中显示的图片
        let image = cell.imageView.image
        
        // 3.计算image放大之后的frame
        return calculateFrame(image!)
    }
    
    func imageView(indexPath: NSIndexPath) -> UIImageView {
        // 1.创建imageView对象
        let imageView = UIImageView()
        
        // 2.设置显示的图片
        // 2.1.取出cell
        let cell = (collectionView?.cellForItemAtIndexPath(indexPath))! as! HomeViewCell
        
        // 2.2.取出cell中显示的图片
        let image = cell.imageView.image
        
        // 2.3.设置图片
        imageView.image = image
        
        // 3.设置imageView的属性
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
}

// MARK:- 发送网络请求
extension HomeViewController {
    /// 加载数据
    private func loadData(offSet : Int) {
        NetworkTools.shareIntance.loadHomeData(offSet) { (result, error) -> () in
            // 1.错误校验
            if error != nil {
                print(error)
                return
            }
            
            // 2.获取结果
            guard let resultArray = result else {
                print("获取的结果不正确")
                return
            }
            
            // 3.遍历的结果
            for resultDict in resultArray {
                let shop = Shop(dict: resultDict)
                self.shops.append(shop)
            }
            
            // 4.刷新表格
            self.collectionView?.reloadData()
        }
    }
}


// MARK:- collectionview的数据源和代理方法
extension HomeViewController {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shops.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeCell", forIndexPath: indexPath) as! HomeViewCell
        
        // 2.给cell设置数据
        cell.shop = shops[indexPath.item]
        
        // 3.判断是否是最后一个cell出现在屏幕
        if indexPath.item == self.shops.count - 1 {
            loadData(self.shops.count)
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        showPhotoBrowser(indexPath)
    }
}
