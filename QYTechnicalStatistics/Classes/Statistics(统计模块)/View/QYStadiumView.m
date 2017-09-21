//
//  QYStadiumView.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/28.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYStadiumView.h"
#import "QYPlayerView.h"
#import "TSPlayerModel.h"
@interface QYStadiumView ()<QYPlayerViewDelegate>

// 球场背景图片
@property (strong, nonatomic) UIImageView * stadiumBjView;
@property (strong, nonatomic) UIButton * returnBtn;
@property (strong, nonatomic) UIButton * substitutionBtn;
@property (strong, nonatomic) UIButton * modificationOfSectionBtn;
@property (strong, nonatomic) UIButton * generateBtn;

@property (strong, nonatomic) QYPlayerView * hostPlayer_One;
@property (strong, nonatomic) QYPlayerView * hostPlayer_Two;
@property (strong, nonatomic) QYPlayerView * hostPlayer_Three;
@property (strong, nonatomic) QYPlayerView * hostPlayer_Four;
@property (strong, nonatomic) QYPlayerView * hostPlayer_Five;
@property (strong, nonatomic) QYPlayerView * guestPlayer_One;
@property (strong, nonatomic) QYPlayerView * guestPlayer_Two;
@property (strong, nonatomic) QYPlayerView * guestPlayer_Three;
@property (strong, nonatomic) QYPlayerView * guestPlayer_Four;
@property (strong, nonatomic) QYPlayerView * guestPlayer_Five;

@property (nonatomic ,strong) NSMutableArray *hostNumbArray;
@property (nonatomic ,strong) NSMutableArray *guestNumbArray;

@property (nonatomic ,strong)NSMutableArray *p_hostPlayingNumArray;
@property (nonatomic ,strong)NSMutableArray *p_guestPlayingNumArray;

@end

@implementation QYStadiumView

+ (instancetype)createStadiumView {
    
    QYStadiumView * stadiumView = [[QYStadiumView alloc] init];
    return stadiumView;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];

    // 布局子控件
    [self.stadiumBjView scaleFrameMake:0
                                      :0
                                      :CGScaleGetWidth(self.frame)
                                      :CGScaleGetHeight(self.frame)];
    [self.returnBtn scaleCenterBoundsMake:CGScaleGetCenterX(self.frame) :58+60 :206 :120];
    [self.substitutionBtn scaleFrameMake:468
                                        :CGScaleGetHeight(self.frame)-22-CGScaleGetHeight(self.returnBtn.frame)
                                        :CGScaleGetWidth(self.returnBtn.frame)
                                        :CGScaleGetHeight(self.returnBtn.frame)];
    [self.modificationOfSectionBtn scaleFrameMake:CGScaleGetMaxX(self.substitutionBtn.frame)+238
                                                        :CGScaleGetMinY(self.substitutionBtn.frame)
                                                        :CGScaleGetWidth(self.substitutionBtn.frame)
                                                        :CGScaleGetHeight(self.substitutionBtn.frame)];
    [self.generateBtn scaleFrameMake:CGScaleGetMaxX(self.modificationOfSectionBtn.frame)+270
                                    :CGScaleGetMinY(self.modificationOfSectionBtn.frame)
                                    :CGScaleGetWidth(self.modificationOfSectionBtn.frame)
                                    :CGScaleGetHeight(self.modificationOfSectionBtn.frame)];
    // add host player number view
    [self updatePlayersStatus];
    



    
}
-(void)setGameModel:(TSGameModel *)gameModel{
    _gameModel = gameModel;
    
    
    [self updatePlayersStatus];
    
    [self.hostPlayer_One setPlayerTitle:_p_hostPlayingNumArray[0]];
    [self.hostPlayer_Two setPlayerTitle:_p_hostPlayingNumArray[1]];
    [self.hostPlayer_Three setPlayerTitle:_p_hostPlayingNumArray[2]];
    [self.hostPlayer_Four setPlayerTitle:_p_hostPlayingNumArray[3]];
    [self.hostPlayer_Five setPlayerTitle:_p_hostPlayingNumArray[4]];
    [self.guestPlayer_One setPlayerTitle:_p_guestPlayingNumArray[0]];
    [self.guestPlayer_Two setPlayerTitle:_p_guestPlayingNumArray[1]];
    [self.guestPlayer_Three setPlayerTitle:_p_guestPlayingNumArray[2]];
    [self.guestPlayer_Four setPlayerTitle:_p_guestPlayingNumArray[3]];
    [self.guestPlayer_Five setPlayerTitle:_p_guestPlayingNumArray[4]];
    
}


