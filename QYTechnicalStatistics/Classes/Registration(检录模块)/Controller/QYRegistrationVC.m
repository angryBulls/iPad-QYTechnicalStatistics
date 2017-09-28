//
//  QYRegistrationVC.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/13.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//  

#import "QYRegistrationVC.h"
#import "QYRegistrationCell.h"
#import "QYRegistrationHeaderView.h"
#import "QYStatisticsVC.h"
#import "TSPlayerModel.h"
#import "YTKKeyValueStore.h"
#import "PlayerCheckViewModel.h"
#import "Player.h"
#import "GameCheckViewModel.h"
@interface QYRegistrationVC ()<QYRegistrationHeaderViewDelegate,UICollectionViewDelegate,QYRegistrationCellDelegate>

/**
 *  头部视图
 */
@property (nonatomic, strong) QYRegistrationHeaderView * registrationHeaderView;
/**
 *  进入比赛按钮
 */
@property (strong, nonatomic) UIButton * enterButton;
@property (nonatomic ,strong) NSMutableArray *hostDataSouce;
@property (nonatomic ,strong) NSMutableArray *guestDataSouce;
@property (nonatomic ,strong) UIView *footerView;
/**
 *  进入比赛判断
 */

@property (nonatomic ,strong) NSMutableDictionary * matchInfoDic;

@property (nonatomic ,strong) NSMutableArray *hostTeam;
@property (nonatomic ,strong) NSMutableArray *guestTeam;
/**
 *数据库
 */
@property (nonatomic, strong) NSMutableArray *playerArrayH;
@property (nonatomic, strong) NSMutableArray *playerArrayG;

@end
@implementation QYRegistrationVC

// 重用ID
static NSString * const registrationCell = @"registrationCell";


// initialization func
+ (instancetype)getRegistrationVC {
    
    QYRegistrationVC * registrationVC = [[QYRegistrationVC alloc] init];
    registrationVC.automaticallyAdjustsScrollViewInsets = NO;
    return registrationVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // register
    [self.collectionView registerClass:[QYRegistrationCell class]
            forCellWithReuseIdentifier:registrationCell];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHid)];
    [self.view addGestureRecognizer:tap];
    
    
    
}


/** 设置头尾部是图 */
- (void)headerViewSettings {
    
    // 设置头尾部视图
    [self.registrationHeaderView scaleFrameMake:0 :0 :2048 :265];
    self.collectionView.contentInset =
    UIEdgeInsetsMake(scaleY_ByPx(265), 0, scaleY_ByPx(265), 0);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
//    return 15;
    if (section == 0) {
        return _playerArrayH.count;
    }
    
    return _playerArrayG.count;
    
}


- (QYRegistrationCell *)collectionView:(UICollectionView *)collectionView
                cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QYRegistrationCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:registrationCell
                                              forIndexPath:indexPath];
    
    
    if (indexPath.section) {
        cell.p = _playerArrayG[indexPath.row];
       
    }
    else
    {
        cell.p = _playerArrayH[indexPath.row];
        
    }
    cell.section = indexPath.section;
    cell.row = indexPath.row;
    cell.delegate = self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section  == 0) {
        return CGSizeMake(0, 0);
    }
    
    return CGSizeMake(scaleX_ByPx(2048) , scaleX_ByPx(250));
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader ) {
    // 创建分组头视图
    QYRegistrationSecHeaderV *  secHeadView =
    [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                       withReuseIdentifier:@"secHeaderView"
                                              forIndexPath:indexPath];
    
    // 设置分组头视图
    [secHeadView settingWithIndexPath:indexPath];
    return secHeadView;
    }
    else if(kind == UICollectionElementKindSectionFooter && indexPath.section == 1){
        
     UICollectionReusableView *reusableView =   [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                           withReuseIdentifier:@"secFooterView"
                                                  forIndexPath:indexPath];
        
        [reusableView addSubview:self.footerView];
        return reusableView;
        
    }
    
    return nil;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    // 设置头部是图
    [self headerViewSettings];
}


