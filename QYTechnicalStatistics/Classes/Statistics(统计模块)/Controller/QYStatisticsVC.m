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
#import "TSCalculationTool.h"
@interface QYStatisticsVC ()<QYStadiumViewDelegate,QYRegistrationMinViewDelegate>

@property (strong, nonatomic) QYRegistrationTitleView * registrationTitleView;
@property (strong, nonatomic) QYRegistrationMinView * registrationMinView;
@property (strong, nonatomic) QYStadiumView * stadiumView;
@property (strong, nonatomic) UIView * maskView; // 蒙板

@property (nonatomic ,assign) BOOL isGame;
@property (nonatomic ,assign) BOOL endQuarter;

#pragma mark 网络

@property (nonatomic ,strong) TSDBManager *tSDBManager;

@end

@implementation QYStatisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialization];
    
    [self p_updateStatisticsData];
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

-(TSDBManager *)tSDBManager{
    if (_tSDBManager == nil) {
        _tSDBManager = [[TSDBManager alloc] init];
    }
    
    return _tSDBManager;
}

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
        _stadiumView.hostDataSouce = _hostDataSouce;
        _stadiumView.guestDataSouce = _guestDataSouce;
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


#pragma mark - update game statistics method
- (void)p_updateStatisticsData {
    // 为防止数据未保存成功，延时后再刷新数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        TSCalculationTool *calculationTool = [[TSCalculationTool alloc] init];
        [calculationTool calculationHostTotalScoreFouls];
        [calculationTool calculationGuestTotalScoreFouls];
        
        [calculationTool calculationHostStageScoreFouls];
        [calculationTool calculationGuestStageScoreFouls];
        
        [calculationTool calculationTimeOutSatgeData];
        

        _registrationTitleView.gameModel = calculationTool.gameModel;
        _registrationMinView.gameModel = calculationTool.gameModel;
        _stadiumView.gameModel = calculationTool.gameModel;
        
    });
}

- (void)p_playerDataDidChanged:(NSNotification *)notif {
    [self p_updateStatisticsData];
}

- (void)p_gotoTheNextStageGame:(NSNotification *)notif {

    self.registrationMinView.midBjView.currentSecond = StageGameTimes;
    [self p_updateStatisticsData];
}


#pragma mark - 提交本节数据到BCBC服务器
- (void)p_sendCurrentStageData {
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    NSString *stageCount = [self.tSDBManager getObjectById:GameId fromTable:GameTable][CurrentStage];
    
    
    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
    
//    TSVoiceViewModel *voiceViewModel = [[TSVoiceViewModel alloc] initWithPramasDict:paramsDict];
//    [voiceViewModel setBlockWithReturnBlock:^(id returnValue) {
//        DDLog(@"up load data returnValue is:%@", returnValue);
//        if (returnValue[@"entity"][@"matchInfoId"]) {
//            NSMutableDictionary *gameTableDict = [[self.tSDBManager getObjectById:GameId fromTable:GameTable] mutableCopy];
//            gameTableDict[@"matchInfoId"] = returnValue[@"entity"][@"matchInfoId"];
//            [self.tSDBManager putObject:gameTableDict withId:GameId intoTable:GameTable];
//        }
//        [self p_updateCurrentStageIfSendDataSuccess];
//        
//        [self.dataShowArray removeAllObjects];
//        [self.insertDBDictArray removeAllObjects];
//        [self.tableView reloadData];
//        
//        // 每节数据提交成功后，初始化所有球员的上场时间
//        [self.tSDBManager initPlayingTimesOnce];
//        [SVProgressHUD showInfoWithStatus:@"提交成功"];
//    } WithErrorBlock:^(id errorCode) {
//        [SVProgressHUD showInfoWithStatus:errorCode];
//    } WithFailureBlock:^{
//        [SVProgressHUD dismiss];
//    }];
//    [voiceViewModel sendCurrentStageData];
}

- (void)p_updateCurrentStageIfSendDataSuccess { // 本节数据提交成功后，更新节数
    NSMutableDictionary *gameTableDict = [[self.tSDBManager getObjectById:GameId fromTable:GameTable] mutableCopy];
//    [StageAllArray enumerateObjectsUsingBlock:^(NSString *stageName, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([gameTableDict[CurrentStage] isEqualToString:stageName]) {
//            if (idx == 6) { // 加时赛3（表示全场比赛彻底结束）
//                gameTableDict[CurrentStageDataSubmitted] = @"1";
//                self.submitSectionBtn.enabled = NO;
//                [self.submitSectionBtn setTitle:GameOver forState:UIControlStateNormal];
//                [self p_pushFullManagerViewController];
//            } else if (3 == idx || 4 == idx || 5 == idx) { // 第四节或者加时赛1或者加时赛2数据提交后，不自动进入加时赛
//                gameTableDict[CurrentStageDataSubmitted] = @"1";
//                [self p_pushFullManagerViewController];
//            } else if (idx < 3) {
//                gameTableDict[CurrentStage] = StageAllArray[idx + 1];
//                gameTableDict[CurrentStageDataSubmitted] = @"0";
//            }
//            *stop = YES;
//        }
//    }];
//    [self.tSDBManager putObject:gameTableDict withId:GameId intoTable:GameTable];
//    self.topView.currentSecond = StageGameTimes;
//    self.topView.countDownLab.text = @"00 : 00";
    [self p_updateStatisticsData];
}

// LCActionSheetDelegate
- (void)actionSheet:(LCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (self.actionSheet) {
//        [[NSNotificationCenter defaultCenter] removeObserver:self.actionSheet name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
//        self.actionSheet = nil;
//    }
//    
//    if (1 == buttonIndex) {
//        NSDictionary *gameTableDict = [self.tSDBManager getObjectById:GameId fromTable:GameTable];
//        if ([gameTableDict[CurrentStageDataSubmitted] isEqualToString:@"1"]) {
//            if ([gameTableDict[CurrentStage] isEqualToString:StageFour] || [gameTableDict[CurrentStage] isEqualToString:OverTime3]) {
//                DDLog(@"CurrentStage is:%@", gameTableDict[CurrentStage]);
//                [self p_pushFullManagerViewController];
//                return;
//            }
//        }
//        
//        [self p_sendCurrentStageData];
//    }
}

- (void)p_pushFullManagerViewController { // push到全场比赛技术统计页面
    }



@end
