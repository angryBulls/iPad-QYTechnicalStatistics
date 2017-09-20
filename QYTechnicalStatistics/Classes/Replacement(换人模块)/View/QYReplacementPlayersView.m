//
//  QYReplacementPlayersView.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/7/11.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYReplacementPlayersView.h"
#import "QYReplacePlayerView.h"
#import "TSPlayerModel.h"
#define kTestRowCount 3
#define kPlayersCount 15

@interface QYReplacementPlayersView () <QYReplacePlayerViewDelegate>

/**
 *  存放球员对象的数组
 */
@property (strong, nonatomic) NSMutableArray * players;

/**
 *  当前选中的球员数组(最多4个元素,view model view model)
 */
@property (strong, nonatomic) NSMutableArray * currentSelectedPlayers;


/**
 * 主队球员数组
 */
@property (nonatomic ,strong) NSMutableArray *hostOnDataSouce;
@property (nonatomic ,strong) NSMutableArray *hostOffDataSouce;

/**
 * 客队球员数组
 */
@property (nonatomic ,strong) NSMutableArray *guestOnDataSouce;
@property (nonatomic ,strong) NSMutableArray *guestOffDataSouce;
/**
 * 交换球员数组
 */
@property (nonatomic ,strong) NSMutableDictionary *insterDic1;
@property (nonatomic ,strong) NSMutableDictionary *insterDic2;




@end

@implementation QYReplacementPlayersView

+ (instancetype)createReplacementPlayersView {
    
    QYReplacementPlayersView * replacementPlayersView = [[QYReplacementPlayersView alloc] init];
    replacementPlayersView.backgroundColor = [UIColor clearColor];
    return replacementPlayersView;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self updatePlayersStatus];
    
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
        
    }
    return _players;
}

- (NSMutableArray *)currentSelectedPlayers {
    
    if (!_currentSelectedPlayers) {
        _currentSelectedPlayers = [NSMutableArray array];
    }
    return _currentSelectedPlayers;
}

-(NSMutableDictionary *)insterDic1{
    if (_insterDic1 == nil) {
        _insterDic1 = [NSMutableDictionary dictionary];
    }
    
    return _insterDic1;
}
-(NSMutableDictionary *)insterDic2{
    if (_insterDic2 == nil) {
        _insterDic2 = [NSMutableDictionary dictionary];
    }
    return _insterDic2;
}


#pragma mark - < QYReplacePlayerViewDelegate >
- (void)tapReplacePlayerView:(QYReplacePlayerView *)replacePlayerView andQYreplaceModel:(TSPlayerModel *)playModel{
    
    [self.currentSelectedPlayers addObject:replacePlayerView];
    [self.currentSelectedPlayers addObject:playModel];
    
    if (self.currentSelectedPlayers.count > 3) {
     
        QYReplacePlayerView *firstView = self.currentSelectedPlayers[0];
        TSPlayerModel *firstPlayModel = self.currentSelectedPlayers[1];
        QYReplacePlayerView *secondView = self.currentSelectedPlayers[2];
        TSPlayerModel *secondPlayModel = self.currentSelectedPlayers[3];
        
        if (firstView.isHost == secondView.isHost) {
            
            [firstView removeCoverView];
            
            [secondView removeCoverView];
            
        } else {
            
            self.insterDic1[NumbResultStr] = firstPlayModel.gameNum;
            if ([firstPlayModel.playingStatus boolValue]) {
                _insterDic1[BnfBehaviorType] =@"11";
            }
            else{
                _insterDic1[BnfBehaviorType] =@"12";
            }
            _insterDic1[BnfTeameType] = [NSString stringWithFormat:@"%d",_isGuest];
            
            self.insterDic2[NumbResultStr] = secondPlayModel.gameNum;
            if ([secondPlayModel.playingStatus boolValue]) {
                _insterDic2[BnfBehaviorType] =@"11";
            }
            else{
                _insterDic2[BnfBehaviorType] =@"12";
            }
             _insterDic2[BnfTeameType] = [NSString stringWithFormat:@"%d",_isGuest];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(backPlaysChangeDic1:AndPlaysChangeDic2:)]) {
                [self.delegate backPlaysChangeDic1:_insterDic1 AndPlaysChangeDic2:_insterDic2];
                
            }
            
            UIColor * tmpColor = firstView.backgroundColor;
            firstView.backgroundColor = secondView.backgroundColor;
            secondView.backgroundColor = tmpColor;
            
            [UIView animateWithDuration:.3 animations:^{
                
                CGRect tmpFrame = firstView.frame;
                firstView.frame = secondView.frame;
                secondView.frame = tmpFrame;
            } completion:^(BOOL finished) {
                firstView.switchoverBtn.selected = !firstView.switchoverBtn.selected;
                secondView.switchoverBtn.selected = !secondView.switchoverBtn.selected;
                
                [firstView removeCoverView];
                [secondView removeCoverView];
            }];
   

        }
        // 交换完毕后 清空数组
        [self.currentSelectedPlayers removeAllObjects];
    }
}


