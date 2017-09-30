//
//  QYRegistrationMinView.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/23.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYRegistrationMinView.h"


@interface QYRegistrationMinView ()<QYTeamMidViewDelegate,QYTeamOperationViewDelegate>


@end

@implementation QYRegistrationMinView

+ (instancetype)createRegistrationMinView {
    
    QYRegistrationMinView * registrationMinView = [[QYRegistrationMinView alloc] init];
    return registrationMinView;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 布局子控件
    [self.hostOperationView scaleFrameMake:0 :0 :695 :CGScaleGetHeight(self.frame)];
    [self.midBjView scaleCenterBoundsMake:CGScaleGetWidth(self.frame)/2 :CGScaleGetHeight(self.frame)/2-3 :658 :120];
    [self.guestOperationView scaleFrameMake:30+CGScaleGetMaxX(self.midBjView.frame) :0 :690 :CGScaleGetHeight(self.frame)];
    
    
    
}
-(void)setGameModel:(TSGameModel *)gameModel{
    _gameModel = gameModel;
    self.hostOperationView.gameModel = gameModel;
    self.guestOperationView.gameModel = gameModel;
    self.midBjView.gameModel = gameModel;
    
}
    
#pragma mark - lazy

- (QYTeamOperationView *)hostOperationView {
    
    if (!_hostOperationView) {
        _hostOperationView = [QYTeamOperationView createTeamOperationViewWithTitleImg:@"主队"];
        _hostOperationView.gameModel = _gameModel;
        _hostOperationView.delegate = self;
        [self addSubview:_hostOperationView];
    }
    return _hostOperationView;
}

- (QYTeamOperationView *)guestOperationView {
    
    if (!_guestOperationView) {
        _guestOperationView = [QYTeamOperationView createTeamOperationViewWithTitleImg:@"客队"];
        _guestOperationView.isGuest  = 1;
        _guestOperationView.gameModel = _gameModel;
        _guestOperationView.delegate = self;
        [self addSubview:_guestOperationView];
    }
    return _guestOperationView;
}

- (QYTeamMidView *)midBjView {
    
    if (!_midBjView) {
        _midBjView = [QYTeamMidView new];
        _midBjView.delegate = self;
        
        _midBjView.gameModel = _gameModel;
        _midBjView.layer.cornerRadius = kSCALE_NUM(5);
        _midBjView.backgroundColor = [UIColor colorWithHexRGB:@"#e8e8e8" andAlpha:1.0f];
        [self addSubview:_midBjView];
    }
    return _midBjView;
}

#pragma mark 代理
-(void)backPauseStatus:(BOOL)pause{
    if (pause == 0) {
        _guestOperationView.pauseAddBnt.enabled = 0;
        _hostOperationView.pauseAddBnt.enabled = 0;
    }
    else
    {
        _guestOperationView.pauseAddBnt.enabled = 1;
        _hostOperationView.pauseAddBnt.enabled = 1;
    }

}
-(void)quarterEnd{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(quarterGameEnd)]) {
        
        
        
    }
}

-(void)startGame{
    
    if ( self.delegate && [self.delegate respondsToSelector:@selector(startGaming)]) {
        [_delegate startGaming];
    }
}


-(void)backResultDic:(NSMutableDictionary *)dic andStatus:(NSInteger)status{
    
    _midBjView.isPausIng = 1;
    _guestOperationView.pauseAddBnt.enabled = 0;
    _hostOperationView.pauseAddBnt.enabled = 0;
    _midBjView.startingBtn.enabled = 1;
    _midBjView.pauseBtn.enabled = 0;
    _midBjView.currentSecond = [_midBjView.minLabel.text intValue] *60 +[_midBjView.secLabel.text intValue];
    
    [_midBjView.toolsMethod stopGCDTimer];
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateResultDic:andStatus:)]) {
        [_delegate updateResultDic:dic andStatus:status];
    }
    
}

-(void)refreshTime{
    [_midBjView refreshTime];
}

@end
