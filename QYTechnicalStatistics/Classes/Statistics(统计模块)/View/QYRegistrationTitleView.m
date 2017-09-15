//
//  QYRegistrationTitleView.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/21.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYRegistrationTitleView.h"
#import "UIColor+QYHexRGB.h"
#import "UIView+ScaleFrame.h"


@interface QYRegistrationTitleView ()

@property (strong, nonatomic) UIImageView * bjView;
@property (nonatomic, strong) UILabel * totalScoreLabel;

@property (nonatomic, strong) UILabel * sectionScoreLabel;

@property (nonatomic, strong) UILabel * totalColonLabel;
@property (nonatomic, strong) UILabel * sectionColonLabel;

@end

@implementation QYRegistrationTitleView

+ (instancetype)createRegistrationTitleView {
    
    QYRegistrationTitleView * registrationTitleView = [[QYRegistrationTitleView alloc] init];
    return registrationTitleView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self integratedLayout];
}

// 界面布局 px为基准
- (void)integratedLayout {
    
    // px为单位
    [self.bjView scaleFrameMake:0 :0 :CGScaleGetWidth(self.frame) :CGScaleGetHeight(self.frame)];
    [self.totalScoreLabel scaleFrameMake:110 :126 :125 :50];
    [self.totalScoreLabel sizeToFit];
    
    [self.totalHostTeamLabel scaleFrameMake:265 :62 :306 :174];
    [self.totalGuestTeamLabel scaleFrameMake:CGScaleGetMaxX(self.totalHostTeamLabel.frame) + 56
                                            :self.totalHostTeamLabel.scaleY
                                            :self.totalHostTeamLabel.scaleW
                                            :self.totalHostTeamLabel.scaleH];
    [self.sectionScoreLabel scaleFrameMake:CGScaleGetMaxX(self.totalGuestTeamLabel.frame) + 140
                                          :self.totalScoreLabel.scaleY
                                          :self.totalScoreLabel.scaleW/2.0*3
                                          :self.totalScoreLabel.scaleH];
    [self.hostTeamScoreLabel scaleFrameMake:CGScaleGetMaxX(self.sectionScoreLabel.frame) + 30
                                           :self.totalHostTeamLabel.scaleY
                                           :self.totalHostTeamLabel.scaleW
                                           :self.totalHostTeamLabel.scaleH];
    [self.guestTeamScoreLabel scaleFrameMake:CGScaleGetMaxX(self.hostTeamScoreLabel.frame) + 56
                                            :self.totalHostTeamLabel.scaleY
                                            :self.totalHostTeamLabel.scaleW
                                            :self.totalHostTeamLabel.scaleH];
}

#pragma mark - lazy

- (UIImageView *)bjView {
    
    if (!_bjView) {
        _bjView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"头部背景"]];
        [self addSubview:_bjView];
    }
    return _bjView;
}

- (UILabel *)totalScoreLabel {
    
    if (!_totalScoreLabel) {
        _totalScoreLabel = [[UILabel alloc] init];
        _totalScoreLabel.text = @"总比分";
        _totalScoreLabel.textAlignment = NSTextAlignmentCenter;
        _totalScoreLabel.font = kSCALE_BOLD_FONT(21);
        _totalScoreLabel.textColor = [UIColor colorWithHexRGB:@"#FFFFFF" andAlpha:1.0f];
        [self addSubview:_totalScoreLabel];
    }
    return _totalScoreLabel;
}

- (QYRegistrationScoreLabel *)totalHostTeamLabel {
    
    if (!_totalHostTeamLabel) {
        _totalHostTeamLabel = [QYRegistrationScoreLabel getRegistrationScoreLabel];
        _totalHostTeamLabel.teamName = @"主队";
        _totalHostTeamLabel.score = 0;
        [self addSubview:_totalHostTeamLabel];
    }
    return _totalHostTeamLabel;
}

- (QYRegistrationScoreLabel *)totalGuestTeamLabel {
    
    if (!_totalGuestTeamLabel) {
        _totalGuestTeamLabel = [QYRegistrationScoreLabel getRegistrationScoreLabel];
        _totalGuestTeamLabel.teamName = @"客队";
        _totalGuestTeamLabel.score = 0;
        [self addSubview:_totalGuestTeamLabel];
    }
    return _totalGuestTeamLabel;
}

- (UILabel *)sectionScoreLabel {
    
    if (!_sectionScoreLabel) {
        _sectionScoreLabel = [[UILabel alloc] init];
        _sectionScoreLabel.text = @"第一小节";
        _sectionScoreLabel.textAlignment = NSTextAlignmentCenter;
        _sectionScoreLabel.font = kSCALE_BOLD_FONT(21);
        _sectionColonLabel.backgroundColor = [UIColor redColor];
        _sectionScoreLabel.textColor = [UIColor colorWithHexRGB:@"#FFFFFF" andAlpha:1.0f];
        [self addSubview:_sectionScoreLabel];
    }
    return _sectionScoreLabel;
}

- (QYRegistrationScoreLabel *)hostTeamScoreLabel {
    
    if (!_hostTeamScoreLabel) {
        _hostTeamScoreLabel = [QYRegistrationScoreLabel getRegistrationScoreLabel];
        _hostTeamScoreLabel.teamName = @"主队";
        _hostTeamScoreLabel.score = 00;
        [self addSubview:_hostTeamScoreLabel];
    }
    return _hostTeamScoreLabel;
}

- (QYRegistrationScoreLabel *)guestTeamScoreLabel {
    
    if (!_guestTeamScoreLabel) {
        _guestTeamScoreLabel = [QYRegistrationScoreLabel getRegistrationScoreLabel];
        _guestTeamScoreLabel.teamName = @"客队";
        _guestTeamScoreLabel.score = 00;
        [self addSubview:_guestTeamScoreLabel];
    }
    return _guestTeamScoreLabel;
}

- (UILabel *)totalColonLabel {
    
    if (!_totalColonLabel) {
        
        _totalColonLabel = [[UILabel alloc] init];
        _totalColonLabel.text = @":";
        _totalColonLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:28];
        _totalColonLabel.textColor = [UIColor colorWithHexRGB:@"#ffffff" andAlpha:1.0f];
        _totalColonLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_totalColonLabel];
    }
    return _totalColonLabel;
}

-(void)setGameModel:(TSGameModel *)gameModel{
    _gameModel = gameModel;
    _totalHostTeamLabel.score = [gameModel.scoreTotalH integerValue];
    _totalGuestTeamLabel.score = [gameModel.scoreStageG integerValue];
    _hostTeamScoreLabel.score = [gameModel.scoreStageH integerValue];
    _guestTeamScoreLabel.score = [gameModel.scoreStageG integerValue];
    
    
}



@end