- (void)updatePlayersStatus {
    // 取出主客队所有球员检录信息
    TSDBManager *tSDBManager = [[TSDBManager alloc] init];

    if (_isGuest == 0) {
        _hostOnDataSouce = [NSMutableArray array];
        _hostOffDataSouce = [NSMutableArray array];
        NSArray *playerCheckArrayH = [tSDBManager getObjectById:TeamCheckID_H fromTable:TSCheckTable];
        
        for (NSDictionary * subDict in playerCheckArrayH) {
            TSPlayerModel *playmodel = [TSPlayerModel new];
            playmodel.isStartPlayer = subDict[@"isStartPlayer"];
            playmodel.ID = subDict[@"id"];
            playmodel.gameNum = subDict[@"gameNum"];
            playmodel.playingTimes = subDict[@"playingTimes"];
            playmodel.playingStatus = subDict[@"playingStatus"];
            playmodel.photo = subDict[@"photo"];
            playmodel.playerNumber = subDict[@"playerNumber"];
            playmodel.name = subDict[@"name"];
            if (1 == [subDict[@"playingStatus"] intValue]) {
                
                [_hostOnDataSouce addObject:playmodel];
                
            }
            else{
                [_hostOffDataSouce addObject:playmodel];
            }
            
        }
        
        // 创建每个球员视图对象
        for (NSInteger count = 0; count < _hostOnDataSouce.count +_hostOffDataSouce.count; count++) {
            
            QYReplacePlayerView * playerView = [QYReplacePlayerView new];
            playerView.delegate = self;
            [self.players addObject:playerView];
            [self addSubview:playerView];
            
            if (count<5) {
                playerView.isHost = 1;
                playerView.playModel = _hostOnDataSouce[count];
            }
            else
            {
                playerView.isHost = 0;
                playerView.playModel = _hostOffDataSouce[count-5];
                
            }
            
        }
        [self inputPlayers];
        
    }
    else
    {
        
        _guestOnDataSouce = [NSMutableArray array];
        _guestOffDataSouce = [NSMutableArray array];
        NSArray *playerCheckArrayG = [tSDBManager getObjectById:TeamCheckID_G fromTable:TSCheckTable];
        for (NSDictionary * subDict in playerCheckArrayG) {
            TSPlayerModel *playmodel = [TSPlayerModel new];
            playmodel.isStartPlayer = subDict[@"isStartPlayer"];
            playmodel.ID = subDict[@"id"];
            playmodel.gameNum = subDict[@"gameNum"];
            playmodel.playingTimes = subDict[@"playingTimes"];
            playmodel.playingStatus = subDict[@"playingStatus"];
            playmodel.photo = subDict[@"photo"];
            playmodel.playerNumber = subDict[@"playerNumber"];
            playmodel.name = subDict[@"name"];
            if (1 == [subDict[@"playingStatus"] intValue]) {
                [_guestOnDataSouce addObject:playmodel];
            }
            else{
                [_guestOffDataSouce addObject:playmodel];
            }

        }
        // 创建每个球员视图对象
        for (NSInteger count = 0; count < _guestOnDataSouce.count +_guestOffDataSouce.count; count++) {
            QYReplacePlayerView * playerView = [QYReplacePlayerView new];
            playerView.delegate = self;
            [self.players addObject:playerView];
            [self addSubview:playerView];
            if (count<5) {
                playerView.playModel = _guestOnDataSouce[count];
                playerView.isHost = 1;
            }
            else
            {
                playerView.isHost = 0;
                playerView.playModel = _guestOffDataSouce[count-5];
                
            }
            
        }
        
        [self inputPlayers];
    }
    
}

-(void)inputPlayers{
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

@end
