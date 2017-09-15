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

@property (nonatomic ,strong)NSMutableArray *insertDBDictArray;

#pragma mark 网络

@property (nonatomic ,strong) TSDBManager *tSDBManager;

@end

@implementation QYStatisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialization];
    // 创建数据库和数据库表
    NSString *documentsPath = nil;
    NSArray *appArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([appArray count] > 0) {
        NSLog(@"ssssss");
        documentsPath = [appArray objectAtIndex:0];
    }
    
    NSLog(@"%ld ----  --  %@",appArray.count,documentsPath);
    
    NSArray *allHostTeamPlayerData = [self.tSDBManager getAllHostTeamPlayerData];
    NSLog(@"allHostTeamPlayerData is:%@", allHostTeamPlayerData);
    
    NSArray *allGuestTeamPlayerData = [self.tSDBManager getAllGuestTeamPlayerData];
    NSLog(@"allGuestTeamPlayerData is:%@", allGuestTeamPlayerData);
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

-(NSMutableArray *)insertDBDictArray{
    if (_insertDBDictArray == nil) {
        _insertDBDictArray = [NSMutableArray array];
    }
    return _insertDBDictArray;
}

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
    
//    if (_isGame ) {
//        
//        switch (status) {
//            case 0:
//                //助攻
//                break;
//            case 1:
//                //1分
//                if (p.team) {
//                    
//                    _registrationTitleView.guestTeamScoreLabel.score  += 1;
//                    
//                    _registrationTitleView.totalGuestTeamLabel.score += 1;
//                    
//                }
//                else{
//                    
//                    _registrationTitleView.hostTeamScoreLabel.score +=1;
//                    _registrationTitleView.totalHostTeamLabel.score +=1;
//                }
//                
//                break;
//                
//            case 2:
//                //2分
//                if (p.team) {
//                    _registrationTitleView.guestTeamScoreLabel.score  += 2;
//                    
//                    _registrationTitleView.totalGuestTeamLabel.score += 2;
//                    
//                }
//                else{
//                    _registrationTitleView.hostTeamScoreLabel.score +=2;
//                    _registrationTitleView.totalHostTeamLabel.score +=2;
//                    
//                }
//                break;
//                
//            case 3:
//                //3分
//                if (p.team) {
//                    _registrationTitleView.guestTeamScoreLabel.score  += 3;
//                    
//                    _registrationTitleView.totalGuestTeamLabel.score += 3;
//                    
//                }
//                else{
//                    
//                    _registrationTitleView.hostTeamScoreLabel.score +=3;
//                    _registrationTitleView.totalHostTeamLabel.score +=3;
//                    
//                }
//                break;
//                
//            case 4:
//                //盖帽
//                break;
//                
//            case 5:
//                //犯规
//                if (p.team) {
//                    NSInteger scroe =   [_registrationMinView.guestOperationView.foulScoreLabel.text integerValue];
//                    scroe +=1;
//                    
//                    _registrationMinView.guestOperationView.foulScoreLabel.text  = [NSString stringWithFormat:@"%ld",scroe];
//                    
//                }
//                else{
//                    NSInteger scroe =   [_registrationMinView.hostOperationView.foulScoreLabel.text integerValue];
//                    scroe +=1;
//                    
//                    _registrationMinView.hostOperationView.foulScoreLabel.text  = [NSString stringWithFormat:@"%ld",scroe];
//                    
//                }
//                break;
//                
//            case 6:
//                //篮板
//                break;
//                
//            default:
//                break;
//                
//        }
//
//    }
    
}

-(void)backResult:(NSMutableDictionary *)resultDic{
    
    [self.insertDBDictArray addObject:resultDic];
    
    [_tSDBManager saveOneResultDataWithDict:resultDic saveDBStatusSuccessBlock:^(NSDictionary *insertDBDict) {
        
    } saveDBStatusFailBlock:^(NSString *error) {
        
    }];
    
    [self p_updateStatisticsData];
    
}
-(void)updateResultDic:(NSMutableDictionary *)dic andStatus:(NSInteger)staus{
    
    [self.insertDBDictArray addObject:dic];
    
    [_tSDBManager saveOneResultDataWithDict:dic saveDBStatusSuccessBlock:^(NSDictionary *insertDBDict) {
        
    } saveDBStatusFailBlock:^(NSString *error) {
        
    }];
    
    [self p_updateStatisticsData];
}

//撤销
- (void)p_revokeBtnClick {
    if (0 == self.insertDBDictArray.count) {
        return;
    }
    
    if (self.insertDBDictArray.count) {
        [self.tSDBManager deleteObjectByInsertDBDict:[self.insertDBDictArray lastObject]];
        
        NSDictionary *insertDBDict = [self.insertDBDictArray lastObject];
        if ((11 == [insertDBDict[BnfBehaviorType] intValue]) || (12 == [insertDBDict[BnfBehaviorType] intValue])) { // 换人语音识别
            // [self.voicePlayersView updatePlayersStatus];
        }
        
        [self.insertDBDictArray removeLastObject];
        
        [self p_updateStatisticsData];
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
        
        NSDictionary *insertDBDict = [self.insertDBDictArray lastObject];
        if ((11 == [insertDBDict[BnfBehaviorType] intValue]) || (12 == [insertDBDict[BnfBehaviorType] intValue])) { // 换人语音识别
//            [self.voicePlayersView updatePlayersStatus];  
        }
        
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



@end
