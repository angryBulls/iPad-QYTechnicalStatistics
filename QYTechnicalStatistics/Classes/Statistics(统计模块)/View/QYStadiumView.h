//
//  QYStadiumView.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/28.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "TSGameModel.h"
@class QYStadiumView;

@protocol QYStadiumViewDelegate <NSObject>

@optional
//更换球员
- (void)replacePlayerInStadiumView:(QYStadiumView *)stadiumView;
//更改比赛信息
- (void)changeInfoOfMatch;
//结束单节比赛
- (void)finishGameWithQuarter:(NSInteger)quarter;
//撤回上一条信息
-(void)p_revokeBtnClick;

-(void)backStatusWithPlayer:(Player *)p Status:(NSInteger)status;
//更新球员比赛信息
-(void)backResult:(NSMutableDictionary *)resultDic;




@end

@interface QYStadiumView : UIView
@property(nonatomic,assign) BOOL quarterEnd;;
@property (nonatomic, weak) id<QYStadiumViewDelegate> delegate;
@property (nonatomic ,strong)NSMutableArray *hostDataSouce;
@property (nonatomic ,strong)NSMutableArray *guestDataSouce;
@property (nonatomic ,strong) TSGameModel *gameModel;

+ (instancetype)createStadiumView;

@end
