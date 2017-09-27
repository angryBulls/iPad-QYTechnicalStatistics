//
//  QYFinishMatchVC.m
//  QYTechnicalStatistics
//
//  Created by 孙中山 on 2017/9/7.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYFinishMatchVC.h"
#import "QYFinishCell.h"
#import "TSPlayerModel.h"
#import "TSManagerPlayerModel.h"
#import "TSVoiceViewModel.h"

#define LabelW (1024 -29)/7
#define Label2W (1024 -29)*2/9
#define LabelH self.frame.size.height *2
@interface QYFinishMatchVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;
//@property (nonatomic ,strong)NSMutableArray *dataSouce;

@property (nonatomic ,strong)NSMutableArray *hostPlayerDataArray;
@property (nonatomic ,strong)NSMutableArray *guestPlayerDataArray;

@property (nonatomic ,strong)UILabel *timeLabel;
@property (nonatomic ,strong)UILabel *teamInfoLabel;
@property (nonatomic ,strong)UILabel *gameInfoLabel;

@property (nonatomic ,strong)UIButton *footBtn1;
@property (nonatomic ,strong)UIButton *footBtn2;


@end

@implementation QYFinishMatchVC
#pragma mark 懒加载


#pragma mark 页面处理
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden  = YES;
    
    
    [self p_setupMatchData];
    [self p_setupHostPlayerData];
    [self p_setupGuestPlayerData];
    
    [self initNavigation];
    [self initTableView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self p_getGameInfo];
    
    
}
-(void)p_setupMatchData{
    if (_finisnTag == nil) {
        NSMutableDictionary *checkTableDic = [[self.tSDBManager getObjectById:GameId fromTable:GameTable] mutableCopy];
        _finisnTag = checkTableDic[@"currentStage"] ;

    }
    
}

- (void)p_setupHostPlayerData {
    if (_controllerTag) {
        TSCalculationTool *calculationTool = [[TSCalculationTool alloc] init];
        self.hostPlayerDataArray = [calculationTool calculationallHostPlayerFullData];

    }
    else{
        
        NSArray *playerArrayH = [self.tSDBManager getObjectById:TeamCheckID_H fromTable:TSCheckTable];
        NSArray *playerModelArrayH = [TSPlayerModel mj_objectArrayWithKeyValuesArray:playerArrayH];
        
        NSMutableArray *hostPlayerDataArray = [NSMutableArray array];
        [playerModelArrayH enumerateObjectsUsingBlock:^(TSPlayerModel *playerModel, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *playerDataDict = [self.tSDBManager getObjectById:playerModel.ID fromTable:PlayerTable];
            
            NSString *stageCount = [self.tSDBManager getObjectById:GameId fromTable:GameTable][CurrentStage];
            NSDictionary *stagePlayerDataDict = playerDataDict[stageCount];
            
            if (!stagePlayerDataDict) {
                stagePlayerDataDict = @{};
            }
            
            TSManagerPlayerModel *tPlayerModel = [TSManagerPlayerModel mj_objectWithKeyValues:stagePlayerDataDict];
            tPlayerModel.playerId = playerDataDict[@"playerId"];
            tPlayerModel.playerName = playerModel.name;
            tPlayerModel.playerNumber = playerModel.gameNum;
            tPlayerModel.photo = playerModel.photo;
            tPlayerModel.changeStatus = NO;
            tPlayerModel.positional  = playerModel.positional;
            tPlayerModel.playTimes = playerModel.playingTimes;
            [hostPlayerDataArray addObject:tPlayerModel];
            
        }];
        self.hostPlayerDataArray = hostPlayerDataArray;
    }
    
    
}

