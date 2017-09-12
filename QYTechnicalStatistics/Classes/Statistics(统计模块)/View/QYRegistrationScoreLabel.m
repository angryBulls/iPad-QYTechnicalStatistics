//
//  QYRegistrationScoreLabel.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/21.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYRegistrationScoreLabel.h"
#import "UIColor+QYHexRGB.h"
#import "UIView+ScaleFrame.h"

@interface QYRegistrationScoreLabel ()

@property (strong, nonatomic) UILabel * teamLabel;
@property (strong, nonatomic) UILabel * scoreLabel;

@end

@implementation QYRegistrationScoreLabel

+ (instancetype)getRegistrationScoreLabel {
    QYRegistrationScoreLabel * registrationScoreLabel =
    [[QYRegistrationScoreLabel alloc] initWithImage:[UIImage imageNamed:@"总比分背景"]];
    registrationScoreLabel.layer.cornerRadius = 10;
    return registrationScoreLabel;
}

- (UILabel *)teamLabel {
    
    if (!_teamLabel) {
        _teamLabel = [[UILabel alloc] init];
        _teamLabel.textColor = [UIColor colorWithHexRGB:@"1e3d74" andAlpha:1.0f];
        _teamLabel.font = kSCALE_FONT(17);
        _teamLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_teamLabel];
    }
    return _teamLabel;
}

- (UILabel *)scoreLabel {
    
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.textColor = [UIColor colorWithHexRGB:@"#333333" andAlpha:1.0f];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        _scoreLabel.font = kSCALE_BOLD_FONT(31);
        [self addSubview:_scoreLabel];
    }
    return _scoreLabel;
}

- (void)setTeamName:(NSString *)teamName {

    _teamName = teamName;
    self.teamLabel.text = teamName;
}

- (void)setScore:(NSInteger)score {
    
    _score = score;
    NSLog(@"%ld",score);
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", score];
    [self.scoreLabel sizeToFit];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 主队or客队
    [self.teamLabel sizeToFit];
    self.teamLabel.scaleCenterX = CGScaleGetWidth(self.frame)/2;
    self.teamLabel.scaleCenterY = 30+CGScaleGetHeight(self.teamLabel.frame)/2;
    
    // 分数
    [self.scoreLabel sizeToFit];
    self.scoreLabel.scaleH = 48;
    
    self.scoreLabel.scaleCenterX =
    CGScaleGetCenterX(self.teamLabel.frame);
    
    self.scoreLabel.scaleCenterY =
    CGScaleGetMaxY(self.teamLabel.frame)+24+CGScaleGetHeight(self.scoreLabel.frame)/2;
}

@end
