//
//  QYBaseViewController.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/16.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYBaseViewController.h"

@interface QYBaseViewController ()

@end

@implementation QYBaseViewController
// Sec头部视图重用ID
static NSString * const secHeaderView = @"secHeaderView";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化设置
    [self initializeSettings];
}


/** 初始化设置 */
- (void)initializeSettings {
    
    // 导航栏底线隐藏处理
    [self.navigationController.navigationBar
     setShadowImage:[UIImage new]];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:
     [UIImage imageWithColor:[UIColor colorWithHexRGB:
                              kREGISTRATION_HEADER_VIEW_COLOR andAlpha:1.0f]] forBarMetrics:
     UIBarMetricsDefault];
    
    // register
    [self.collectionView registerClass:[QYRegistrationSecHeaderV class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:secHeaderView];
    
    // register
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:@"secFooterView"];
    
}


#pragma mark <UICollectionViewDataSource>





@end
