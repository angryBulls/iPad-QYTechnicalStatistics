//
//  QYRegistrationSecHeaderV.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/13.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYRegistrationSecHeaderV : UICollectionReusableView

// 根据分组不同 设置主队和客队图片
- (void)settingWithIndexPath:(NSIndexPath *)indexPath;

@end
