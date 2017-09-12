//
//  QYRegistrationMinView.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/23.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QYTeamOperationView.h"
#import "QYTeamMidView.h"

@protocol QYRegistrationMinViewDelegate <NSObject>
@optional
-(void)startGaming;
-(void)quarterGameEnd;

@end

@interface QYRegistrationMinView : UIView

// 主队操作视图
@property (nonatomic, strong) QYTeamOperationView * hostOperationView;
// 客队操作视图
@property (nonatomic, strong) QYTeamOperationView * guestOperationView;


// 中部背景view
@property (strong, nonatomic) QYTeamMidView * midBjView;

@property (nonatomic,weak) id <QYRegistrationMinViewDelegate>delegate;

+ (instancetype)createRegistrationMinView;

@end
