//
//  QYStadiumView.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/28.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
@class QYStadiumView;

@protocol QYStadiumViewDelegate <NSObject>

@optional
- (void)replacePlayerInStadiumView:(QYStadiumView *)stadiumView;

- (void)changeInfoOfMatch;

- (void)finishGameWithQuarter:(NSInteger)quarter;

-(void)backStatusWithPlayer:(Player *)p Status:(NSInteger)status;


@end

@interface QYStadiumView : UIView
@property(nonatomic,assign) BOOL quarterEnd;;
@property (nonatomic, weak) id<QYStadiumViewDelegate> delegate;


+ (instancetype)createStadiumView;

@end