- (void)p_setupGuestPlayerData {
    
    if (_controllerTag) {
        TSCalculationTool *calculationTool = [[TSCalculationTool alloc] init];
        self.guestPlayerDataArray = [calculationTool calculationallGuestPlayerFullData];
    }
    else
    {
        NSArray *playerArrayG = [self.tSDBManager getObjectById:TeamCheckID_G fromTable:TSCheckTable];
        NSArray *playerModelArrayG = [TSPlayerModel mj_objectArrayWithKeyValuesArray:playerArrayG];
        NSMutableArray *guestPlayerDataArray = [NSMutableArray array];
        [playerModelArrayG enumerateObjectsUsingBlock:^(TSPlayerModel *playerModel, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *playerDataDict = [self.tSDBManager getObjectById:playerModel.ID fromTable:PlayerTable];
            NSString *stageCount = [self.tSDBManager getObjectById:GameId fromTable:GameTable][CurrentStage];
            NSDictionary *stagePlayerDataDict = playerDataDict[stageCount];
            
            if (!stagePlayerDataDict) {
                stagePlayerDataDict = @{};
            }
            TSManagerPlayerModel *tPlayerModel = [TSManagerPlayerModel mj_objectWithKeyValues:stagePlayerDataDict];
            tPlayerModel.playerId = playerDataDict[@"playerId"];
            tPlayerModel.playerName = playerModel.name;
            tPlayerModel.playerNumber = playerModel.gameNum;
            tPlayerModel.photo = playerModel.photo;
            tPlayerModel.changeStatus = NO;
            tPlayerModel.positional  = playerModel.positional;
            tPlayerModel.playTimes = playerModel.playingTimes;
            [guestPlayerDataArray addObject:tPlayerModel];
        }];
        self.guestPlayerDataArray = guestPlayerDataArray;
        
    }
    
    
}


-(void)initNavigation{
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scaleW_ByPx(2048), scaleY_ByPx(256))];
    [self.view addSubview:header];
    header.backgroundColor = [UIColor colorWithHexRGB:@"#3F85FF" andAlpha:1];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(scaleX_ByPx(31), scaleY_ByPx(61), SCREEN_WIDTH, scaleH_ByPx(31))];
    [header addSubview:_timeLabel];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = [UIFont systemFontOfSize:scaleY_ByPx(32)];
    _timeLabel.textColor = [UIColor whiteColor];
    //    lable.text = @"比赛时间：2017-05-21 10:00";
    
    _teamInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(scaleX_ByPx(31), scaleY_ByPx(129), SCREEN_WIDTH, scaleH_ByPx(31))];
    [header addSubview:_teamInfoLabel];
    _teamInfoLabel.textAlignment = NSTextAlignmentLeft;
    _teamInfoLabel.font = [UIFont systemFontOfSize:scaleY_ByPx(32)];
    _teamInfoLabel.textColor = [UIColor whiteColor];
    
    
    _gameInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(scaleX_ByPx(31), scaleY_ByPx(194), SCREEN_WIDTH, scaleH_ByPx(31))];
    [header addSubview:_gameInfoLabel];
    _gameInfoLabel.textAlignment = NSTextAlignmentLeft;
    _gameInfoLabel.font = [UIFont systemFontOfSize:scaleY_ByPx(32)];
    _gameInfoLabel.textColor = [UIColor whiteColor];
    
    
}

