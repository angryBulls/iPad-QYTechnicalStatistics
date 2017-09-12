//
//  QYFinishMatchVC.m
//  QYTechnicalStatistics
//
//  Created by 孙中山 on 2017/9/7.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYFinishMatchVC.h"
#import "QYFinishCell.h"

#define LabelW (1024 -29)/7
#define Label2W (1024 -29)*2/9
#define LabelH self.frame.size.height *2
@interface QYFinishMatchVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *dataSouce;

@end

@implementation QYFinishMatchVC
#pragma mark 懒加载

-(NSMutableArray *)dataSouce{
    if (_dataSouce == nil) {
        _dataSouce = [NSMutableArray array];
    }
    
    return _dataSouce;
}

#pragma mark 页面处理
- (void)viewDidLoad {
    [super viewDidLoad];
//    _finisnTag = 1;
    self.navigationController.navigationBar.hidden  = YES;
    [self initNavigation];
    [self initTableView];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)initNavigation{
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scaleW_ByPx(2048), scaleY_ByPx(256))];
    [self.view addSubview:header];
    header.backgroundColor = [UIColor colorWithHexRGB:@"#3F85FF" andAlpha:1];
    
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(scaleX_ByPx(31), scaleY_ByPx(61), SCREEN_WIDTH, scaleH_ByPx(31))];
    [header addSubview:lable];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:scaleY_ByPx(32)];
    lable.textColor = [UIColor whiteColor];
    lable.text = @"比赛时间：2017-05-21 10:00";
    
    UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(scaleX_ByPx(31), scaleY_ByPx(129), SCREEN_WIDTH, scaleH_ByPx(31))];
    [header addSubview:lable2];
    lable2.textAlignment = NSTextAlignmentLeft;
    lable2.font = [UIFont systemFontOfSize:scaleY_ByPx(32)];
    lable2.textColor = [UIColor whiteColor];
    lable2.text = @"[大区赛] —— [东南赛区] —— [安徽市] —— [主场：传奇队] —— [客场：老鹰队]";
    
    UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(scaleX_ByPx(31), scaleY_ByPx(194), SCREEN_WIDTH, scaleH_ByPx(31))];
    [header addSubview:lable3];
    lable3.textAlignment = NSTextAlignmentLeft;
    lable3.font = [UIFont systemFontOfSize:scaleY_ByPx(32)];
    lable3.textColor = [UIColor whiteColor];
    lable3.text = @"[主裁判:王宇龙] —— [第一副裁:王宇龙] —— [第二副裁:王宇龙] —— [技术代表:王宇龙] —— [技术统计:王宇";
    
}

-(UIView *)creatFinshHeader{
    UIView *header = [[UIView alloc] initWithFrame:scaleFrameMake(29, 256, SCREEN_WIDTH*2 - 29*2, 728-256)];
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:scaleFrameMake(0, 0, 2048-29*2 , 91)];
    firstLabel.textAlignment = NSTextAlignmentCenter;
    firstLabel.text = @"比赛结果";
    firstLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:scaleX_ByPx(34)];
    
    [header addSubview:firstLabel];
    
    NSArray *array1 = @[@"双方",@"第一节",@"第二节",@"第三节",@"第四节",@"加时 1",@"加时 2",@"加时 3",@"总得分"];
    NSArray *array2 = @[@"雄鹰队",@"59",@"59",@"59",@"59",@"0",@"0",@"0",@"59"];
    NSArray *array3 = @[@"遨游队",@"55",@"56",@"56",@"56",@"0",@"0",@"0",@"56"];
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
    if (_finisnTag<AddOne) {
        header.text = [NSString stringWithFormat:@"第%ld节",_finisnTag];
    }
    else
    {
        header.text = [NSString stringWithFormat:@"加时赛%ld",_finisnTag];
        
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
    if (_finisnTag == GameFinish) {
        _tableView.tableHeaderView = [self creatFinshHeader];
    }
    else{
        _tableView.tableHeaderView = [self creatLessionHeader];
    }
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
}
-(UIView *)footerView{
    UIView *view = [[UIView alloc] initWithFrame:scaleFrameMake(0, 0,SCREEN_WIDTH*2-29*2 , 59+59+86)];
    
    if (_finisnTag) {
        UIButton *btn = [[UIButton alloc] initWithFrame:scaleFrameMake(568-29, 59, 310, 86)];
        [btn setBackgroundColor:[UIColor colorWithHexRGB:@"#5B97FF" andAlpha:1]];
        [btn setTitle:@"提交本节比赛" forState:UIControlStateNormal];
        btn.layer.cornerRadius = scaleX_ByPx(10);
        btn.clipsToBounds = YES;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:scaleX_ByPx(32)];
        [btn addTarget:self  action:@selector(tiJiao) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:scaleFrameMake(1081-29, 59, 310, 86)];
        [btn2 setBackgroundColor:[UIColor colorWithHexRGB:@"#5B97FF" andAlpha:1]];
        [btn2 setTitle:@"进入加时赛" forState:UIControlStateNormal];
        btn2.layer.cornerRadius = scaleX_ByPx(10);
        btn2.clipsToBounds = YES;
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn2.titleLabel.font = [UIFont systemFontOfSize:scaleX_ByPx(32)];
        [btn2 addTarget:self action:@selector(joinOverTime) forControlEvents:UIControlEventTouchUpInside];
        
        
        [view addSubview:btn2];
        
    }
    else{
        
        UIButton *btn = [[UIButton alloc] initWithFrame:scaleFrameMake(868-29, 59, 310, 86)];
        [btn setBackgroundColor:[UIColor colorWithHexRGB:@"#5B97FF" andAlpha:1]];
        [btn setTitle:@"保存并退出" forState:UIControlStateNormal];
        btn.layer.cornerRadius = scaleX_ByPx(10);
        btn.clipsToBounds = YES;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:scaleX_ByPx(32)];
        [btn addTarget:self action:@selector(finishChageData) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:btn];
        
    }
    
    
    return view;
}

#pragma mark 代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 14;
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
    if (section) {
        infoLabel.text = @"遨游队   主教练：李大志";
    }
    else{
        infoLabel.text = @"雄鹰队   主教练：王大志";
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
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)joinOverTime{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
