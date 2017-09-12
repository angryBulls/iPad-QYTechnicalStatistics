//
//  QYRegistrationHeaderView.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/6.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//  #316BFE

#import <UIKit/UIKit.h>

@protocol QYRegistrationHeaderViewDelegate <NSObject>

-(void)backPlayInfosByArr:(NSArray *)arr andTeam:(NSInteger)team;

@end


@interface QYRegistrationHeaderView : UIView

@property(nonatomic,weak)id<QYRegistrationHeaderViewDelegate>delegate;

+ (instancetype)initializeHeaderView;

@end
