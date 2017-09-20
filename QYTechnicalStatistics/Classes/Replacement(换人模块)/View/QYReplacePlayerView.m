//
//  QYReplacePlayerView.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/7/11.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYReplacePlayerView.h"

@interface QYReplacePlayerView ()

// 选中遮盖
@property (strong, nonatomic) UIView * coverView;
// 球员头像
@property (strong, nonatomic) UIImageView * iconView;

@property (nonatomic ,strong) UIView *infoView;
// 姓名Label
@property (strong, nonatomic) UILabel * nameLabel;
// 号码
@property (nonatomic ,strong) UILabel * numLabel;




@end

@implementation QYReplacePlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 添加手势
        UITapGestureRecognizer * tapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress)];
        
        [self addGestureRecognizer:tapGestureRecognizer];
        
    }
    return self;
}

- (void)tapPress {
    
    self.coverView.backgroundColor = [UIColor colorWithHexRGB:@"#000000" andAlpha:0.3f];
    
    if ([self.delegate respondsToSelector:@selector(tapReplacePlayerView:andQYreplaceModel:)]) {
        [self.delegate tapReplacePlayerView:self andQYreplaceModel:self.playModel];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 设置球员icon尺寸
    [self.iconView scaleFrameMake:0 :0 :CGScaleGetWidth(self.frame) :226];
    
    // 设置球员信息尺寸
    
    [self.infoView scaleFrameMake:0 :226-50 :CGScaleGetWidth(self.frame) :50];
    // 号码
    [self.numLabel scaleFrameMake:16 :11 :30 :30];
    
    // 名字
    [self.nameLabel scaleFrameMake:52 :11 :CGScaleGetWidth(self.frame)-52 :30];
    
    // 设置上下场标识按钮尺寸
    [self.switchoverBtn scaleFrameMake:0
                                      :CGScaleGetMaxY(self.iconView.frame)+10
                                      :CGScaleGetWidth(self.frame)
                                      :50];
    
    // 设置遮盖尺寸
    self.coverView.frame = self.bounds;
}


-(void)setPlayModel:(TSPlayerModel *)playModel{
    _playModel = playModel;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:playModel.photo] completed:nil];
    
    self.nameLabel.text = playModel.name;
    self.numLabel.text = playModel.gameNum;
    
    self.switchoverBtn.selected = [playModel.playingStatus boolValue];
    
}


// 移除遮盖
- (void)removeCoverView {
    
    _coverView.backgroundColor = [UIColor colorWithHexRGB:@"#000000" andAlpha:0.0f];
}

- (void)setIsHost:(BOOL)isHost {
    
    _isHost = isHost;
    

}

#pragma mark - lazy

- (UIView *)coverView {
    
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor colorWithHexRGB:@"#000000" andAlpha:0.0f];
        _coverView.layer.cornerRadius = kSCALE_NUM(5);
        [self addSubview:_coverView];
    }
    return _coverView;
}

- (UIImageView *)iconView {
    
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"测试球员图片01"]]; // 后期改为SDWeb加载
        _iconView.layer.cornerRadius = kSCALE_NUM(5);
        _iconView.layer.masksToBounds = YES;
        [self addSubview:_iconView];
    }
    return _iconView;
}

-(UIView *)infoView{
    if (_infoView == nil) {
        _infoView = [[UIView alloc] init ];
        [self.iconView addSubview:_infoView];
        _infoView.backgroundColor = [UIColor blackColor];
        _infoView.alpha = .65;
    }
    
    return _infoView;
}

-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:scaleX_ByPx(24)];
        
        [self.infoView addSubview:_nameLabel];
    }
    
    return _nameLabel;
}

-(UILabel *)numLabel{
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.layer.cornerRadius = scaleX_ByPx(15);
        _numLabel.clipsToBounds = YES;
        _numLabel.layer.borderWidth = scaleX_ByPx(1);
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.font  = [UIFont systemFontOfSize:scaleX_ByPx(24)];
        _numLabel.layer.borderColor = [UIColor colorWithHexRGB:@"#FFFFFF" andAlpha:1].CGColor;
        _numLabel.backgroundColor = [UIColor clearColor];
        _numLabel.textColor  = [UIColor whiteColor];
        
        [self.infoView addSubview:_numLabel];
    }
    
    return _numLabel;
}

- (UIButton *)switchoverBtn {
    
    if (!_switchoverBtn) {
        
        _switchoverBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_switchoverBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形28副本10"]
                                  forState:(UIControlStateNormal)];
        [_switchoverBtn setTitle:@"上场" forState:(UIControlStateNormal)];
        [_switchoverBtn setTitleColor:[UIColor colorWithHexRGB:@"#505050" andAlpha:1.0f]
                             forState:(UIControlStateNormal)];
        [_switchoverBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形28副本6"]
                                  forState:(UIControlStateSelected)];
        [_switchoverBtn setTitle:@"下场" forState:(UIControlStateSelected)];
        [_switchoverBtn setTitleColor:[UIColor colorWithHexRGB:@"#3f85ff" andAlpha:1.0f]
                             forState:(UIControlStateSelected)];
        [self addSubview:_switchoverBtn];
    }
    return _switchoverBtn;
}

@end