#pragma mark <QYRegistrationHeaderViewDelegate>

-(void)backPlayInfosByArr:(NSArray *)arr andTeam:(NSInteger)team{
    if (team) {
        [self.guestTeam removeAllObjects];
        //客队
        _guestDataSouce = (NSMutableArray *)arr;
        [self.playerArrayG removeAllObjects];
        for (Player *p in _guestDataSouce) {
            TSPlayerModel *playerModel = [TSPlayerModel new];
            playerModel.gameNum = p.gameNum;
            playerModel.isStartPlayer = p.isOn?@"是":@"否";
            playerModel.playingTimes = p.playingTimes;
            playerModel.playingStatus = @"0";
            playerModel.playerNumber =[NSString stringWithFormat:@"%@",p.playerNumber];
            playerModel.photo = p.photo;
            playerModel.ID = p.pid;
            playerModel.name = p.playName;
            playerModel.positional = p.positional;
            if (self.playerArrayH.count ) {
                TSPlayerModel *pp = self.playerArrayH[0];
                if ([pp.ID isEqualToString:playerModel.ID]) {
                    [SVProgressHUD showInfoWithStatus:@"主队客队不能为同一个"];
                    return;
                }
            }
            [self.playerArrayG addObject:playerModel];
        }
        
        
    }
    else
    {
        [self.hostTeam removeAllObjects];
        //主队
        _hostDataSouce =(NSMutableArray *)arr;
        [self.playerArrayH removeAllObjects];
        for (Player *p in _hostDataSouce) {
            TSPlayerModel *playerModel = [TSPlayerModel new];
            playerModel.gameNum = p.gameNum;
            playerModel.isStartPlayer = p.isOn?@"是":@"否";
            playerModel.playingTimes = p.playingTimes;
            playerModel.playingStatus = @"0";
            playerModel.name = p.playName;
            playerModel.playerNumber =[NSString stringWithFormat:@"%@",p.playerNumber];
            playerModel.photo = p.photo;
            playerModel.ID = p.pid;
            playerModel.positional = p.positional;
            
            if (self.playerArrayG.count ) {
                TSPlayerModel *pp = self.playerArrayG[0];
                if ([pp.ID isEqualToString:playerModel.ID]) {
                    [SVProgressHUD showInfoWithStatus:@"主队客队不能为同一个"];
                    return;
                }
            }
            
            
            [self.playerArrayH addObject:playerModel];
            
        }
        
        
    }
    [_collectionView reloadData];
}


#pragma mark <QYRegistrationCellDelegate>
-(void)BackPlayerWithPlayer:(TSPlayerModel *)p andSection:(NSInteger)section andRow:(NSInteger)row{
    
    if (section) {

        [_playerArrayG replaceObjectAtIndex:row withObject:p];
        
        if ([p.isStartPlayer isEqualToString:@"是"] && ![self.guestTeam containsObject:p]) {
            [self.guestTeam addObject:p];
        }
        else if (![p.isStartPlayer isEqualToString:@"是"] && [self.guestTeam containsObject:p]){
            [self.guestTeam removeObject:p];
        }
    }
    else
    {

        [_playerArrayH replaceObjectAtIndex:row withObject:p];
        
        if ([p.isStartPlayer isEqualToString:@"是"] && ![self.hostTeam containsObject:p]) {
            [self.hostTeam addObject:p];
        }
        else if (![p.isStartPlayer isEqualToString:@"是"] && [self.hostTeam containsObject:p]){
            [self.hostTeam removeObject:p];
        }
        
    }
    
}


#define mark - lazy
-(TSCheckModel *)checkModel{
    if (_checkModel == nil) {
        _checkModel = [TSCheckModel new];
    }
    return _checkModel;
}


- (NSMutableArray *)playerArrayH {
    if (!_playerArrayH) {
        _playerArrayH = [NSMutableArray array];
    }
    return _playerArrayH;
}

- (NSMutableArray *)playerArrayG {
    if (!_playerArrayG) {
        _playerArrayG = [NSMutableArray array];
    }
    return _playerArrayG;
}


