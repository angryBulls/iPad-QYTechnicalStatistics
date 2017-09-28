//
//  QYTeamOperationView.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/23.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYTeamOperationView.h"

@interface QYTeamOperationView ()

@property (strong, nonatomic) UIImageView * teamImageView;
@property (nonatomic, copy) NSString * titleImg;
@property (strong, nonatomic) UILabel * foulLabel;

@property (strong, nonatomic) UIImageView * foulScoreBjImg;
@property (strong, nonatomic) UILabel * foulTimeLabel;
@property (strong, nonatomic) UILabel * pauseLabel;


@property (strong, nonatomic) UIImageView * pauseScoreBjImg;
@property (nonatomic ,strong)TSDBManager *tsDBManager;
@end

@implementation QYTeamOperationView

+ (instancetype)createTeamOperationViewWithTitleImg:(NSString *)titleImg {
    
    QYTeamOperationView * teamOperationView = [[QYTeamOperationView alloc] init];
    teamOperationView.titleImg = titleImg;
    return teamOperationView;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self integratedLayout];
}

- (void)integratedLayout {
    
    // px为基准
    [self.teamImageView scaleFrameMake:26 :32 :160-26 :66];
    
    self.foulLabel.scaleX = CGScaleGetMaxX(self.teamImageView.frame)+12;
    self.foulLabel.scaleY = 54;
    [self.foulLabel sizeToFit];
    
    [self.foulScoreLabel scaleCenterBoundsMake:10+28+CGScaleGetMaxX(self.foulLabel.frame) :CGScaleGetCenterY(self.foulLabel.frame) :56 :46];
    [self.foulScoreBjImg scaleCenterBoundsMake:10+28+CGScaleGetMaxX(self.foulLabel.frame) :CGScaleGetCenterY(self.foulLabel.frame) :56 :46];
    
    self.foulTimeLabel.scaleX = CGScaleGetMaxX(self.foulScoreLabel.frame)+10;
    self.foulTimeLabel.scaleY = CGScaleGetMinY(self.foulLabel.frame);
    [self.foulTimeLabel sizeToFit];
    
    self.pauseLabel.scaleX = CGScaleGetMaxX(self.foulTimeLabel.frame)+24;
    self.pauseLabel.scaleY = CGScaleGetMinY(self.foulLabel.frame);
    [self.pauseLabel sizeToFit];
    
    [self.pauseAddBnt scaleCenterBoundsMake:CGScaleGetMaxX(self.pauseLabel.frame)+16+32
                                           :CGScaleGetCenterY(self.pauseLabel.frame)
                                           :64
                                           :64];
    [self.pauseAddBnt addTarget:self action:@selector(pauseAddBntClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.pauseScoreLabel scaleCenterBoundsMake:CGScaleGetMaxX(self.pauseAddBnt.frame)+16+CGScaleGetWidth(self.foulScoreLabel.frame)/2
                                               :CGScaleGetCenterY(self.foulScoreLabel.frame)
                                               :CGScaleGetWidth(self.foulScoreLabel.frame)
                                               :CGScaleGetHeight(self.foulScoreLabel.frame)];
    [self.pauseScoreBjImg scaleCenterBoundsMake:CGScaleGetMaxX(self.pauseAddBnt.frame)+16+CGScaleGetWidth(self.foulScoreLabel.frame)/2

                                               :CGScaleGetCenterY(self.foulScoreLabel.frame)
                                               :CGScaleGetWidth(self.foulScoreLabel.frame)
                                               :CGScaleGetHeight(self.foulScoreLabel.frame)];
    [self.pauseTimeLabel scaleCenterBoundsMake:CGScaleGetMaxX(self.pauseScoreBjImg.frame)+10+CGScaleGetWidth(self.foulTimeLabel.frame)/2
                                              :CGScaleGetCenterY(self.foulTimeLabel.frame)
                                              :CGScaleGetWidth(self.foulTimeLabel.frame)
                                              :CGScaleGetHeight(self.foulTimeLabel.frame)];
    
}


-(void)setGameModel:(TSGameModel *)gameModel{
    _gameModel = gameModel;
    if (_isGuest) {
        _pauseScoreLabel.text = gameModel.timeOutStageG;
        _foulScoreLabel.text = gameModel.foulsStageG;
        
    }
    else{
        
        _pauseScoreLabel.text = gameModel.timeOutStageH;
        _foulScoreLabel.text = gameModel.foulsStageH;
        
    }
    
}


#pragma mark - lazy

-(TSDBManager *)tsDBManager{
    if (_tsDBManager == nil) {
        _tsDBManager = [[TSDBManager alloc] init];
    }
    return _tsDBManager;
}

- (UIImageView *)teamImageView {
    
    if (!_teamImageView) {
        _teamImageView = [[UIImageView alloc] init];
        _teamImageView.image = [UIImage imageNamed:_titleImg];
        _teamImageView.layer.cornerRadius = 5;
        _teamImageView.layer.masksToBounds = YES;
        [self addSubview:_teamImageView];
    }
    return _teamImageView;
}

- (UILabel *)foulLabel {
    
    if (!_foulLabel) {
        _foulLabel = [[UILabel alloc] init];
        _foulLabel.text = @"犯规";
        _foulLabel.textColor = [UIColor colorWithHexRGB:@"#333333" andAlpha:1.0f];
        _foulLabel.textAlignment = NSTextAlignmentCenter;
        _foulLabel.font = kSCALE_FONT(16);
        [self addSubview:_foulLabel];
    }
    return _foulLabel;
}

- (UILabel *)foulTimeLabel {
    
    if (!_foulTimeLabel) {
        _foulTimeLabel = [[UILabel alloc] init];
        _foulTimeLabel.text = @"次";
        _foulTimeLabel.textColor = [UIColor colorWithHexRGB:@"#333333" andAlpha:1.0f];
        _foulTimeLabel.textAlignment = NSTextAlignmentCenter;
        _foulTimeLabel.font = kSCALE_FONT(16);
        [self addSubview:_foulTimeLabel];
    }
    return _foulTimeLabel;
}

- (UILabel *)pauseLabel {
    
    if (!_pauseLabel) {
        _pauseLabel = [[UILabel alloc] init];
        _pauseLabel.text = @"暂停";
        _pauseLabel.textColor = [UIColor colorWithHexRGB:@"#333333" andAlpha:1.0f];
        _pauseLabel.textAlignment = NSTextAlignmentCenter;
        _pauseLabel.font = kSCALE_FONT(16);
        [self addSubview:_pauseLabel];
    }
    
    return _pauseLabel;
}

- (UILabel *)foulScoreLabel {
    
    if (!_foulScoreLabel) {
        
        // 先创建背景图片
        self.foulScoreBjImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"底框"]];
        _foulScoreLabel = [[UILabel alloc] init];
        _foulScoreLabel.textAlignment = NSTextAlignmentCenter;
        
        _foulScoreLabel.font = kSCALE_FONT(23);
        [self addSubview:_foulScoreBjImg];
        [self addSubview:_foulScoreLabel];
    }
    return _foulScoreLabel;
}

