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
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return 15;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    // 创建分组头视图
    QYRegistrationSecHeaderV *  secHeadView =
    [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                       withReuseIdentifier:secHeaderView
                                              forIndexPath:indexPath];
    
    // 设置分组头视图
    [secHeadView settingWithIndexPath:indexPath];
    return secHeadView;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end