-(NSMutableArray *)hostTeam{
    if (_hostTeam == nil) {
        _hostTeam = [NSMutableArray array];
    }
    
    return _hostTeam;
}

-(NSMutableArray *)guestTeam{
    if (_guestTeam == nil) {
        _guestTeam = [NSMutableArray array];
    }
    
    return _guestTeam;
}


-(NSMutableDictionary *)matchInfoDic{
    if (_matchInfoDic == nil) {
        _matchInfoDic = [NSMutableDictionary dictionary];
    }
    
    return _matchInfoDic;
}

-(NSMutableArray *)HostDataSouce{
    if (_hostDataSouce == nil) {
        _hostDataSouce = [NSMutableArray array];
    }
    return _hostDataSouce;
}
-(NSMutableArray *)guestDataSouce{
    
    if (_guestDataSouce == nil) {
        _guestDataSouce = [NSMutableArray array];
    }
    return _guestDataSouce;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        // 布局设置
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(scaleW_ByPx(300), scaleH_ByPx(226+50+10));
        flowLayout.headerReferenceSize = // 设置分组头视图大小
        CGSizeMake(scaleW_ByPx(2048), scaleH_ByPx(38+42+72));
        
                                         // 设置检录列表两侧边距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, scaleX_ByPx(103), 0, scaleX_ByPx(103));
        flowLayout.minimumInteritemSpacing = scaleW_ByPx(43);
        flowLayout.minimumLineSpacing = scaleH_ByPx(56);
        
        // colloctionView 创建
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kMAIN_SCREEN_SIZE.width, kMAIN_SCREEN_SIZE.height) collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        self.collectionView = collectionView;
        [self.view addSubview:collectionView];
        
    }
    return _collectionView;
}

-(UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:scaleFrameMake(0, 0, 2048, 250)];
        [self.enterButton scaleCenterBoundsMake:CGScaleGetWidth(_footerView.frame)/2
                                               :CGScaleGetHeight(_footerView.frame)-100
                                               :326
                                               :100];
    }
    
    return _footerView;
}

- (QYRegistrationHeaderView *)registrationHeaderView {
    
    if (!_registrationHeaderView) {
        _registrationHeaderView = [QYRegistrationHeaderView initializeHeaderView];
        _registrationHeaderView.delegate = self;
        [self.view addSubview:_registrationHeaderView];
    }
    return _registrationHeaderView;
}

- (UIButton *)enterButton {
    
    if (!_enterButton) {
        
        _enterButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_enterButton setBackgroundImage:[UIImage imageNamed:@"人员检录1_24"]
                                forState:(UIControlStateNormal)];
        [_enterButton setTitleColor:[UIColor whiteColor]
                           forState:(UIControlStateNormal)];
        [_enterButton setTitle:@"进入比赛" forState:(UIControlStateNormal)];
        [_enterButton addTarget:self action:@selector(enterClick:)
               forControlEvents:(UIControlEventTouchUpInside)];
        _enterButton.titleLabel.font = kSCALE_BOLD_FONT(15);
        [self.footerView addSubview:_enterButton];
    }
    return _enterButton;
}