- (void)updatePlayersStatus {
    // 取出主客队所有球员检录信息
    TSDBManager *tSDBManager = [[TSDBManager alloc] init];
    NSArray *playerCheckArrayH = [tSDBManager getObjectById:TeamCheckID_H fromTable:TSCheckTable];
    // 设置主队在场球员的号码
    NSMutableArray *hostPlayingNumArray = [NSMutableArray array];
    _hostDataSouce = [NSMutableArray array];
    [playerCheckArrayH enumerateObjectsUsingBlock:^(NSDictionary *subDict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (1 == [subDict[@"playingStatus"] intValue]) {
            [hostPlayingNumArray addObject:[NSString stringWithFormat:@"%@", subDict[@"gameNum"]]];
            TSPlayerModel *playmodel = [TSPlayerModel new];
            playmodel.isStartPlayer = subDict[@"isStartPlayer"];
            playmodel.ID = subDict[@"id"];
            playmodel.gameNum = subDict[@"gameNum"];
            playmodel.playingTimes = subDict[@"playingTimes"];
            playmodel.playingStatus = subDict[@"playingStatus"];
            playmodel.photo = subDict[@"photo"];
            playmodel.playerNumber = subDict[@"playerNumber"];
            playmodel.name = subDict[@"name"];
            [_hostDataSouce addObject:playmodel];
            
        }
    }];
    _p_hostPlayingNumArray = hostPlayingNumArray;
    // 设置客队在场球员的号码
    NSArray *playerCheckArrayG = [tSDBManager getObjectById:TeamCheckID_G fromTable:TSCheckTable];
    _guestDataSouce = [NSMutableArray array];
    NSMutableArray *guestPlayingNumArray = [NSMutableArray array];
    [playerCheckArrayG enumerateObjectsUsingBlock:^(NSDictionary *subDict, NSUInteger idx, BOOL * _Nonnull stop) {
        if (1 == [subDict[@"playingStatus"] intValue]) {
            [guestPlayingNumArray addObject:[NSString stringWithFormat:@"%@", subDict[@"gameNum"]]];
            TSPlayerModel *playmodel = [TSPlayerModel new];
            playmodel.isStartPlayer = subDict[@"isStartPlayer"];
            playmodel.ID = subDict[@"id"];
            playmodel.gameNum = subDict[@"gameNum"];
            playmodel.playingTimes = subDict[@"playingTimes"];
            playmodel.playingStatus = subDict[@"playingStatus"];
            playmodel.photo = subDict[@"photo"];
            playmodel.playerNumber = subDict[@"playerNumber"];
            playmodel.name = subDict[@"name"];
            [_guestDataSouce addObject:playmodel];
            
        }
    }];
    
    _p_guestPlayingNumArray = guestPlayingNumArray;


}


#pragma mark - lazy

- (UIImageView *)stadiumBjView {
    
    if (!_stadiumBjView) {
        _stadiumBjView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"技术统计背景"]];
        [self addSubview:_stadiumBjView];
    }
    return _stadiumBjView;
}

- (UIButton *)returnBtn {
    
    if (!_returnBtn) {
        _returnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_returnBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, kSCALE_NUM(12), 0, kSCALE_NUM(12))];
        [_returnBtn.titleLabel setFont:kSCALE_BOLD_FONT(16)];
        _returnBtn.titleLabel.numberOfLines = 0;
        [_returnBtn setBackgroundImage:[UIImage imageNamed:@"篮球场上按钮"]
                              forState:(UIControlStateNormal)];
        [_returnBtn setBackgroundImage:[UIImage imageNamed:@"篮球场上按钮-选中"]
                              forState:(UIControlStateHighlighted)];
        [_returnBtn setTitle:@"返回上一次操作" forState:(UIControlStateNormal)];
        
        [_returnBtn addTarget:self action:@selector(p_revokeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_returnBtn];
    }
    return _returnBtn;
}

-(void)p_revokeBtnClick{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(p_revokeBtnClick)]) {
        
        [self.delegate p_revokeBtnClick];
        
    }
    
}

