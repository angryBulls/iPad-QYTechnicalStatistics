//
//  QYReplacePlayerView.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/7/11.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYReplacePlayerView;

@protocol QYReplacePlayerViewDelegate <NSObject>

@optional
- (void)tapReplacePlayerView:(QYReplacePlayerView *)replacePlayerView;

@end

@interface QYReplacePlayerView : UIView

@property (assign, nonatomic) BOOL isHost;

@property (nonatomic, weak) id<QYReplacePlayerViewDelegate> delegate;

// 移除选中遮盖
- (void)removeCoverView;

@end
