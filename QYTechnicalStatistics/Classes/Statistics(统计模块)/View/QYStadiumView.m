//
//  QYStadiumView.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/28.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYStadiumView.h"
#import "QYPlayerView.h"

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
    
    [self.hostPlayer_One show];
    [self.hostPlayer_Two show];
    [self.hostPlayer_Three show];
    [self.hostPlayer_Four show];
    [self.hostPlayer_Five show];
    
    [self.guestPlayer_One show];
    [self.guestPlayer_Two show];
    [self.guestPlayer_Three show];
    [self.guestPlayer_Four show];
    [self.guestPlayer_Five show];
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
        [self addSubview:_returnBtn];
    }
    return _returnBtn;
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
        
        Player *p = _hostDataSouce[0];
        p.team = Host;
        _hostPlayer_One = [QYPlayerView createPlayerViewWithTitle:[NSString stringWithFormat:@"%@",p.playerNumber] bgImage:@"红-主队" frameX:160 frameY:98];
        
        _hostPlayer_One.p = p;
        _hostPlayer_One.delegate = self;
        
        [self addSubview:_hostPlayer_One];
    }
    return _hostPlayer_One;
}

- (QYPlayerView *)hostPlayer_Two {
    
    if (!_hostPlayer_Two) {
        Player *p = _hostDataSouce[1];
        p.team = Host;

        _hostPlayer_Two = [QYPlayerView createPlayerViewWithTitle:[NSString stringWithFormat:@"%@",p.playerNumber] bgImage:@"红-主队" frameX:286 frameY:458];
                _hostPlayer_Two.p = p;
        _hostPlayer_Two.delegate = self;
        [self addSubview:_hostPlayer_Two];
    }
    return _hostPlayer_Two;
}

- (QYPlayerView *)hostPlayer_Three {
    
    if (!_hostPlayer_Three) {
        
        Player *p = _hostDataSouce[2];
        p.team = Host;
        _hostPlayer_Three = [QYPlayerView createPlayerViewWithTitle:[NSString stringWithFormat:@"%@",p.playerNumber] bgImage:@"红-主队" frameX:184 frameY:1130-112-218];
        
        _hostPlayer_Three.p = p;
        _hostPlayer_Three.delegate = self;
        
        [self addSubview:_hostPlayer_Three];
    }
    return _hostPlayer_Three;
}

- (QYPlayerView *)hostPlayer_Four {
    
    if (!_hostPlayer_Four) {
        
        Player *p = _hostDataSouce[3];
        p.team = Host;
        _hostPlayer_Four = [QYPlayerView createPlayerViewWithTitle:[NSString stringWithFormat:@"%@",p.playerNumber] bgImage:@"红-主队" frameX:632 frameY:284];
        
        
        _hostPlayer_Four.p = p;
        
        _hostPlayer_Four.delegate = self;
        [self addSubview:_hostPlayer_Four];
    }
    return _hostPlayer_Four;
}

- (QYPlayerView *)hostPlayer_Five {
    
    if (!_hostPlayer_Five) {
        Player *p = _hostDataSouce[4];
        p.team = Host;
        _hostPlayer_Five = [QYPlayerView createPlayerViewWithTitle:[NSString stringWithFormat:@"%@",p.playerNumber] bgImage:@"红-主队" frameX:626 frameY:158+284+218];
        
        
        _hostPlayer_Five.p = p;
        _hostPlayer_Five.delegate = self;
        [self addSubview:_hostPlayer_Five];
    }
    return _hostPlayer_Five;
}

- (QYPlayerView *)guestPlayer_One {
    
    if (!_guestPlayer_One) {
        Player *p = _guestDataSouce[0];
        p.team = Guest;
        _guestPlayer_One = [QYPlayerView createPlayerViewWithTitle:[NSString stringWithFormat:@"%@",p.playerNumber] bgImage:@"绿-客队" frameX:2048-218-154 frameY:94];
        
        _guestPlayer_One.p = p;
        _guestPlayer_One.delegate  = self;
        
        
        [self addSubview:_guestPlayer_One];
    }
    return _guestPlayer_One;
}

- (QYPlayerView *)guestPlayer_Two {
    
    if (!_guestPlayer_Two) {
        Player *p = _guestDataSouce[1];
        p.team = Guest;
        _guestPlayer_Two = [QYPlayerView createPlayerViewWithTitle:[NSString stringWithFormat:@"%@",p.playerNumber] bgImage:@"绿-客队" frameX:2048-218-286 frameY:464];
        
        _guestPlayer_Two.p = p;
        _guestPlayer_Two.delegate = self;
        [self addSubview:_guestPlayer_Two];
    }
    return _guestPlayer_Two;
}

- (QYPlayerView *)guestPlayer_Three {
    
    if (!_guestPlayer_Three) {
        Player *p = _guestDataSouce[2];
        p.team = Guest;
        _guestPlayer_Three = [QYPlayerView createPlayerViewWithTitle:[NSString stringWithFormat:@"%@",p.playerNumber] bgImage:@"绿-客队" frameX:2048-218-154 frameY:1130-218-100];
        
        _guestPlayer_Three.p = p;
        _guestPlayer_Three.delegate = self;
        
        [self addSubview:_guestPlayer_Three];
    }
    return _guestPlayer_Three;
}

- (QYPlayerView *)guestPlayer_Four {
    
    if (!_guestPlayer_Four) {
        Player *p = _guestDataSouce[3];
        p.team = Guest;
        _guestPlayer_Four = [QYPlayerView createPlayerViewWithTitle:[NSString stringWithFormat:@"%@",p.playerNumber] bgImage:@"绿-客队" frameX:2048-218-638 frameY:270];
        
        
        _guestPlayer_Four.p = p;
        _guestPlayer_Four.delegate  = self;
        [self addSubview:_guestPlayer_Four];
    }
    return _guestPlayer_Four;
}

- (QYPlayerView *)guestPlayer_Five {
    
    if (!_guestPlayer_Five) {
        Player *p = _guestDataSouce[4];
        p.team = Guest;
        
        _guestPlayer_Five = [QYPlayerView createPlayerViewWithTitle:[NSString stringWithFormat:@"%@",p.playerNumber] bgImage:@"绿-客队" frameX:2048-218-640 frameY:270+162+218];
        
        
        _guestPlayer_Five.p = p;
        _guestPlayer_Five.delegate = self;
        [self addSubview:_guestPlayer_Five];
    }
    return _guestPlayer_Five;
}

#pragma mark 代理
-(void)backPlay:(Player *)p andStatus:(NSInteger)status{
    
    [_delegate backStatusWithPlayer:p Status:status];
    
}


@end
