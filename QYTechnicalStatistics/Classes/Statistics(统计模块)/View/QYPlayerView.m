//
//  QYPlayerView.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2019/6/29.
//  Copyright © 2019年 qiuyouquan. All rights reserved.
//

#import "QYPlayerView.h"

@interface QYPlayerView ()

// 背景遮盖
@property (weak, nonatomic) UIView * coverView;
// 球员操作选项titles
@property (strong, nonatomic) NSArray * operationOptionTitles;
// 球员按钮
@property (strong, nonatomic) UIButton * playerBtn;
// 初始位置 单位PX
@property (assign, nonatomic) CGRect initialFrame;
// 球员技术统计操作按钮组
@property (strong, nonatomic) NSMutableArray * palyerStatisticsBtns;

@property (nonatomic, assign) NSInteger scroes;

@end

@implementation QYPlayerView

- (void)show {/** 目的调用懒加载··· */}

+ (instancetype)createPlayerViewWithImage:(NSString *)image
                                  bgImage:(NSString *)bjImage
                                   frameX:(CGFloat)frameX
                                   frameY:(CGFloat)frameY {
    
    
    QYPlayerView * playerView = [[QYPlayerView alloc] init];
    playerView.initialFrame = CGRectMake(frameX, frameY, 218, 218);
    [playerView setPlayerButton:playerView.playerBtn withImage:image backgroundImage:bjImage];
    playerView.scaleW = 218;
    playerView.scaleH = 218;
    playerView.scaleX = frameX;
    playerView.scaleY = frameY;
    return playerView;
}
-(void)setP:(Player *)p{
    _p = p;
    
}

// 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        // 创建球员系统统计按钮
        for (NSInteger count = 0; count < 9; count++) {
            
            UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            btn.titleLabel.font = kSCALE_BOLD_FONT(32);
            [btn setTitleColor:[UIColor colorWithHexRGB:@"#333333" andAlpha:1.0f] forState:(UIControlStateNormal)];
            [btn setBackgroundImage:[UIImage imageNamed:@"RO_Btn_bjImage"]
                           forState:(UIControlStateNormal)];
            [btn scaleCenterBoundsMake:218/2 :218/2 :0 :0];
            btn.layer.cornerRadius = scaleW_ByPx(204/2);
            [btn setTitle:self.operationOptionTitles[count] forState:(UIControlStateNormal)];
            btn.tag = count;
            [btn addTarget: self action:@selector(fucationBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [self.palyerStatisticsBtns addObject:btn];
            
        }
        
        
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.playerBtn.scaleCenterX = CGScaleGetWidth(self.frame)/2;
    self.playerBtn.scaleCenterY = CGScaleGetHeight(self.frame)/2;
}

- (void)setPlayerButton:(UIButton *)playerBtn
              withImage:(NSString *)image
        backgroundImage:(NSString *)backgroundImage {
    
    [playerBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    
    [playerBtn setBackgroundImage:[UIImage imageNamed:backgroundImage]
                         forState:(UIControlStateNormal)];
    [playerBtn setBackgroundImage:[UIImage imageNamed:backgroundImage]
                         forState:(UIControlStateDisabled)];
}

- (void)playerClick:(UIButton *)playerBtn {

    UIView * bjView = [UIView new];
    self.coverView = bjView;
    bjView.backgroundColor = [UIColor colorWithHexRGB:@"#332412" andAlpha:0.88f];
    bjView.frame = self.superview.bounds;
    [self.superview addSubview:bjView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.scaleCenterX = CGScaleGetWidth(self.superview.frame)/2;
        self.scaleCenterY = CGScaleGetHeight(self.superview.frame)/2;
        
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{

            for (NSInteger count = 0; count < 7; count++) {
                UIButton * btn = self.palyerStatisticsBtns[count];
                btn.scaleW = 204;
                btn.scaleH = 204;
                btn.center = [self layoutPalyerStatisticsBtns:(CGFloat)count/7 and:scaleW_ByPx(350)];
            };
           

            
         } completion:^(BOOL finished) {
             
             self.bounds = CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height);
             for (NSInteger count = 0; count < 7; count++) {
                 UIButton * btn = self.palyerStatisticsBtns[count];
                 btn.scaleW = 204;
                 btn.scaleH = 204;
                 btn.center = [self layoutPalyerStatisticsBtns:(CGFloat)count/7 and:scaleW_ByPx(350)];
             };
             
            
             

         }];
        
    }];
    
    // 发送通知
    [[NSNotificationCenter defaultCenter]
     postNotificationName:NOTIFICATION_MASKING object:[NSNumber numberWithBool:YES]];
    // 按钮状态调节
    playerBtn.enabled = NO;
    // 置顶
    [self.superview bringSubviewToFront:self];
}