-(UIView *)creatFinshHeader{
    UIView *header = [[UIView alloc] initWithFrame:scaleFrameMake(29, 256, SCREEN_WIDTH*2 - 29*2, 728-256)];
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:scaleFrameMake(0, 0, 2048-29*2 , 91)];
    firstLabel.textAlignment = NSTextAlignmentCenter;
    firstLabel.text = @"比赛结果";
    firstLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:scaleX_ByPx(34)];
    
    [header addSubview:firstLabel];
    
    
    NSMutableDictionary *gameTableDict = [[_tSDBManager getObjectById:GameCheckID fromTable:TSCheckTable] mutableCopy];
    
    NSArray *array1 = @[@"双方",@"第一节",@"第二节",@"第三节",@"第四节",@"加时 1",@"加时 2",@"加时 3",@"总得分"];
    NSArray *array2 = @[gameTableDict[@"teamNameH"],_gameModel.scoreStageOneH,_gameModel.scoreStageTwoH,_gameModel.scoreStageThreeH,_gameModel.scoreStageFourH,_gameModel.scoreOvertime1H,_gameModel.scoreOvertime2H,_gameModel.scoreOvertime3H,_gameModel.scoreTotalH];
    
    NSArray *array3 = @[gameTableDict[@"teamNameG"],_gameModel.scoreStageOneG,_gameModel.scoreStageTwoG,_gameModel.scoreStageThreeG,_gameModel.scoreStageFourG,_gameModel.scoreOvertime1G,_gameModel.scoreOvertime2G,_gameModel.scoreOvertime3G,_gameModel.scoreTotalG];
    [header addSubview: [self infoViewWithArr:array1 AndY:91 AndColorStr:@"#E1ECFF" AndTextColorStr:@"#414141"]];
    [header addSubview: [self infoViewWithArr:array2 AndY:91+99 AndColorStr:@"#F4F8FF" AndTextColorStr:@"#333333"]];
    [header addSubview: [self infoViewWithArr:array3 AndY:91+99+99 AndColorStr:@"#F4F8FF" AndTextColorStr:@"#333333"]];
    
    UILabel *playDataL = [[UILabel alloc] initWithFrame:scaleFrameMake(0, 91+99+99+99, 2048 - 29*2, 88)];
    [header addSubview:playDataL];
    playDataL.text = @"球员数据";
    playDataL.textAlignment = NSTextAlignmentCenter;
    playDataL.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:scaleX_ByPx(32)];
    
    
    return header;
}

-(UIView *)infoViewWithArr:(NSArray *)infoArr AndY:(float)y AndColorStr:(NSString *)bgColorStr AndTextColorStr:(NSString *)textColorStr{
    UIView *view = [[UIView alloc] initWithFrame:scaleFrameMake(0, y, SCREEN_WIDTH*2 - 29*2, 99)];
    view.backgroundColor = [UIColor colorWithHexRGB:bgColorStr andAlpha:1];
    for (int i = 0; i<infoArr.count; i++) {
        UILabel *l  = [[UILabel alloc] initWithFrame:scaleFrameMake(i*Label2W, 0, Label2W, 99)];
        [view addSubview:l];
        l.textAlignment = NSTextAlignmentCenter;
        l.textColor = [UIColor colorWithHexRGB:textColorStr andAlpha:1];
        l.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
        l.text = infoArr[i];
        
    }
    
    return view;
}

-(UIView *)creatLessionHeader{
    UILabel *header = [[UILabel alloc] initWithFrame:scaleFrameMake(29, 256, SCREEN_WIDTH*2 - 29*2, 91)];
    
    header.textAlignment = NSTextAlignmentCenter;
    if ([_finisnTag isEqualToString:StageOne]) {
        header.text = @"第一节";
    }else if ([_finisnTag isEqualToString:StageTwo]){
        header.text = @"第二节";
    }
    else if ([_finisnTag isEqualToString:StageThree]){
        header.text = @"第三节";
    }
    else if ([_finisnTag isEqualToString:StageFour]){
        header.text = @"第四节";
    }else if ([_finisnTag isEqualToString:OverTime1]){
        header.text = @"加时赛 1";
    }
    else if ([_finisnTag isEqualToString:OverTime2]){
        header.text = @"加时赛 2";
    }else if ([_finisnTag isEqualToString:OverTime3]){
        header.text = @"加时赛 3";
    }
    else
    {
        header.text = @"比赛结束";
        
    }
    header.font = [UIFont systemFontOfSize:scaleX_ByPx(34)];
    header.textColor = [UIColor colorWithHexRGB:@"#333333" andAlpha:1];
    return header;
}

/** 设置tableView*/
-(void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(scaleX_ByPx(29), scaleY_ByPx(256), SCREEN_WIDTH-scaleX_ByPx(29)*2, SCREEN_HEIGHT-scaleY_ByPx(256)) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate  = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [self footerView];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self initHeaderView];
    
}

-(void)initHeaderView{
    
    if ([_finisnTag isEqualToString:finish]) {
        _tableView.tableHeaderView = [self creatFinshHeader];
    }
    else{
        _tableView.tableHeaderView = [self creatLessionHeader];
    }

}


