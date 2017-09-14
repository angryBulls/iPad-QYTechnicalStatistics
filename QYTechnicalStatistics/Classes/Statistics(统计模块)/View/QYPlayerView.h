//
//  QYPlayerView.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/29.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"


@protocol QYPlayerViewDelegate <NSObject>

-(void)backPlay:(Player *)p andStatus:(NSInteger )status;

@end

@interface QYPlayerView : UIView
@property (nonatomic ,strong)Player *p;
@property (nonatomic, copy) NSString * playerNum;
@property (nonatomic, weak) id<QYPlayerViewDelegate>delegate;
@property (nonatomic, assign) BOOL isGaming;

// 尺寸参数为PX
+ (instancetype)createPlayerViewWithTitle:(NSString *)title
                                  bgImage:(NSString *)bjImage
                                   frameX:(CGFloat)frameX
                                   frameY:(CGFloat)frameY;
- (void)show;

@end