- (void)enterClick:(UIButton *)button {
    
    if (_registrationHeaderView.mainRefereeNameLabel.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写主裁判"];
        
        return;
    }
    else if (_registrationHeaderView.firstDeputyRefereeNameLabel.text.length == 0){
        [SVProgressHUD showInfoWithStatus:@"请填写第一副裁"];
        
        return;
    }
    else if (_registrationHeaderView.secondDeputyRefereeNameLabel.text.length == 0){
        [SVProgressHUD showInfoWithStatus:@"请填写第二副裁"];
        
        return;
    }
    else if (_registrationHeaderView.technicalRepresentativeNameLabel.text.length == 0){
        [SVProgressHUD showInfoWithStatus:@"请填写技术代表"];
        
        return;

    }
    else if (_registrationHeaderView.technicalStatisticsNameLabel_01.text.length == 0){
        [SVProgressHUD showInfoWithStatus:@"请填写技术统计01"];
        
        return;
    }
    else if (_registrationHeaderView.technicalStatisticsNameLabel_02.text.length == 0){
        [SVProgressHUD showInfoWithStatus:@"请填写技术统计02"];
        
        return;
        
    }
    
    else if(_hostTeam.count !=5){
        NSLog(@"%ld",_hostTeam.count);
        [SVProgressHUD showInfoWithStatus:@"请确认主队上场队员为5个"];
        
        return;
    }
    else if (_guestTeam.count !=5){
        NSLog(@"%ld",_guestTeam.count);
        [SVProgressHUD showInfoWithStatus:@"请确认客队上场队员为5个"];

        return;
    }

    
    // 检测“本场号码”是否有重复
    NSMutableArray *gameNumbArrayH = [NSMutableArray array];
    [self.playerArrayH enumerateObjectsUsingBlock:^(TSPlayerModel *playerModel, NSUInteger idx, BOOL * _Nonnull stop) {
        [gameNumbArrayH addObject:playerModel.gameNum];
        
    }];
    NSSet *gameNumbSetH = [NSSet setWithArray:gameNumbArrayH];
    
    if (gameNumbArrayH.count != gameNumbSetH.count) {
        [SVProgressHUD showInfoWithStatus:@"主队有重复号码"];
        
        return;
    }
    
    NSMutableArray *gameNumbArrayG = [NSMutableArray array];
    [self.playerArrayG enumerateObjectsUsingBlock:^(TSPlayerModel *playerModel, NSUInteger idx, BOOL * _Nonnull stop) {
        [gameNumbArrayG addObject:playerModel.gameNum];
        
        
    }];
    
    
    NSSet *gameNumbSetG = [NSSet setWithArray:gameNumbArrayG];
    
    
    if (gameNumbArrayG.count != gameNumbSetG.count) {
        
        [SVProgressHUD showInfoWithStatus:@"客队有重复号码"];
        return;
    }
    [self p_initCheckModel];
    [self p_getBCBCMatchId];
    
    
}

-(void)keyboardHid{
    [self.view endEditing:YES];
}

-(void)p_initCheckModel{
    self.checkModel.gameLevel = [(UIButton *)_registrationHeaderView.competitionLevelButton titleForState:UIControlStateNormal];
    _checkModel.gameArea = [(UIButton *)_registrationHeaderView.competitionAreaButton titleForState:UIControlStateNormal];
    _checkModel.gameProvince = [(UIButton *)_registrationHeaderView.provinceAndCityButton titleForState:UIControlStateNormal];
    Player *pH = _hostDataSouce.firstObject;
    _checkModel.teamIdH = pH.teamID;
    _checkModel.teamCoachH = pH.coach;
    _checkModel.teamNameH = [(UIButton *)_registrationHeaderView.hostTeamButton titleForState:UIControlStateNormal ];
    Player *pG = _guestDataSouce.firstObject;
    _checkModel.teamIdG = pG.teamID;
    _checkModel.teamCoachG = pG.coach;
    _checkModel.teamNameG = [(UIButton *)_registrationHeaderView.guestTeamButton titleForState:UIControlStateNormal];
    
    _checkModel.teamColorH = @"红色";
    _checkModel.teamColorG = @"蓝色";
    _checkModel.mainReferee = _registrationHeaderView.mainRefereeNameLabel.text;
    _checkModel.firstReferee = _registrationHeaderView.firstDeputyRefereeNameLabel.text;
    _checkModel.secondReferee = _registrationHeaderView.secondDeputyRefereeNameLabel.text;
    _checkModel.td = _registrationHeaderView.technicalRepresentativeNameLabel.text;
    _checkModel.ts01 = _registrationHeaderView.technicalStatisticsNameLabel_01.text;
    _checkModel.ts02 = _registrationHeaderView.technicalStatisticsNameLabel_02.text;
    
    
    
}