-(UIView *)footerView{
    UIView *view = [[UIView alloc] initWithFrame:scaleFrameMake(0, 0,SCREEN_WIDTH*2-29*2 , 59+59+86)];
    
    if (_finisnTag) {
        _footBtn1 = [[UIButton alloc] initWithFrame:scaleFrameMake(568-29, 59, 310, 86)];
        [_footBtn1 setBackgroundColor:[UIColor colorWithHexRGB:@"#5B97FF" andAlpha:1]];
        [_footBtn1 setTitle:@"提交本节比赛" forState:UIControlStateNormal];
        _footBtn1.layer.cornerRadius = scaleX_ByPx(10);
        _footBtn1.clipsToBounds = YES;
        [_footBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _footBtn1.titleLabel.font = [UIFont systemFontOfSize:scaleX_ByPx(32)];
        [_footBtn1 addTarget:self  action:@selector(tiJiao) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_footBtn1];
        
        _footBtn2 = [[UIButton alloc] initWithFrame:scaleFrameMake(1081-29, 59, 310, 86)];
        [_footBtn2 setBackgroundColor:[UIColor colorWithHexRGB:@"#5B97FF" andAlpha:1]];
        [_footBtn2 setTitle:@"进入加时赛" forState:UIControlStateNormal];
        _footBtn2.layer.cornerRadius = scaleX_ByPx(10);
        _footBtn2.clipsToBounds = YES;
        [_footBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _footBtn2.titleLabel.font = [UIFont systemFontOfSize:scaleX_ByPx(32)];
        [_footBtn2 addTarget:self action:@selector(joinOverTime) forControlEvents:UIControlEventTouchUpInside];
        _footBtn2.userInteractionEnabled = NO;
        _footBtn2.alpha  = .4;
        [view addSubview:_footBtn2];
        
        if ([_finisnTag isEqualToString:StageFour]||[_finisnTag isEqualToString:OverTime1]||[_finisnTag isEqualToString:OverTime2]||[_finisnTag isEqualToString:OverTime3]) {
            if ([self.gameModel.scoreTotalH isEqualToString:self.gameModel.scoreTotalG]) {
                _footBtn2.hidden = NO;
                _footBtn2.userInteractionEnabled = YES;
                _footBtn2.alpha = 1;
                _footBtn1.frame = scaleFrameMake(568-29, 59, 310, 86);
                _footBtn1.alpha = .4;
                _footBtn1.userInteractionEnabled = NO;
            }
            else
            {
                _footBtn2.alpha = .4;
                _footBtn2.userInteractionEnabled = YES;
                _controllerTag = 1;
                
            }
            
        }else{
            
            _footBtn2.hidden = YES;
            _footBtn1.frame = scaleFrameMake(SCREEN_WIDTH-155, 59, 310, 86);
            if (_controllerTag) {
                
                [_footBtn1 setTitle:@"保存并退出" forState:UIControlStateNormal];
            }

            
            
        }
    }
    //    else{
    //
    //        UIButton *btn = [[UIButton alloc] initWithFrame:scaleFrameMake(868-29, 59, 310, 86)];
    //        [btn setBackgroundColor:[UIColor colorWithHexRGB:@"#5B97FF" andAlpha:1]];
    //        [btn setTitle:@"保存并退出" forState:UIControlStateNormal];
    //        btn.layer.cornerRadius = scaleX_ByPx(10);
    //        btn.clipsToBounds = YES;
    //        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //        btn.titleLabel.font = [UIFont systemFontOfSize:scaleX_ByPx(32)];
    //        [btn addTarget:self action:@selector(finishChageData) forControlEvents:UIControlEventTouchUpInside];
    //
    //        [view addSubview:btn];
    //
    //    }
    //
    
    return view;
}



#pragma mark set方法
-(void)setGameModel:(TSGameModel *)gameModel{
    _gameModel = gameModel;
    
    
}
-(void)setTSDBManager:(TSDBManager *)tSDBManager{
    _tSDBManager = tSDBManager;
}


-(void)p_getGameInfo{
    
    NSMutableDictionary *gameTableDict = [[self.tSDBManager getObjectById:GameId fromTable:GameTable] mutableCopy];
    _timeLabel.text = [NSString stringWithFormat:@"比赛时间:%@",gameTableDict[@"matchDate"]];
    
    NSMutableDictionary *checkTableDic = [[self.tSDBManager getObjectById:GameCheckID fromTable:TSCheckTable] mutableCopy];
    
    _teamInfoLabel.text = [NSString stringWithFormat:@"[%@] —— [%@] —— [%@] —— [主场：%@] —— [客场：%@]",checkTableDic[@"gameLevel"],checkTableDic[@"gameArea"],checkTableDic[@"gameProvince"],checkTableDic[@"teamNameH"],checkTableDic[@"teamNameG"]];
    
    
    _gameInfoLabel.text = [NSString stringWithFormat:@"[主裁判:%@] —— [第一副裁:%@] —— [第二副裁:%@] —— [技术代表:%@] —— [技术统计:%@ %@]",checkTableDic[@"mainReferee"],checkTableDic[@"firstReferee"],checkTableDic[@"secondReferee"],checkTableDic[@"td"],checkTableDic[@"ts01"],checkTableDic[@"ts02"]];
    
}

#pragma mark 代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!section) {
        return _hostPlayerDataArray.count;
    }
    return _guestPlayerDataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return scaleX_ByPx(102);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QYFinishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[QYFinishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ;
    if (indexPath.section) {
        cell.tPlayModel = _guestPlayerDataArray[indexPath.row];
    }
    else{
        cell.tPlayModel = _hostPlayerDataArray[indexPath.row];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return scaleX_ByPx(166);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] initWithFrame:scaleFrameMake(0, 0, SCREEN_WIDTH*2-29*2, 176)];
    [view addSubview:  [self creatTeamViewBySection:section]];
    [view addSubview: [self creatHeaderInfoView]];
    
    return view;
    
}
-(UIView *)creatTeamViewBySection:(NSInteger)section{
    
    UIView * teamView = [[UIView alloc] initWithFrame:scaleFrameMake(0, 0, SCREEN_WIDTH*2-29*2, 88)];
    teamView.backgroundColor = [UIColor colorWithHexRGB:@"#F4F8FF" andAlpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:scaleFrameMake(31, 24, 94, 44)];
    [teamView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.layer.cornerRadius = scaleX_ByPx(10);
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    
    if (section) {
        label.text = @"客队";
        label.backgroundColor = [UIColor colorWithHexRGB:@"#49D5A6" andAlpha:1];
    }
    else{
        label.text = @"主队";
        label.backgroundColor = [UIColor colorWithHexRGB:@"#FF7976" andAlpha:1];
        
    }
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:scaleFrameMake(155, 0, SCREEN_WIDTH*2-29*2-155, 88)];
    infoLabel.textColor = [UIColor blackColor];
    infoLabel.font = [UIFont systemFontOfSize:scaleX_ByPx(32)];
    [teamView addSubview:infoLabel];
    infoLabel.textAlignment = NSTextAlignmentLeft;
    NSMutableDictionary *gameTableDict = [[_tSDBManager getObjectById:GameCheckID fromTable:TSCheckTable] mutableCopy];
    if (section) {
        
        infoLabel.text = [NSString stringWithFormat:@"%@    主教练：%@",gameTableDict[@"teamNameG"],gameTableDict[@"teamCoachG"]];
    }
    else{
        infoLabel.text = [NSString stringWithFormat:@"%@    主教练：%@",gameTableDict[@"teamNameH"],gameTableDict[@"teamCoachH"]];
    }
    
    return teamView;
    
}
-(UIView *)creatHeaderInfoView{
    UIView * teamInfoView = [[UIView alloc] initWithFrame:scaleFrameMake(0, 88, SCREEN_WIDTH*2-29*2, 88)];
    teamInfoView.backgroundColor = [UIColor colorWithHexRGB:@"#E1ECFF" andAlpha:1];
    
    for (int i = 0; i<14; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:scaleFrameMake(i*LabelW, 0, LabelW, 88)];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
        label.textColor = [UIColor colorWithHexRGB:@"#333333" andAlpha:1];
        [teamInfoView addSubview:label];
        NSString *title;
        switch (i) {
            case 0:
                title = @"球员";
                break;
            case 1:
                title = @"姓名";
                break;
            case 2:
                title = @"位置";
                break;
            case 3:
                title = @"上场时间";
                break;
            case 4:
                title = @"篮板";
                break;
            case 5:
                title = @"助攻";
                break;
            case 6:
                title = @"犯规";
                break;
            case 7:
                title = @"盖帽";
                break;
            case 8:
                title = @"1 分";
                break;
            case 9:
                title = @"命中率";
                break;
            case 10:
                title = @"2 分";
                break;
            case 11:
                title = @"命中率";
                break;
            case 12:
                title = @"3 分";
                break;
            case 13:
                title = @"命中率";
                break;
                
                
        }
        label.text = title;
        
    }
    
    return teamInfoView;
}

