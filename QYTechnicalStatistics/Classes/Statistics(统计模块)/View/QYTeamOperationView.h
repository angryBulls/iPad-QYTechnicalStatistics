//
//  QYTeamOperationView.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/23.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//  

#import <UIKit/UIKit.h>

@protocol  QYTeamOperationViewDelegate<NSObject>

-(void)updataPauseStatus:(BOOL)status ;

@end
@interface QYTeamOperationView : UIView

@property(weak, nonatomic)id<QYTeamOperationViewDelegate>delegate;

// 为了布局 将此属性写入头文件
@property (strong, nonatomic) UILabel * pauseTimeLabel;

@property (strong, nonatomic) UILabel * foulScoreLabel;

@property (strong, nonatomic) UILabel * pauseScoreLabel;

@property (strong, nonatomic) UIButton * pauseAddBnt;

+ (instancetype)createTeamOperationViewWithTitleImg:(NSString *)titleImg;

@end
