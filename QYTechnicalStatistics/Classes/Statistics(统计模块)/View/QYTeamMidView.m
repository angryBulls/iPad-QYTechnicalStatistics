//
//  QYTeamMidView.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/28.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYTeamMidView.h"

@interface QYTeamMidView ()

// 场次Label
@property (strong, nonatomic) UILabel * sessionLabel;


// 冒号比分Label
@property (strong, nonatomic) UILabel * colonLabel;

@property (nonatomic ,strong) NSTimer *timer;



//比赛状态
@property (nonatomic,assign) BOOL isGaming;


@end

@implementation QYTeamMidView

-(void)start{
    
}
-(void)pause{
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    _isGaming = 0;
    _isPausIng = 1;
    
    
    // 布局子控件
    self.sessionLabel.scaleX = 14;
    self.sessionLabel.scaleY = 46;
    [self.sessionLabel sizeToFit];
    [self.minLabel scaleFrameMake:20+CGScaleGetMaxX(self.sessionLabel.frame) :20 :84 :84];
    [self.colonLabel sizeToFit];
    self.colonLabel.scaleW = 16;
    self.colonLabel.scaleCenterY = CGScaleGetCenterY(self.minLabel.frame);
    self.colonLabel.scaleCenterX = CGScaleGetMaxX(self.minLabel.frame) + CGScaleGetWidth(self.colonLabel.frame)/2 + 8;
    [self.secLabel scaleFrameMake:8+CGScaleGetMaxX(self.colonLabel.frame) :20 :84 :84];
    [self.startingBtn scaleFrameMake:CGScaleGetMaxX(self.secLabel.frame)+34 :26 :125 :72];
    [self.pauseBtn scaleFrameMake:CGScaleGetMaxX(self.startingBtn.frame)+26 :26 :125 :72];
    self.currentSecond = StageGameTimes;
}

#pragma mark - lazy

- (UILabel *)sessionLabel {
    
    if (!_sessionLabel) {
        _sessionLabel = [[UILabel alloc] init];
        _sessionLabel.textColor = [UIColor colorWithHexRGB:@"#333333" andAlpha:1.0f];
        _sessionLabel.text = @"第一节";
        _sessionLabel.textAlignment = NSTextAlignmentCenter;
        _sessionLabel.font = kSCALE_FONT(16);
        [self addSubview:_sessionLabel];
    }
    return _sessionLabel;
}

- (UILabel *)minLabel {
    
    if (!_minLabel) {
        NSInteger min = [[[NSUserDefaults standardUserDefaults] objectForKey:lastTime] integerValue]/60;
        
        
        _minLabel = [[UILabel alloc] init];
        _minLabel.backgroundColor = [UIColor whiteColor];
        _minLabel.layer.cornerRadius = kSCALE_NUM(5);
        _minLabel.layer.masksToBounds = YES;
        _minLabel.textColor = [UIColor colorWithHexRGB:@"#333333" andAlpha:1.0f];
        _minLabel.text = [NSString stringWithFormat:@"%ld",min];
        _minLabel.textAlignment = NSTextAlignmentCenter;
        _minLabel.font = kSCALE_FONT_NAME_SIZE(@"DBLCDTempBlack", 21);
        [self addSubview:_minLabel];
    }
    return _minLabel;
}

- (UILabel *)colonLabel {
    
    if (!_colonLabel) {
        _colonLabel = [[UILabel alloc] init];
        _colonLabel.text = @":";
        _colonLabel.font = kSCALE_BOLD_FONT(21);
        _colonLabel.textColor = [UIColor colorWithHexRGB:@"#333333" andAlpha:1.0f];
        _colonLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_colonLabel];
    }
    return _colonLabel;
}

- (UILabel *)secLabel {
    
    if (!_secLabel) {
        NSInteger sec = [[[NSUserDefaults standardUserDefaults] objectForKey:lastTime] integerValue]%60;
        _secLabel = [[UILabel alloc] init];
        _secLabel.backgroundColor = [UIColor whiteColor];
        _secLabel.layer.cornerRadius = kSCALE_NUM(5);
        _secLabel.layer.masksToBounds = YES;
        _secLabel.textColor = [UIColor colorWithHexRGB:@"#333333" andAlpha:1.0f];
        _secLabel.text = [NSString stringWithFormat:@"%ld",sec];
        _secLabel.textAlignment = NSTextAlignmentCenter;
        _secLabel.font = kSCALE_FONT_NAME_SIZE(@"DBLCDTempBlack", 21);
        [self addSubview:_secLabel];
    }
    return _secLabel;
}

