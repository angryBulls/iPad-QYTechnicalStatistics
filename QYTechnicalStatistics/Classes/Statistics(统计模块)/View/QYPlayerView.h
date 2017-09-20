//
//  QYPlayerView.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/29.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "TSPlayerModel.h"

@protocol QYPlayerViewDelegate <NSObject>

-(void)backPlay:(Player *)p andStatus:(NSInteger )status;

-(void)backResultDic:(NSMutableDictionary *)resultDic ;

@end

@interface QYPlayerView : UIView
@property (nonatomic ,strong)Player *p;
@property (nonatomic ,strong)TSPlayerModel *playerModel;
@property (nonatomic ,assign)BOOL guest;
@property (nonatomic, copy) NSString * playerNum;
// 球员按钮
@property (strong, nonatomic) UIButton * playerBtn;

@property (nonatomic, weak) id<QYPlayerViewDelegate>delegate;
@property (nonatomic, assign) BOOL isGaming;

// 尺寸参数为PX
+ (instancetype)createPlayerViewWithTitle:(NSString *)title
                                  bgImage:(NSString *)bjImage
                                   frameX:(CGFloat)frameX
                                   frameY:(CGFloat)frameY;
- (void)show;

- (void)setPlayerTitle:(NSString *)title;


@end

