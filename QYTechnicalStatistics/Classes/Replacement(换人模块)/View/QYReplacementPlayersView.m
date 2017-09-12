//
//  QYReplacementPlayersView.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/7/11.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYReplacementPlayersView.h"
#import "QYReplacePlayerView.h"
#define kTestRowCount 3
#define kPlayersCount 15

@interface QYReplacementPlayersView () <QYReplacePlayerViewDelegate>

/**
 *  存放球员对象的数组
 */
@property (strong, nonatomic) NSMutableArray * players;

/**
 *  当前选中的球员数组(最多两个元素)
 */
@property (strong, nonatomic) NSMutableArray * currentSelectedPlayers;

@end

@implementation QYReplacementPlayersView

+ (instancetype)createReplacementPlayersView {
    
    QYReplacementPlayersView * replacementPlayersView = [[QYReplacementPlayersView alloc] init];
    replacementPlayersView.backgroundColor = [UIColor clearColor];
    return replacementPlayersView;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 球员九宫格布局
    for (NSInteger count = 0; count < self.players.count; count++) {
        
        QYReplacePlayerView * tmpView = self.players[count];
        NSInteger lineTotalCount = 5; // 固定的
        
        NSInteger col = count % lineTotalCount;
        NSInteger row = count / lineTotalCount;
        
        tmpView.scaleW = 158;
        tmpView.scaleH = 226+50+10;
        tmpView.scaleX = col * (CGScaleGetWidth(tmpView.frame)+184);
        tmpView.scaleY = row * (CGScaleGetHeight(tmpView.frame)+50);
    }
    
}

- (void)setFrame:(CGRect)frame {
    
    frame.size.width = scaleW_ByPx(2048) - scaleW_ByPx(489);
    frame.size.height = kTestRowCount * scaleH_ByPx(286) + (kTestRowCount-1)*scaleH_ByPx(50);
    [super setFrame:frame];
}

#pragma mark - lazy

- (NSMutableArray *)players {
    
    if (!_players) {
        _players = [NSMutableArray array];
        
        // 创建每个球员视图对象
        for (NSInteger count = 0; count < kPlayersCount; count++) {
            
            QYReplacePlayerView * playerView = [[QYReplacePlayerView alloc] init];
            playerView.delegate = self;
//            playerView.backgroundColor = 5 > count ? [UIColor redColor] : [UIColor blueColor];
            playerView.isHost = 5 > count ? YES : NO;
            [_players addObject:playerView];
            [self addSubview:playerView];
        }
    }
    return _players;
}

- (NSMutableArray *)currentSelectedPlayers {
    
    if (!_currentSelectedPlayers) {
        _currentSelectedPlayers = [NSMutableArray array];
    }
    return _currentSelectedPlayers;
}

#pragma mark - < QYReplacePlayerViewDelegate >
- (void)tapReplacePlayerView:(QYReplacePlayerView *)replacePlayerView {
    
    [self.currentSelectedPlayers addObject:replacePlayerView];
    if (self.currentSelectedPlayers.count > 1) {
     
        QYReplacePlayerView *firstView = self.currentSelectedPlayers[0];
        QYReplacePlayerView *secondView = self.currentSelectedPlayers[1];
        
        if (firstView.isHost == secondView.isHost) {
            
            [firstView removeCoverView];
            [secondView removeCoverView];
            
        } else {
            
            firstView.isHost = !firstView.isHost;
            secondView.isHost = !secondView.isHost;
            
            UIColor * tmpColor = firstView.backgroundColor;
            firstView.backgroundColor = secondView.backgroundColor;
            secondView.backgroundColor = tmpColor;
            
            [UIView animateWithDuration:1.0 animations:^{
                
                CGRect tmpFrame = firstView.frame;
                firstView.frame = secondView.frame;
                secondView.frame = tmpFrame;
            } completion:^(BOOL finished) {
                
                [firstView removeCoverView];
                [secondView removeCoverView];
            }];

        }
        
        // 交换完毕后 清空数组
        [self.currentSelectedPlayers removeAllObjects];
    }
}

@end