#pragma mark 点击事件

-(void)finishChageData{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)tiJiao{
    [self pushMatchData];
    
}

-(void)joinOverTime{
    [self pushMatchData];

    
}

-(void)pushMatchData{
    if (_controllerTag && ![_finisnTag isEqualToString:finish]) {
        QYFinishMatchVC *vc = [[QYFinishMatchVC alloc] init];
        vc.controllerTag = _controllerTag;
        vc.finisnTag = finish;
        vc.tSDBManager = _tSDBManager;
        vc.gameModel = _gameModel;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (_controllerTag && [_finisnTag isEqualToString:finish]){
        
        //删除数据库
        NSArray *appArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentsPath  = [appArray objectAtIndex:0];
        
        NSString *tsdbPath = [documentsPath stringByAppendingString:[NSString stringWithFormat:@"/%@", TSDBName]];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:tsdbPath]) {
            NSError *err;
            [fileManager removeItemAtPath:tsdbPath error:&err];
            [(AppDelegate *)[UIApplication sharedApplication].delegate setChoosePageRootView];
        } else {
        }
        
    }
    else
    {
        [self p_sendCurrentStageData];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"600" forKey:lastTime];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    }
    

}


#pragma mark - 提交本节数据到BCBC服务器
- (void)p_sendCurrentStageData {
    // 如果是最后一节，并且比分相同，则拒绝提交
    if ([self p_refuseIfDivideAndLastStage]) {
        [SVProgressHUD showInfoWithStatus:@"胜负未分，无法提交"];
        return;
    }
    
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];

    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
    
    TSVoiceViewModel *voiceViewModel = [[TSVoiceViewModel alloc] initWithPramasDict:paramsDict];
    
    
    [voiceViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        if (returnValue[@"entity"][@"matchInfoId"]) {
            NSMutableDictionary *gameTableDict = [[self.tSDBManager getObjectById:GameId fromTable:GameTable] mutableCopy];
            gameTableDict[@"matchInfoId"] = returnValue[@"entity"][@"matchInfoId"];
            [self.tSDBManager putObject:gameTableDict withId:GameId intoTable:GameTable];
        }
        [self p_updateCurrentStageIfSendDataSuccess];
#pragma mark -清空返回数据
        if ([self.delegate respondsToSelector:@selector(removeInsertDBDictArrayObjects)]) {
            [self.delegate removeInsertDBDictArrayObjects];
        }
        // 每节数据提交成功后，初始化所有球员的上场时间
        [self.tSDBManager initPlayingTimesOnce];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showInfoWithStatus:@"提交成功"];
        [self p_setupGameStatus]; // 更新比赛进行状态
    } WithErrorBlock:^(id errorCode) {
        [SVProgressHUD showInfoWithStatus:errorCode];
    } WithFailureBlock:^{
        [SVProgressHUD dismiss];
    }];
    [voiceViewModel sendCurrentStageData];
}

