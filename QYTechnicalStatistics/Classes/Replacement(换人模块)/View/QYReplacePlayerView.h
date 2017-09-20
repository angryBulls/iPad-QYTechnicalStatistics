//
//  QYReplacePlayerView.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/7/11.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYReplacePlayerView;
#import "TSPlayerModel.h"

@protocol QYReplacePlayerViewDelegate <NSObject>

@optional
- (void)tapReplacePlayerView:(QYReplacePlayerView *)replacePlayerView andQYreplaceModel:(TSPlayerModel *)playModel;

@end

@interface QYReplacePlayerView : UIView

@property (assign, nonatomic) BOOL isHost;

@property (nonatomic, weak) id<QYReplacePlayerViewDelegate> delegate;

@property (nonatomic ,strong)TSPlayerModel *playModel;

// 上下场标识Label(Button)
@property (strong, nonatomic) UIButton * switchoverBtn;

// 移除选中遮盖
- (void)removeCoverView;

@end
