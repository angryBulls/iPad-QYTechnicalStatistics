//
//  QYChangeVC.m
//  QYTechnicalStatistics
//
//  Created by 孙中山 on 2017/9/7.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYChangeVC.h"
#import "QYRegistrationHeaderView.h"
#import "PlayerDataCell.h"
#import "TSPlayerModel.h"
#import "TSManagerPlayerModel.h"

@interface QYChangeVC ()<UITableViewDelegate,UITableViewDataSource,PlayerDataCellDelegate>

@property (nonatomic ,strong)TSDBManager *tSDBManager;


@property (nonatomic ,strong)UITableView *tableView;

@property (nonatomic ,strong)NSMutableArray *hostPlayerDataArray;
@property (nonatomic ,strong)NSMutableArray *guestPlayerDataArray;


@end

@implementation QYChangeVC


#pragma mark 懒加载
-(TSDBManager *)tSDBManager{
    if (_tSDBManager == nil) {
        _tSDBManager = [[TSDBManager alloc] init];
    }
    return _tSDBManager;
}

#pragma mark 页面处理
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden  = YES;
    [self initNavigation];
    [self initTableView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self p_setupHostPlayerData];
    [self p_setupGuestPlayerData];
    
    
}


- (void)p_setupHostPlayerData {
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
        
        [hostPlayerDataArray addObject:tPlayerModel];
        
        
    }];
    self.hostPlayerDataArray = hostPlayerDataArray;
    
}

- (void)p_setupGuestPlayerData {
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
        
        [guestPlayerDataArray addObject:tPlayerModel];
    }];
    self.guestPlayerDataArray = guestPlayerDataArray;
    
}


-(void)initNavigation{
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scaleW_ByPx(2048), scaleY_ByPx(128))];
    [self.view addSubview:header];
    header.backgroundColor = [UIColor colorWithHexRGB:@"#3F85FF" andAlpha:1];
    
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, scaleY_ByPx(69), scaleW_ByPx(2048), scaleH_ByPx(32))];
    [header addSubview:lable];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:scaleY_ByPx(30)];
    lable.textColor = [UIColor whiteColor];
    lable.text = @"修改本节比赛";

    
}

/** 设置tableView*/
-(void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(scaleX_ByPx(29), scaleY_ByPx(128), SCREEN_WIDTH-scaleX_ByPx(29)*2, SCREEN_HEIGHT-scaleY_ByPx(128)) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate  = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [self footerView];
    
    self.tableView.showsVerticalScrollIndicator = NO;
}

-(UIView *)footerView{
    UIView *view = [[UIView alloc] initWithFrame:scaleFrameMake(0, 0,SCREEN_WIDTH*2-29*2 , 59+59+86)];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:scaleFrameMake(868-29, 59, 310, 86)];
    [btn setBackgroundColor:[UIColor colorWithHexRGB:@"#5B97FF" andAlpha:1]];
    [btn setTitle:@"完成修改进入比赛" forState:UIControlStateNormal];
    btn.layer.cornerRadius = scaleX_ByPx(10);
    btn.clipsToBounds = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:scaleX_ByPx(32)];
    [btn addTarget:self action:@selector(finishChageData) forControlEvents:UIControlEventTouchUpInside];
    

    
    [view addSubview:btn];
    
    return view;
}