- (CGPoint)layoutPalyerStatisticsBtns:(CGFloat)progress and:(CGFloat)radius {
    
    CGFloat angle = M_PI*2*progress;
    int index = (angle)/M_PI_2;//用户区分在第几象限内
    float needAngle = angle - index*M_PI_2;//用于计算正弦/余弦的角度
    float x = 0,y = 0;//用于保存frame
    switch (index) {
        case 0:
            x = radius + sinf(needAngle)*radius -radius + self.frame.size.width/2;
            y = radius - cosf(needAngle)*radius -radius + self.frame.size.height/2;
            break;
        case 1:
            x = radius + cosf(needAngle)*radius -radius + self.frame.size.width/2;
            y = radius + sinf(needAngle)*radius -radius + self.frame.size.height/2;
            break;
        case 2:
            x = radius - sinf(needAngle)*radius -radius + self.frame.size.width/2;
            y = radius + cosf(needAngle)*radius -radius + self.frame.size.height/2;
            break;
        case 3:
            x = radius - cosf(needAngle)*radius -radius + self.frame.size.width/2;
            y = radius - sinf(needAngle)*radius -radius + self.frame.size.height/2;
            break;
            
        default:
            break;
    }
    
    //更新圆环的frame
    CGPoint point = CGPointMake(x, y);
    //    rect.origin.x = x + self.lineWidth*0.5;
    //    rect.origin.y = y + self.lineWidth*0.5;
    //    _endPoint.frame = rect;
    return point;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self stayBack];
}

- (void)setPlayerNum:(NSString *)playerNum {
    
    _playerNum = playerNum;
}

#pragma mark - lazy

- (UIButton *)playerBtn {
    
    if (!_playerBtn) {
        
        _playerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _playerBtn.scaleW = 218;
        _playerBtn.scaleH = _playerBtn.scaleW;
        [_playerBtn addTarget:self action:@selector(playerClick:)
             forControlEvents:(UIControlEventTouchUpInside)];
//        [_playerBtn setTitle:@"12" forState:(UIControlStateNormal)];
        [_playerBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _playerBtn.titleLabel.font = kSCALE_BOLD_FONT(50);
        [self addSubview:_playerBtn];
    }
    return _playerBtn;
}

- (NSMutableArray *)palyerStatisticsBtns {
    
    if (!_palyerStatisticsBtns) {
        _palyerStatisticsBtns = [NSMutableArray array];
    }
    return _palyerStatisticsBtns;
}

- (NSArray *)operationOptionTitles {
    
    if (!_operationOptionTitles) {
        _operationOptionTitles = @[@"助攻",@"1分",@"2分",@"3分",@"盖帽",@"犯规",@"篮板",@"中",@"不中"];
    }
    return _operationOptionTitles;
}

-(void)fucationBtnClicked:(UIButton *)btn{
//    NSString *str = [NSString string];
    switch (btn.tag) {
        case 0:
            
            //助攻
            break;
        case 1:
            //1分
             [self showChooseBtn:btn];
            break;

        case 2:
             [self showChooseBtn:btn];
            //2分
            break;

        case 3:
            [self showChooseBtn:btn];
            //3分
            break;

        case 4:
            //盖帽
            break;

        case 5:
            //犯规
            break;

        case 6:
            //篮板
            break;
        case 7 :
            //中
            if (self.delegate && [self.delegate respondsToSelector:@selector(backPlay:andStatus:)] ) {
                [_delegate backPlay:_p andStatus:_scroes];
            }
            break;
        case 8:
            //不中
            break;
            
        default:
            break;
            
    }
    if (btn.tag !=1 && btn.tag !=2 && btn.tag !=3) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(backPlay:andStatus:)] ) {
            [_delegate backPlay:_p andStatus:btn.tag];
        }
        [self stayBack];
    }

    
}

-(void)stayBack{
    
    [self.coverView removeFromSuperview];
    // 更改按钮状态
    self.playerBtn.enabled = YES;
    // 还原球员视图位置
    [self scaleFrameMake:self.initialFrame.origin.x
                        :self.initialFrame.origin.y
                        :self.initialFrame.size.width
                        :self.initialFrame.size.height];
    
    // 发送通知
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"masking" object:[NSNumber numberWithBool:NO]];
    
    // 还原球员操作按钮位置
    for (NSInteger count = 0; count < 9; count++) {
        UIButton * btn = self.palyerStatisticsBtns[count];
        [btn scaleCenterBoundsMake:CGScaleGetWidth(self.frame)/2
                                  :CGScaleGetHeight(self.frame)/2
                                  :0
                                  :0];
    }
}

-(void)showChooseBtn:(UIButton *)btn{
    _scroes = btn.tag;
    [UIView animateWithDuration:.5 animations:^{
        
        UIButton * btn8 = self.palyerStatisticsBtns[7];
        btn8.scaleW = 204;
        btn8.scaleH = 204;
        
        btn8.center = CGPointMake(self.frame.size.width -H(200), H(387/2));
        
        UIButton * btn9 = self.palyerStatisticsBtns[8];
        btn9.scaleW = 204;
        btn9.scaleH = 204;
        btn9.center = CGPointMake(self.frame.size.width -H(200), super.frame.size.height-H(420/2));
    }];
}


@end
