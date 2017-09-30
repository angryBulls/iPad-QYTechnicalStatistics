//
//  QYTeamMidView.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/28.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSGameModel.h"
@protocol QYTeamMidViewDelegate <NSObject>

-(void)backPauseStatus:(BOOL)pause;
-(void)startGame;
-(void)quarterEnd;
@end
@interface QYTeamMidView : UIView
@property (nonatomic,weak) id <QYTeamMidViewDelegate> delegate;

// 开始计时按钮
@property (strong, nonatomic) UIButton * startingBtn;
// 暂停计时按钮
@property (strong, nonatomic) UIButton * pauseBtn;

// 分钟倒计时Label
@property (strong, nonatomic) UILabel * minLabel;
// 秒钟倒计时Label
@property (strong, nonatomic) UILabel * secLabel;

//倒计时
@property (nonatomic,assign) int currentSecond;
@property (nonatomic ,strong) QYToolsMethod *toolsMethod;

//用来限制是哪方发起的暂停
@property (nonatomic,assign) BOOL isPausIng;

/** 刷新时间 */
-(void)refreshTime;

@property (nonatomic ,strong)TSGameModel *gameModel;

@end