/*sectionHeader*/
-(void)initSectionHeaderByView:(UIView *)view{
    UIView *boardView = [[UIView alloc] initWithFrame:CGRectMake(0, scaleY_ByPx(235-88), SCREEN_WIDTH-scaleX_ByPx(29)*2, scaleY_ByPx(88))];
    [view addSubview:boardView];
    boardView.backgroundColor = [UIColor colorWithHexRGB:@"#F4F8FF" andAlpha:1];
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scaleY_ByPx(273), scaleY_ByPx(88))];
    [boardView addSubview:infoView];
    UILabel *changShangL = [[UILabel alloc] initWithFrame:CGRectMake(scaleY_ByPx(23), 0, scaleY_ByPx(76), scaleY_ByPx(88))];
    [infoView addSubview:changShangL];
    changShangL.text = @"场上";
    changShangL.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
    changShangL.textColor = [UIColor colorWithHexRGB:@"#414141" andAlpha:1];
    changShangL.textAlignment = NSTextAlignmentCenter;
    
    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(scaleX_ByPx(273/2-40+25), 0, scaleX_ByPx(80), scaleX_ByPx(88))];
    [infoView addSubview:nameL];
    nameL.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
    nameL.textAlignment = NSTextAlignmentCenter;
    nameL.textColor = [UIColor colorWithHexRGB:@"#414141" andAlpha:1];
    nameL.text = @"姓名";
    
    UILabel *numL = [[UILabel alloc] initWithFrame:CGRectMake(scaleX_ByPx(273-66), 0, scaleX_ByPx(66), scaleX_ByPx(88))];
    [infoView addSubview:numL];
    numL.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
    numL.text = @"号码";
    numL.textColor =[UIColor colorWithHexRGB:@"#414141" andAlpha:1];
    numL.textAlignment = NSTextAlignmentRight;
    
    UILabel *lanBanL = [[UILabel alloc] initWithFrame:scaleFrameMake(273, 0, 248, 88)];
    lanBanL.textAlignment  = NSTextAlignmentCenter;
    lanBanL.text = @"篮板";
    lanBanL.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
    lanBanL.textColor = [UIColor colorWithHexRGB:@"#414141" andAlpha:1];
    [boardView addSubview:lanBanL];
    
    UILabel *zhuGongL = [[UILabel alloc] initWithFrame:scaleFrameMake(273+249, 0, 248, 88)];
    zhuGongL.textAlignment  = NSTextAlignmentCenter;
    zhuGongL.text = @"助攻";
    zhuGongL.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
    zhuGongL.textColor = [UIColor colorWithHexRGB:@"#414141" andAlpha:1];
    [boardView addSubview:zhuGongL];
    
    UILabel *fanGuiL = [[UILabel alloc] initWithFrame:scaleFrameMake(273+249+249, 0, 248, 88)];
    fanGuiL.textAlignment  = NSTextAlignmentCenter;
    fanGuiL.text = @"犯规";
    fanGuiL.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
    fanGuiL.textColor = [UIColor colorWithHexRGB:@"#414141" andAlpha:1];
    [boardView addSubview:fanGuiL];
    
    UILabel *GaiMaoL = [[UILabel alloc] initWithFrame:scaleFrameMake(273+249+249+249, 0, 248, 88)];
    GaiMaoL.textAlignment  = NSTextAlignmentCenter;
    GaiMaoL.text = @"盖帽";
    GaiMaoL.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
    GaiMaoL.textColor = [UIColor colorWithHexRGB:@"#414141" andAlpha:1];
    [boardView addSubview:GaiMaoL];
    
    UILabel *oneL = [[UILabel alloc] initWithFrame:scaleFrameMake(273+249+249+249+249, 0, 248, 88)];
    oneL.textAlignment  = NSTextAlignmentCenter;
    oneL.text = @"1 分";
    oneL.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
    oneL.textColor = [UIColor colorWithHexRGB:@"#414141" andAlpha:1];
    [boardView addSubview:oneL];
    
    UILabel *twoL = [[UILabel alloc] initWithFrame:scaleFrameMake(273+249+249+249+249+249, 0, 248, 88)];
    twoL.textAlignment  = NSTextAlignmentCenter;
    twoL.text = @"2 分";
    twoL.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
    twoL.textColor = [UIColor colorWithHexRGB:@"#414141" andAlpha:1];
    [boardView addSubview:twoL];
    
    UILabel *threeL = [[UILabel alloc] initWithFrame:scaleFrameMake(273+249+249+249+249+249+249, 0, 248, 88)];
    threeL.textAlignment  = NSTextAlignmentCenter;
    threeL.text = @"3 分";
    threeL.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
    threeL.textColor = [UIColor colorWithHexRGB:@"#414141" andAlpha:1];
    [boardView addSubview:threeL];
    
}


#pragma mark 网络请求

#pragma mark - PlayerDataCellDelegate
-(void)changePlayerDataAction:(TSManagerPlayerModel *)playerModel dataType:(NSString *)dataType andNewValue:(NSInteger)newValue{
    // 确定修改数据
    NSString *returnValue = [NSString stringWithFormat:@"%ld",newValue];
    [self.tSDBManager updateDBPlayerTabelByPlayerId:playerModel.playerId dataType:dataType newValue:returnValue successReturnBlock:^{
        
    }];
    
    
}
#pragma mark 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _hostPlayerDataArray.count;
    }
    return _guestPlayerDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayerDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PlayerDataCell" owner:self options:nil].firstObject;
    }
    cell.contentView.backgroundColor = [UIColor colorWithHexRGB:@"#D9E2F3" andAlpha:0.88f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section) {
        cell.tPlayModel = _guestPlayerDataArray[indexPath.row];
    }
    else{
        cell.tPlayModel = _hostPlayerDataArray[indexPath.row];
    }
    cell.delegate = self;
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-scaleX_ByPx(29)*2, scaleY_ByPx(235))];
    UILabel *teamLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, scaleY_ByPx(46), SCREEN_WIDTH-scaleX_ByPx(29)*2, scaleY_ByPx(72))];
    [header addSubview:teamLabel];
    if (section) {
        teamLabel.text = @"客    队";
         teamLabel.backgroundColor = [UIColor colorWithHexRGB:@"#FF7976" andAlpha:1];
    }
    else{
        teamLabel.text = @"主    队";
        teamLabel.backgroundColor = [UIColor colorWithHexRGB:@"#49D5A6" andAlpha:1];
    }
    teamLabel.textAlignment = NSTextAlignmentCenter;
    teamLabel.textColor = [UIColor whiteColor];
    teamLabel.font = [UIFont systemFontOfSize:scaleY_ByPx(36)];
    teamLabel.layer.cornerRadius = 3;
    teamLabel.clipsToBounds = YES;
    
    [self initSectionHeaderByView:header];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return scaleY_ByPx(235);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return scaleH_ByPx(144);
}

#pragma mark 点击事件
-(void)finishChageData{
    if (self.delegate && [_delegate respondsToSelector:@selector(finishChange)]) {
        [_delegate finishChange];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
