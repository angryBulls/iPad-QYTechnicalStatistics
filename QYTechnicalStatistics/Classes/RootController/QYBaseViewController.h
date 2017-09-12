//
//  QYBaseViewController.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/16.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYRegistrationSecHeaderV.h"
#import "UIColor+QYHexRGB.h"
#import "UIImage+QYColor.h"

@interface QYBaseViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

{
    __weak UICollectionView * _collectionView;
}

/**
 *  球员数据视图（子类重写getter方法，完成布局与创建）
 */
@property (nonatomic, weak) UICollectionView * collectionView;

@end