- (BOOL)p_refuseIfDivideAndLastStage {
    NSDictionary *gameTableDict = [self.tSDBManager getObjectById:GameId fromTable:GameTable];
    // 5V5平分
    
    if ([gameTableDict[CurrentStage] isEqualToString:OverTime3] && [self.gameModel.scoreTotalH isEqualToString:self.gameModel.scoreTotalG] ) {
        // 最后一节，比分相同，不能结束比赛
        return YES;
    }
    
    return NO;
}

- (void)p_updateCurrentStageIfSendDataSuccess { // 本节数据提交成功后，更新节数
    NSMutableDictionary *gameTableDict = [[self.tSDBManager getObjectById:GameId fromTable:GameTable] mutableCopy];
    
    [StageAllArray enumerateObjectsUsingBlock:^(NSString *stageName, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([gameTableDict[CurrentStage] isEqualToString:stageName]) {
            if (idx == 6) { // 加时赛3（表示全场比赛彻底结束）
                gameTableDict[CurrentStageDataSubmitted] = @"1";
                
                
#pragma mark 比赛结束
                
                //                [self.submitSectionBtn setTitle:GameOver forState:UIControlStateNormal];
                //                [self p_pushFullManagerViewController];
            } else if (3 == idx || 4 == idx || 5 == idx) { // 第四节或者加时赛1或者加时赛2数据提交后，不自动进入加时赛
                gameTableDict[CurrentStage] = StageAllArray[idx + 1];
                gameTableDict[CurrentStageDataSubmitted] = @"0";
                
                
            } else if (idx < 3) {
                gameTableDict[CurrentStage] = StageAllArray[idx + 1];
                gameTableDict[CurrentStageDataSubmitted] = @"0";
            }
            *stop = YES;
        }
    }];
    
    
    [self.tSDBManager putObject:gameTableDict withId:GameId intoTable:GameTable];
    
    
    
}