- (UIButton *)startingBtn {
    
    if (!_startingBtn) {
        _startingBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_startingBtn setTitle:@"开始" forState:(UIControlStateNormal)];
        _startingBtn.titleLabel.font = kSCALE_BOLD_FONT(16);
        [_startingBtn setBackgroundImage:[UIImage imageNamed:@"小节按钮"]
                                forState:(UIControlStateNormal)];
        [_startingBtn setBackgroundImage:[UIImage imageNamed:@"小节按钮-选中"]
                                forState:(UIControlStateHighlighted)];
        [_startingBtn addTarget:self action:@selector(startScoringClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_startingBtn];
    }
    return _startingBtn;
}

- (UIButton *)pauseBtn {
    
    if (!_pauseBtn) {
        _pauseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _pauseBtn.titleLabel.font = kSCALE_BOLD_FONT(16);
        _pauseBtn.enabled = NO;
        [_pauseBtn setTitle:@"暂停" forState:(UIControlStateNormal)];
        [_pauseBtn setBackgroundImage:[UIImage imageNamed:@"小节按钮"]
                                forState:(UIControlStateNormal)];
        [_pauseBtn setBackgroundImage:[UIImage imageNamed:@"小节按钮-选中"]
                                forState:(UIControlStateHighlighted)];
        [_pauseBtn addTarget:self action:@selector(pauseScoringClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_pauseBtn];
    }
    return _pauseBtn;
}

- (void)startScoringClick:(UIButton *)startingBtn {
    
        startingBtn.enabled = NO;
        self.pauseBtn.enabled = YES;
        _isGaming = 1;
        _isPausIng = 1;
        QYToolsMethod *toolsMethod = [[QYToolsMethod alloc] init];
        _toolsMethod = toolsMethod;
    

    
        if (self.delegate && [self.delegate performSelector:@selector(startGame)]) {
            [_delegate startGame];
        }
        
        if (self.delegate && [self.delegate performSelector:@selector(backPauseStatus:)]) {
            [_delegate backPauseStatus:_isPausIng];
        }
        
        
        if (_currentSecond>0) {
            [toolsMethod startGCDTimerWithDuration:self.currentSecond countdownReturnBlock:^(int time) {
                int minutes = time / 60;
                int seconds = time % 60;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    _minLabel.text = [NSString stringWithFormat:@"%02d",minutes];
                    _secLabel.text = [NSString stringWithFormat:@"%02d",seconds];
                    
                    int current = [_minLabel.text intValue] *60 +[_secLabel.text intValue];
                    
                    if (time < StageGameTimes) {
                        
                        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",current] forKey:lastTime];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        
                        if (0 == (StageGameTimes - time)%30) {
                            [self p_updataPlayingTimesOnce];
                            
                        }
                    }
                    
                    
                    if (current ==0) {
                        [_toolsMethod stopGCDTimer];
                        _currentSecond = StageGameTimes;
                        self.startingBtn.enabled = YES;
                        _pauseBtn.enabled = NO;
                        if (self.delegate &&[self.delegate performSelector:@selector(quarterEnd)]) {
                            [_delegate quarterEnd];
                        }
                        
                    }
                    
                });
                
                
            }];
        }
        else{
            
            _currentSecond = StageGameTimes;
            
        }
    
    
}

- (void)pauseScoringClick:(UIButton *)pauseBtn {
    self.startingBtn.enabled = YES;
    pauseBtn.enabled = NO;
    
    _currentSecond = [_minLabel.text intValue] *60 +[_secLabel.text intValue];
    
    [_toolsMethod stopGCDTimer];
    _isPausIng = 0;
    
    if (self.delegate && [self.delegate performSelector:@selector(backPauseStatus:)]) {
        [_delegate backPauseStatus:_isPausIng];
    }
    
}



- (void)setCurrentSecond:(int)currentSecond {
    
    _currentSecond  = [[[NSUserDefaults standardUserDefaults] objectForKey:lastTime] intValue];
}

#pragma mark - 每隔30秒更新一次球员的上场时间
- (void)p_updataPlayingTimesOnce {
    TSDBManager *tSDBManager = [[TSDBManager alloc] init];
    [tSDBManager udatePlayingTimesOnce];
    
}



@end
