//
//  QYRegistrationCell.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/13.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYRegistrationCell.h"
//#import <UIImageView+WebCache.h>


@interface QYRegistrationCell ()<UITextFieldDelegate>

@property (strong, nonatomic) UIImageView * bjImageView;
@property (strong, nonatomic) UIImageView * playerImageView;
@property (strong, nonatomic) UIButton * revisionBtn;
// 上场按钮
@property (strong, nonatomic) UIButton * enterFieldBtn;
// 比赛号码Label
@property (strong, nonatomic) UILabel * matchLabel;
@property (strong, nonatomic) UILabel * matchNumLabel;
// 修改号码Label
@property (strong, nonatomic) UIButton * modificationButton;
@property (strong, nonatomic) UITextField * modificationNumLabel;
// 背景线View
@property (strong, nonatomic) UIView * lineView_01;
@property (strong, nonatomic) UIView * lineView_02;
@property (strong, nonatomic) UIView * lineView_03;

@end

@implementation QYRegistrationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.revisionBtn.titleLabel.numberOfLines = 0;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self.bjImageView scaleFrameMake:0 :0 :300 :226];
        [self.enterFieldBtn scaleFrameMake:0 :CGScaleGetMaxY(self.bjImageView.frame)+10 :300 :50];
        [self.playerImageView scaleFrameMake:0 :0 :158 :226];
        [self.lineView_01 scaleFrameMake:CGScaleGetMaxX(self.playerImageView.frame)
                                        :CGScaleGetHeight(self.bjImageView.frame)/2
                                        :CGScaleGetWidth(self.bjImageView.frame)/2
                                        :2];
        [self.lineView_02 scaleFrameMake:74+CGScaleGetMaxX(self.playerImageView.frame)
                                        :31
                                        :2
                                        :50];
        [self.lineView_03 scaleFrameMake:CGScaleGetMinX(self.lineView_02.frame)
                                        :62+CGScaleGetMaxY(self.lineView_02.frame)
                                        :2
                                        :50];
        [self.matchNumLabel scaleFrameMake:CGScaleGetMaxX(self.playerImageView.frame)+22
                                          :34
                                          :74-22
                                          :113-38-34];
        [self.modificationNumLabel scaleFrameMake:CGScaleGetMinX(self.matchNumLabel.frame)
                                                 :CGScaleGetMaxY(self.lineView_01.frame)+34
                                                 :CGScaleGetWidth(self.matchNumLabel.frame)
                                                 :CGScaleGetHeight(self.matchNumLabel.frame)];
        
        [self.matchLabel scaleFrameMake:7+CGScaleGetMinX(self.lineView_02.frame)
                                       :30
                                       :66-14
                                       :113-60];
        [self.modificationButton scaleFrameMake:CGScaleGetMinX(self.matchLabel.frame)
                                               :30+CGScaleGetMaxY(self.lineView_01.frame)
                                               :CGScaleGetWidth(self.matchLabel.frame)
                                               :CGScaleGetHeight(self.matchLabel.frame)];
        

        
    }
    return self;
}


-(void)setP:(TSPlayerModel *)p{
    _p = p;
    [_playerImageView sd_setImageWithURL:[NSURL URLWithString:p.photo] placeholderImage:[UIImage imageNamed:@"测试球员图片01"] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
    }];
    self.enterFieldBtn.selected = [p.isStartPlayer isEqualToString:@"是"];
    
    _matchNumLabel.text = p.playerNumber;
    
    _modificationNumLabel.text = p.gameNum;
    
    
}


// 点击选手上场
- (void)enterFieldClick:(UIButton *)nterFieldBtn {
    
    self.enterFieldBtn.selected = !self.enterFieldBtn.selected;
    _p.isStartPlayer =  self.enterFieldBtn.selected?@"是":@"否";
    _p.playingStatus = self.enterFieldBtn.selected?@"1":@"0";
    
        if (self.delegate && [_delegate respondsToSelector:@selector(BackPlayerWithPlayer:andSection:andRow:)]) {
            [_delegate BackPlayerWithPlayer:_p andSection:_section andRow:_row];
        
    }
}


#pragma mark - lazy

- (UIImageView *)bjImageView {
    
    if (!_bjImageView) {
        _bjImageView = [[UIImageView alloc]
                        initWithImage:[UIImage imageNamed:@"人员检录2_03"]];
        _bjImageView.userInteractionEnabled = YES;
        _bjImageView.layer.masksToBounds = YES;
        [self addSubview:_bjImageView];
    }
    return _bjImageView;
}

