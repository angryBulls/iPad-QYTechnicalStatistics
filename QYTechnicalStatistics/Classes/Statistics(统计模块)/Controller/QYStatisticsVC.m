//
//  QYStatisticsVC.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/20.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYStatisticsVC.h"
#import "QYRegistrationTitleView.h"
#import "QYRegistrationMinView.h"
#import "QYStadiumView.h"
#import "QYReplacePlayerVC.h"
#import "QYChangeVC.h"
#import "QYFinishMatchVC.h"
@interface QYStatisticsVC ()<QYStadiumViewDelegate,QYRegistrationMinViewDelegate>

@property (strong, nonatomic) QYRegistrationTitleView * registrationTitleView;
@property (strong, nonatomic) QYRegistrationMinView * registrationMinView;
@property (strong, nonatomic) QYStadiumView * stadiumView;
@property (strong, nonatomic) UIView * maskView; // 蒙板

@property (nonatomic ,assign) BOOL isGame;
@property (nonatomic ,assign) BOOL endQuarter;
@end

@implementation QYStatisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialization];
}

- (void)initialization {
    
    // 监听通知
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(masking:) name:NOTIFICATION_MASKING object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    // 隐藏导航条
    self.navigationController.navigationBar.hidden = YES;
    // 初始化设置
    [self.view addSubview:self.registrationTitleView];
    [self.view addSubview:self.registrationMinView];
    [self.view addSubview:self.stadiumView];
}

- (void)masking:(NSNotification *)notice {
    
    NSNumber * number = (NSNumber *)notice.object;
    // 隐藏or显示遮盖
    [number boolValue] ? (self.maskView.alpha = 0.88) : (self.maskView.alpha = 0);
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    // 布局子控件
    [self.registrationTitleView scaleFrameMake:0 :0 :CGScaleGetWidth(self.view.frame) :262];
    [self.registrationMinView scaleFrameMake:0 :CGScaleGetMaxY(self.registrationTitleView.frame)
                                            :CGScaleGetWidth(self.view.frame) :142];
    self.registrationMinView.delegate = self;
    
    [self.maskView scaleFrameMake:0
                                 :0
                                 :CGScaleGetWidth(self.view.frame)
                                 :CGScaleGetHeight(self.view.frame)];
    
    
    [self.stadiumView scaleFrameMake:0 :CGScaleGetMaxY(self.registrationMinView.frame)
                                    :CGScaleGetWidth(self.view.frame) :1130];
    [self.view bringSubviewToFront:self.stadiumView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

#define mark - lazy

- (QYRegistrationTitleView *)registrationTitleView {
    
    if (!_registrationTitleView) {
        _registrationTitleView = [QYRegistrationTitleView createRegistrationTitleView];
    }
    return _registrationTitleView;
}

- (QYRegistrationMinView *)registrationMinView {
    
    if (!_registrationMinView) {
        _registrationMinView = [QYRegistrationMinView createRegistrationMinView];
    }
    return _registrationMinView;
}

- (QYStadiumView *)stadiumView {
    
    if (!_stadiumView) {
        _stadiumView = [QYStadiumView createStadiumView];
        _stadiumView.delegate = self;
    }
    return _stadiumView;
}

- (UIView *)maskView {
    
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.backgroundColor = [UIColor colorWithHexRGB:@"332412" andAlpha:0.88f];
        _maskView.alpha = 0;
        [self.view addSubview:_maskView];
    }
    return _maskView;
}

#pragma mark - <QYStadiumViewDelegate>

-(void)backStatusWithPlayer:(Player *)p Status:(NSInteger)status{
    
    if (_isGame ) {
        
        switch (status) {
            case 0:
                //助攻
                break;
            case 1:
                //1分
                if (p.team) {
                    
                    _registrationTitleView.guestTeamScoreLabel.score  += 1;
                    
                    _registrationTitleView.totalGuestTeamLabel.score += 1;
                    
                }
                else{
                    
                    _registrationTitleView.hostTeamScoreLabel.score +=1;
                    _registrationTitleView.totalHostTeamLabel.score +=1;
                }
                
                break;
                
            case 2:
                //2分
                if (p.team) {
                    _registrationTitleView.guestTeamScoreLabel.score  += 2;
                    
                    _registrationTitleView.totalGuestTeamLabel.score += 2;
                    
                }
                else{
                    _registrationTitleView.hostTeamScoreLabel.score +=2;
                    _registrationTitleView.totalHostTeamLabel.score +=2;
                    
                }
                break;
                
            case 3:
                //3分
                if (p.team) {
                    _registrationTitleView.guestTeamScoreLabel.score  += 3;
                    
                    _registrationTitleView.totalGuestTeamLabel.score += 3;
                    
                }
                else{
                    
                    _registrationTitleView.hostTeamScoreLabel.score +=3;
                    _registrationTitleView.totalHostTeamLabel.score +=3;
                    
                }
                break;
                
            case 4:
                //盖帽
                break;
                
            case 5:
                //犯规
                if (p.team) {
                    NSInteger scroe =   [_registrationMinView.guestOperationView.foulScoreLabel.text integerValue];
                    scroe +=1;
                    
                    _registrationMinView.guestOperationView.foulScoreLabel.text  = [NSString stringWithFormat:@"%ld",scroe];
                    
                }
                else{
                    NSInteger scroe =   [_registrationMinView.hostOperationView.foulScoreLabel.text integerValue];
                    scroe +=1;
                    
                    _registrationMinView.hostOperationView.foulScoreLabel.text  = [NSString stringWithFormat:@"%ld",scroe];
                    
                }
                break;
                
            case 6:
                //篮板
                break;
                
            default:
                break;
                
        }

    }
        
}


#pragma mark QYRegistrationMinViewDelegate

-(void)startGaming{
    _endQuarter = 0;
    _isGame = 1;
}

-(void)quarterGameEnd{
    
    _endQuarter = 1;
    _isGame = 0;
    
    
    
}
- (void)changeInfoOfMatch{
    QYChangeVC *vc = [[QYChangeVC alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)finishGameWithQuarter:(NSInteger)quarter{
    [self.navigationController pushViewController:[QYFinishMatchVC new] animated:YES];
    
    
}

- (void)replacePlayerInStadiumView:(QYStadiumView *)stadiumView {
    
    // 跳转换人页面
    [self.navigationController pushViewController:
     [QYReplacePlayerVC createReplacePlayerVC] animated:YES];
}



#pragma mark - <dealloc>
- (void)dealloc {
    
    
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_MASKING object:nil];
}


@end