- (void)p_setupGameStatus { // 设置比赛状态（结束或未结束）
    __block BOOL gameOver = NO;
    NSMutableDictionary *gameTableDict = [[self.tSDBManager getObjectById:GameId fromTable:GameTable] mutableCopy];
    
    if (2 == [gameTableDict[@"ruleType"] intValue]) { //3v3
        if (3 == [gameTableDict[@"sectionType"] intValue]) { // 1X10
            
            if ([gameTableDict[CurrentStage] isEqualToString:OverTime1]) {
                gameOver = YES;
            } else if ([gameTableDict[CurrentStage] isEqualToString:StageOne]) {
                if ((1 == [gameTableDict[CurrentStageDataSubmitted] intValue]) && ![self.gameModel.scoreTotalH isEqualToString:self.gameModel.scoreTotalG]) { // 比赛结束
                    gameOver = YES;
                }
            }
        } else if (4 == [gameTableDict[@"sectionType"] intValue]) { // 2X8
            if (1 == [gameTableDict[CurrentStageDataSubmitted] intValue]) {
                if ([gameTableDict[CurrentStage] isEqualToString:StageTwo] && ![self.gameModel.scoreTotalH isEqualToString:self.gameModel.scoreTotalG]) {
                    gameOver = YES;
                } else if ([gameTableDict[CurrentStage] isEqualToString:OverTime1]) {
                    gameOver = YES;
                }
            }
        }
    } else {
        [StageAllArray enumerateObjectsUsingBlock:^(NSString *stageCount, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([stageCount isEqualToString:gameTableDict[CurrentStage]]) {
                if (idx > 2) {
                    
                    if ((1 == [gameTableDict[CurrentStageDataSubmitted] intValue]) && ![self.gameModel.scoreTotalH isEqualToString:self.gameModel.scoreTotalG]) { // 比赛结束
                        gameOver = YES;
                    } else if ((1 == [gameTableDict[CurrentStageDataSubmitted] intValue]) && [stageCount isEqualToString:OverTime3]) {
                        gameOver = YES;
                    }
                }
            }
            
        }];
    }
    
    if (gameOver == YES) { // 比赛结束
        gameTableDict[GameStatus] = @"1";
        
    } else {
        gameTableDict[GameStatus] = @"0";
    }
    
    [self.tSDBManager putObject:gameTableDict withId:GameId intoTable:GameTable];
    
}


@end