- (UIButton *)substitutionBtn {
    
    if (!_substitutionBtn) {
        _substitutionBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_substitutionBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, kSCALE_NUM(12), 0, kSCALE_NUM(12))];
        [_substitutionBtn.titleLabel setFont:kSCALE_BOLD_FONT(16)];
        _substitutionBtn.titleLabel.numberOfLines = 0;
        [_substitutionBtn setBackgroundImage:[UIImage imageNamed:@"篮球场上按钮"]
                              forState:(UIControlStateNormal)];
        [_substitutionBtn setBackgroundImage:[UIImage imageNamed:@"篮球场上按钮-选中"]
                              forState:(UIControlStateHighlighted)];
        [_substitutionBtn setTitle:@"换 人" forState:(UIControlStateNormal)];
        [_substitutionBtn addTarget:self action:@selector(replacePlayerClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_substitutionBtn];
    }
    return _substitutionBtn;
}

- (void)replacePlayerClick:(UIButton *)clickBtn {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(replacePlayerInStadiumView:)]) {
        [self.delegate replacePlayerInStadiumView:self];
    }
}

-(void)modificationClicked:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeInfoOfMatch)]) {
        [self.delegate changeInfoOfMatch];
    }
}
-(void)creatQuarterData:(UIButton *)btn{
//    if (_quarterEnd) {
        /*
         生成单节比赛
         */
        if (self.delegate && [self.delegate respondsToSelector:@selector(finishGameWithQuarter:)]) {
            [self.delegate finishGameWithQuarter:1];
//        }
        
    }
//    else{
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"停表后在提数据" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
//    }
    
    
}


- (UIButton *)modificationOfSectionBtn {
    
    if (!_modificationOfSectionBtn) {
        _modificationOfSectionBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_modificationOfSectionBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, kSCALE_NUM(20), 0, kSCALE_NUM(20))];
        [_modificationOfSectionBtn.titleLabel setFont:kSCALE_BOLD_FONT(16)];
        _modificationOfSectionBtn.titleLabel.numberOfLines = 0;
        _modificationOfSectionBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_modificationOfSectionBtn setBackgroundImage:[UIImage imageNamed:@"篮球场上按钮"]
                                    forState:(UIControlStateNormal)];
        [_modificationOfSectionBtn setBackgroundImage:[UIImage imageNamed:@"篮球场上按钮-选中"]
                                    forState:(UIControlStateHighlighted)];
        [_modificationOfSectionBtn setTitle:@"修改本节比赛" forState:(UIControlStateNormal)];
        [_modificationOfSectionBtn addTarget:self action:@selector(modificationClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_modificationOfSectionBtn];
    }
    return _modificationOfSectionBtn;
}

- (UIButton *)generateBtn {
    
    if (!_generateBtn) {
        _generateBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_generateBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, kSCALE_NUM(20), 0, kSCALE_NUM(20))];
        [_generateBtn.titleLabel setFont:kSCALE_BOLD_FONT(16)];
        _generateBtn.titleLabel.numberOfLines = 0;
        _generateBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_generateBtn setBackgroundImage:[UIImage imageNamed:@"篮球场上按钮"]
                                             forState:(UIControlStateNormal)];
        [_generateBtn setBackgroundImage:[UIImage imageNamed:@"篮球场上按钮-选中"]
                                             forState:(UIControlStateHighlighted)];
        [_generateBtn setTitle:@"生成本节比赛" forState:(UIControlStateNormal)];
        [_generateBtn addTarget:self action:@selector(creatQuarterData:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_generateBtn];
    }
    return _generateBtn;
}

- (QYPlayerView *)hostPlayer_One {
    
    if (!_hostPlayer_One) {
        _hostPlayer_One = [QYPlayerView createPlayerViewWithTitle:_p_hostPlayingNumArray[0] bgImage:@"红-主队" frameX:160 frameY:98];
         _hostPlayer_One.playerModel = _hostDataSouce[0];
        _hostPlayer_One.delegate = self;
        
        [self addSubview:_hostPlayer_One];
    }
    return _hostPlayer_One;
}

- (QYPlayerView *)hostPlayer_Two {
    
    if (!_hostPlayer_Two) {
        _hostPlayer_Two = [QYPlayerView createPlayerViewWithTitle:_p_hostPlayingNumArray[1] bgImage:@"红-主队" frameX:286 frameY:458];
        _hostPlayer_Two.playerModel = _hostDataSouce[1];
        _hostPlayer_Two.delegate = self;
        [self addSubview:_hostPlayer_Two];
    }
    return _hostPlayer_Two;
}

- (QYPlayerView *)hostPlayer_Three {
    
    if (!_hostPlayer_Three) {
        _hostPlayer_Three = [QYPlayerView createPlayerViewWithTitle:_p_hostPlayingNumArray[2] bgImage:@"红-主队" frameX:184 frameY:1130-112-218];
        _hostPlayer_Three.playerModel = _hostDataSouce[2];
        _hostPlayer_Three.delegate = self;
        
        [self addSubview:_hostPlayer_Three];
    }
    return _hostPlayer_Three;
}