- (UIButton *)enterFieldBtn {
    
    if (!_enterFieldBtn) {
        
        _enterFieldBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _enterFieldBtn.titleLabel.font = kSCALE_FONT(15);
        [_enterFieldBtn setBackgroundImage:[UIImage imageNamed:@"人员检录2_08"]
                                  forState:(UIControlStateNormal)];
        [_enterFieldBtn setTitleColor:[UIColor colorWithHexRGB:@"#505050" andAlpha:1.0f]
                             forState:(UIControlStateNormal)];
        [_enterFieldBtn setTitle:@"上场" forState:(UIControlStateNormal)];
        [_enterFieldBtn addTarget:self action:@selector(enterFieldClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [_enterFieldBtn setBackgroundImage:[UIImage imageNamed:@"人员检录2_06"] forState:(UIControlStateSelected)];
        [_enterFieldBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
        [_enterFieldBtn setTitle:@"下场" forState:(UIControlStateSelected)];
        [self addSubview:_enterFieldBtn];
    }
    return _enterFieldBtn;
}

- (UIImageView *)playerImageView {
    
    if (!_playerImageView) {
        _playerImageView = [[UIImageView alloc] init];
        _playerImageView.layer.cornerRadius = kSCALE_NUM(5);
        _playerImageView.layer.masksToBounds = YES;
        [self.bjImageView addSubview:_playerImageView];
    }
    return _playerImageView;
}

- (UIView *)lineView_01 {
    
    if (!_lineView_01) {
        _lineView_01 = [[UIView alloc] init];
        _lineView_01.backgroundColor = [UIColor colorWithHexRGB:@"#E5E5E5" andAlpha:1.0f];
        [self.bjImageView addSubview:_lineView_01];
    }
    return _lineView_01;
}

- (UIView *)lineView_02 {
    
    if (!_lineView_02) {
        _lineView_02 = [[UIView alloc] init];
        _lineView_02.backgroundColor = [UIColor colorWithHexRGB:@"#E5E5E5" andAlpha:1.0f];
        [self.bjImageView addSubview:_lineView_02];
    }
    return _lineView_02;
}

- (UIView *)lineView_03 {
    
    if (!_lineView_03) {
        _lineView_03 = [[UIView alloc] init];
        _lineView_03.backgroundColor = [UIColor colorWithHexRGB:@"#E5E5E5" andAlpha:1.0f];
        [self.bjImageView addSubview:_lineView_03];
    }
    return _lineView_03;
}

- (UILabel *)matchLabel {
    
    if (!_matchLabel) {
        
        _matchLabel = [[UILabel alloc] init];
        _matchLabel.textColor = [UIColor colorWithHexRGB:@"#333333" andAlpha:1.0f];
        _matchLabel.font = kSCALE_FONT(11);
        _matchLabel.text = @"比赛号码";
        _matchLabel.numberOfLines = 0;
        [self.bjImageView addSubview:_matchLabel];
    }
    return _matchLabel;
}

- (UIButton *)modificationButton {
    
    if (!_modificationButton) {
        
        _modificationButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _modificationButton.titleLabel.font = kSCALE_FONT(11);
        [_modificationButton setTitle:@"修改号码" forState:(UIControlStateNormal)];
        [_modificationButton setTitleColor:[UIColor colorWithHexRGB:@"#2c59a8" andAlpha:1.0f]
                                  forState:(UIControlStateNormal)];
        _modificationButton.titleLabel.numberOfLines = 0;
        [_modificationButton addTarget:self action:@selector(changeNumber) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bjImageView addSubview:_modificationButton];
    }
    return _modificationButton;
}

- (UILabel *)matchNumLabel {
    
    if (!_matchNumLabel) {
        
        _matchNumLabel = [[UILabel alloc] init];
        _matchNumLabel.textColor = [UIColor colorWithHexRGB:@"#333333" andAlpha:1.0f];
        _matchNumLabel.font = kSCALE_FONT(20);
        
        _matchNumLabel.font = [UIFont systemFontOfSize:scaleX_ByPx(44)];
        [self.bjImageView addSubview:_matchNumLabel];
    }
    return _matchNumLabel;
}

- (UITextField *)modificationNumLabel {
    
    if (!_modificationNumLabel) {
        
        _modificationNumLabel = [[UITextField alloc] init];
        _modificationNumLabel.textColor = [UIColor colorWithHexRGB:@"#333333" andAlpha:1.0f];
//        _modificationNumLabel.text = @"4";
        _modificationNumLabel.font = kSCALE_FONT(20);
        _modificationNumLabel.keyboardType = UIKeyboardTypeNumberPad;
        [self.bjImageView addSubview:_modificationNumLabel];
        _modificationNumLabel.delegate = self;
    }
    return _modificationNumLabel;
}

-(void)changeNumber{
    

    _matchNumLabel.text = _modificationNumLabel.text;
    _p.gameNum = _matchNumLabel.text;
    _p.playerNumber = _matchNumLabel.text;
    
    
    
    if (self.delegate && [_delegate respondsToSelector:@selector(BackPlayerWithPlayer:andSection:andRow:)]) {
        
        [_delegate BackPlayerWithPlayer:_p andSection:_section andRow:_row];
        
    }

    
}






@end