- (UILabel *)pauseScoreLabel {
    
    if (!_pauseScoreLabel) {
        
        // 先创建背景图片
        self.pauseScoreBjImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"底框"]];
        
        _pauseScoreLabel = [[UILabel alloc] init];
        _pauseScoreLabel.textAlignment = NSTextAlignmentCenter;
        _pauseScoreLabel.font = kSCALE_FONT(23);
        [self addSubview:_pauseScoreBjImg];
        [self addSubview:_pauseScoreLabel];
    }
    return _pauseScoreLabel;
}

- (UILabel *)pauseTimeLabel {
    
    if (!_pauseTimeLabel) {
        _pauseTimeLabel = [[UILabel alloc] init];
        _pauseTimeLabel.text = @"次";
        _pauseTimeLabel.textColor = [UIColor colorWithHexRGB:@"#333333" andAlpha:1.0f];
        _pauseTimeLabel.textAlignment = NSTextAlignmentCenter;
        _pauseTimeLabel.font = kSCALE_FONT(16);
        [self addSubview:_pauseTimeLabel];
    }
    return _pauseTimeLabel;
}

- (UIButton *)pauseAddBnt {
    
    if (!_pauseAddBnt) {
        _pauseAddBnt = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_pauseAddBnt setBackgroundImage:[UIImage imageNamed:@"加"]
                                forState:(UIControlStateNormal)];
        [_pauseAddBnt setBackgroundImage:[UIImage imageNamed:@"加-选中"]
                                forState:(UIControlStateHighlighted)];
        [self addSubview:_pauseAddBnt];
    }
    
    return _pauseAddBnt;
}


-(void)pauseAddBntClicked:(UIButton *)btn {
   
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    resultDic[BnfBehaviorType] =@"0";
    
    resultDic[BnfTeameType] = [NSString stringWithFormat:@"%d",_isGuest];
    if (self.delegate && [self.delegate respondsToSelector:@selector(backResultDic:andStatus:)]) {
        [_delegate backResultDic:resultDic andStatus:1];
    }
    
}

@end
