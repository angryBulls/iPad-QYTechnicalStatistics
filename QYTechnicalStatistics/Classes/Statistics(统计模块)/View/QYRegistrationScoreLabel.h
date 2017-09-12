//
//  QYRegistrationScoreLabel.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/21.
//  Copyright © 2017年 qiuyouquan. All rights reserved.

//  检录页面titleView里面显示的复合分数Label

#import <UIKit/UIKit.h>

@interface QYRegistrationScoreLabel : UIImageView

/**
 *  球队名字(主队 / 客队)
 */
@property (nonatomic, copy) NSString * teamName;

/**
 *  分数
 */
@property (assign, nonatomic) NSInteger score;

+ (instancetype)getRegistrationScoreLabel;

@end