- (QYPlayerView *)hostPlayer_Four {
    
    if (!_hostPlayer_Four) {
        _hostPlayer_Four = [QYPlayerView createPlayerViewWithTitle:_p_hostPlayingNumArray[3] bgImage:@"红-主队" frameX:632 frameY:284];
        _hostPlayer_Four.playerModel = _hostDataSouce[3];
        _hostPlayer_Four.delegate = self;
        [self addSubview:_hostPlayer_Four];
    }
    return _hostPlayer_Four;
}

- (QYPlayerView *)hostPlayer_Five {
    
    if (!_hostPlayer_Five) {
       _hostPlayer_Five = [QYPlayerView createPlayerViewWithTitle:_p_hostPlayingNumArray[4] bgImage:@"红-主队" frameX:626 frameY:158+284+218];
        _hostPlayer_Five.playerModel = _hostDataSouce[4];
        _hostPlayer_Five.delegate = self;
        
        [self addSubview:_hostPlayer_Five];
    }
    return _hostPlayer_Five;
}

- (QYPlayerView *)guestPlayer_One {
    
    if (!_guestPlayer_One) {
        
        _guestPlayer_One = [QYPlayerView createPlayerViewWithTitle:_p_guestPlayingNumArray[0] bgImage:@"绿-客队" frameX:2048-218-154 frameY:94];
        _guestPlayer_One.playerModel = _guestDataSouce[0];
        _guestPlayer_One.guest = 1;
        _guestPlayer_One.delegate  = self;
        
        
        [self addSubview:_guestPlayer_One];
    }
    return _guestPlayer_One;
}

- (QYPlayerView *)guestPlayer_Two {
    
    if (!_guestPlayer_Two) {
        _guestPlayer_Two = [QYPlayerView createPlayerViewWithTitle:_p_guestPlayingNumArray[1] bgImage:@"绿-客队" frameX:2048-218-286 frameY:464];
        _guestPlayer_Two.playerModel = _guestDataSouce[1];
        _guestPlayer_Two.guest = 1;
        _guestPlayer_Two.delegate = self;
        [self addSubview:_guestPlayer_Two];
    }
    return _guestPlayer_Two;
}

- (QYPlayerView *)guestPlayer_Three {
    
    if (!_guestPlayer_Three) {
        
        _guestPlayer_Three = [QYPlayerView createPlayerViewWithTitle:_p_guestPlayingNumArray[2] bgImage:@"绿-客队" frameX:2048-218-154 frameY:1130-218-100];
        _guestPlayer_Three.playerModel = _guestDataSouce[2];
        _guestPlayer_Three.guest = 1;
        _guestPlayer_Three.delegate = self;
        
        [self addSubview:_guestPlayer_Three];
    }
    return _guestPlayer_Three;
}

- (QYPlayerView *)guestPlayer_Four {
    
    if (!_guestPlayer_Four) {
        _guestPlayer_Four = [QYPlayerView createPlayerViewWithTitle:_p_guestPlayingNumArray[3] bgImage:@"绿-客队" frameX:2048-218-638 frameY:270];
        _guestPlayer_Four.playerModel = _guestDataSouce[3];
        _guestPlayer_Four.guest = 1;
        _guestPlayer_Four.delegate  = self;
        [self addSubview:_guestPlayer_Four];
    }
    return _guestPlayer_Four;
}

- (QYPlayerView *)guestPlayer_Five {
    
    if (!_guestPlayer_Five) {
        _guestPlayer_Five = [QYPlayerView createPlayerViewWithTitle:_p_guestPlayingNumArray[4] bgImage:@"绿-客队" frameX:2048-218-640 frameY:270+162+218];
        _guestPlayer_Five.playerModel = _guestDataSouce[4];
        _guestPlayer_Five.guest = 1;
        _guestPlayer_Five.delegate = self;
        [self addSubview:_guestPlayer_Five];
    }
    return _guestPlayer_Five;
}

#pragma mark 代理
-(void)backPlay:(Player *)p andStatus:(NSInteger)status{
    if (self.delegate && [self respondsToSelector:@selector(backPlay:andStatus:)]) {
        
        [_delegate backStatusWithPlayer:p Status:status];
    }
    
}
-(void)backResultDic:(NSMutableDictionary *)resultDic{
    if (self.delegate && [self respondsToSelector:@selector(backResultDic:)]) {
        [_delegate backResult:resultDic];
    }
}

@end