- (void)p_getBCBCMatchId { // 获取matchId成功才能继续
    [SVProgressHUD show];
    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
    GameCheckViewModel *checkViewModel = [[GameCheckViewModel alloc] initWithPramasDict:paramsDict];
    [checkViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        if (returnValue[@"entity"][@"matchId"]) {
            
            self.checkModel.matchId = returnValue[@"entity"][@"matchId"];
            
            
            [self p_initTSDB];
            [SVProgressHUD dismiss];
        } else {
            [SVProgressHUD showInfoWithStatus:@"获取比赛id失败，请重试"];
        }
    } WithErrorBlock:^(id errorCode) {
        [SVProgressHUD showInfoWithStatus:errorCode];
    } WithFailureBlock:^{
        
    }];
    [checkViewModel getBCBCMatchId];
}




- (void)p_initTSDB {
    NSMutableDictionary *gameCheckDict = self.checkModel.mj_keyValues;
    
    NSMutableArray *playerArrayH = [TSPlayerModel mj_keyValuesArrayWithObjectArray:self.playerArrayH];
    
    NSMutableArray *playerArrayG = [TSPlayerModel mj_keyValuesArrayWithObjectArray:self.playerArrayG];
    
    // 创建数据库和数据库表
    NSString *documentsPath = nil;
    
    
    NSArray *appArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([appArray count] > 0) {
        NSLog(@"ssssss");
        documentsPath = [appArray objectAtIndex:0];
    }
    
    NSLog(@"%ld ----  --  %@",appArray.count,documentsPath);
    
    NSString *tsdbPath = [documentsPath stringByAppendingString:[NSString stringWithFormat:@"/%@", TSDBName]];
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initWithDBWithPath:tsdbPath];
    
    
    [store createTableWithName:TSCheckTable]; // 创建检录数据表
    // 往检录数据表中插入“赛前检录”数据
    
    [store putObject:gameCheckDict withId:GameCheckID intoTable:TSCheckTable];
    // 往检录数据表中插入“主队球员检录”数据
    [store putObject:playerArrayH withId:TeamCheckID_H intoTable:TSCheckTable];
    // 往检录数据表中插入“客队球员检录”数据
    [store putObject:playerArrayG withId:TeamCheckID_G intoTable:TSCheckTable];

    
    [store createTableWithName:GameTable];
    // 往“比赛数据表”中写入第一节标记
    NSMutableDictionary *gameTableDict = [NSMutableDictionary dictionary];
    gameTableDict[CurrentStage] = StageOne;
    gameTableDict[CurrentStageDataSubmitted] = @"0";
    gameTableDict[@"matchInfoId"] = self.checkModel.matchId;
    gameTableDict[lastTime] = [NSString stringWithFormat:@"%d",StageGameTimes];
    
    [store putObject:gameTableDict withId:GameId intoTable:GameTable];
    
    
    [store createTableWithName:PlayerTable];
    
    [store createTableWithName:PlayerIdTable]; // 创建一张球员id表，用于查询球员表中的数据
    
    // 根据“球员检录”信息，往“球员id表”中写入数据
    NSMutableArray *playerIdArray = [NSMutableArray array];
    [self.playerArrayH enumerateObjectsUsingBlock:^(TSPlayerModel *playerModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableDictionary *playerIdDict = [NSMutableDictionary dictionary];
        [playerIdDict setObject:playerModel.ID forKey:[NSString stringWithFormat:@"%@+%@", @"0", playerModel.gameNum]];
        
        [playerIdArray addObject:playerIdDict];
    }];
    
    [self.playerArrayG enumerateObjectsUsingBlock:^(TSPlayerModel *playerModel, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *playerIdDict = [NSMutableDictionary dictionary];
        [playerIdDict setObject:playerModel.ID forKey:[NSString stringWithFormat:@"%@+%@", @"1", playerModel.gameNum]];
        [playerIdArray addObject:playerIdDict];
    }];
    
    [store putObject:playerIdArray withId:GameId intoTable:PlayerIdTable];
    
    
    [(AppDelegate *)[UIApplication sharedApplication].delegate setVoicePageBeRootView];

    
}



@end
