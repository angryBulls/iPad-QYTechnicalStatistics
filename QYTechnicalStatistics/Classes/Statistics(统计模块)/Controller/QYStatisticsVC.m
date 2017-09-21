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

@interface QYStatisticsVC ()<QYStadiumViewDelegate,QYRegistrationMinViewDelegate,QYReplacePlayerVCDelegate,QYChangeVCDelegate>

@property (strong, nonatomic) QYRegistrationTitleView * registrationTitleView;
@property (strong, nonatomic) QYRegistrationMinView * registrationMinView;
@property (strong, nonatomic) QYStadiumView * stadiumView;
@property (strong, nonatomic) UIView * maskView; // 蒙板

@property (nonatomic ,assign) BOOL isGame;
@property (nonatomic ,assign) BOOL endQuarter;


@property (nonatomic ,strong)NSMutableArray *insertDBDictArray;

#pragma mark 网络

@property (nonatomic ,strong) TSDBManager *tSDBManager;
@property (nonatomic ,strong) TSGameModel *gameModel;

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
        
        if ((11 == [insertDBDict[BnfBehaviorType] intValue]) || (12 == [insertDBDict[BnfBehaviorType] intValue])) { // 换人
            [self.insertDBDictArray removeLastObject];
            //算作两步，1）下场 2）上场
            [self.tSDBManager deleteObjectByInsertDBDict:[self.insertDBDictArray lastObject]];
        }
        
        [self.insertDBDictArray removeLastObject];
        
        [self p_updateStatisticsData];
    }
}
#pragma mark QYChangeVCDelegate
-(void)finishChange{
    [self p_updateStatisticsData];
    
    
}


#pragma mark QYRegistrationMinViewDelegate

-(void)startGaming{
    _endQuarter = 0;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger i = [[userDefault objectForKey:startTag] integerValue];
    
    
    if (i == 0) {
        // save the matchDate
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            TSDBManager *tSDBManager = [[TSDBManager alloc] init];
            NSMutableDictionary *gameTableDict = [[tSDBManager getObjectById:GameId fromTable:GameTable] mutableCopy];
            if ([gameTableDict[@"currentStage"] isEqualToString:StageOne]) {
                NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
                fmt.dateFormat = @"YYYY-MM-dd HH:mm:ss";
                gameTableDict[@"matchDate"] = [fmt stringFromDate:[NSDate date]];
                [tSDBManager putObject:gameTableDict withId:GameId intoTable:GameTable];
            }
            
        });
    }
    i++;
    [userDefault setObject:[NSString stringWithFormat:@"%ld",i] forKey:startTag];
    [userDefault synchronize];
    
    _isGame = 1;
}

-(void)quarterGameEnd{
    
    _endQuarter = 1;
    _isGame = 0;
    [[NSUserDefaults standardUserDefaults] objectForKey:lastTime];
    
    
}
- (void)changeInfoOfMatch{
    QYChangeVC *vc = [[QYChangeVC alloc] init];
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)finishGameWithQuarter:(NSInteger)quarter{
    QYFinishMatchVC *vc= [QYFinishMatchVC new];
    vc.tSDBManager = _tSDBManager;
    vc.gameModel = _gameModel;
//    vc.finisnTag = QuarterOne;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)replacePlayerInStadiumView:(QYStadiumView *)stadiumView {
    
    // 跳转换人页面
    QYReplacePlayerVC *vc = [[QYReplacePlayerVC alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:
     vc animated:YES];
}

#pragma mark - <QYReplacePlayerVCDelegate>


-(void)backInsterDic1:(NSMutableDictionary *)dic1 andInsterDic2:(NSMutableDictionary *)dic2{
    
    [self.insertDBDictArray addObject:dic1];
    
    [_tSDBManager saveOneResultDataWithDict:dic1 saveDBStatusSuccessBlock:^(NSDictionary *insertDBDict) {
        
    } saveDBStatusFailBlock:^(NSString *error) {
        
    }];
    
    [self p_updateStatisticsData];
    
    
    [self.insertDBDictArray addObject:dic2];
    
    [_tSDBManager saveOneResultDataWithDict:dic2 saveDBStatusSuccessBlock:^(NSDictionary *insertDBDict) {
        
    } saveDBStatusFailBlock:^(NSString *error) {
        
    }];
    
    [self p_updateStatisticsData];
    
    
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
        _gameModel = calculationTool.gameModel;
        
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




@end
