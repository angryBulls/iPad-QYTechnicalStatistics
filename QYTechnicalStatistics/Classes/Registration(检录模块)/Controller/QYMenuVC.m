//
//  QYMenuVC.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/6.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYMenuVC.h"
#import "QYJsonPasser.h"
#import "QYTeam.h"
@interface QYMenuVC ()

@property (nonatomic, copy) ClickBlock clickBlock;
@property (nonatomic, copy) TeamBlock teamBlock;
@property (nonatomic ,strong)NSMutableArray *dataSouceArr;
@end

@implementation QYMenuVC

/* initialization method **/
+ (instancetype)createMenuWithClickBlock:(ClickBlock)clickBlock AndTeamBlock:(TeamBlock)teamBlock{
    
    QYMenuVC * menuVC = [[QYMenuVC alloc] init];
    
    menuVC.clickBlock = clickBlock;
    menuVC.teamBlock = teamBlock;
    return menuVC;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
#pragma mark -lazy


#pragma mark - < UITableViewDataSource >

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if ([_dataSouce[indexPath.row] isKindOfClass:[NSString class]]) {
        
        cell.textLabel.text =_dataSouce[indexPath.row];
    }
    else
    {
        QYTeam *t = _dataSouce[indexPath.row];
        
        cell.textLabel.text = t.name;
        
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

#pragma mark - < UITableViewDelegate >

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self tableView:tableView
                      cellForRowAtIndexPath:indexPath];
    self.clickBlock(cell.textLabel.text);
    if (_buttonTag == 0) {
        
        [QYNetworkManger getTeamInfoFinalMatch:nil responseSuccess:^(id responseObject) {
            
            self.dataSouce =  [QYJsonPasser getTeamInfoByDic:responseObject];
            self.teamBlock(self.dataSouce);
            [self dismissViewControllerAnimated:YES completion:nil];
        } responseFailed:^(NSError *error) {
            
        }];

    }
   else if (_buttonTag == 1) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:cell.textLabel.text forKey:@"zoneName"];
        [QYNetworkManger getTeamInfoByZone:dic responseSuccess:^(id responseObject) {
            
            self.dataSouce =  [QYJsonPasser getTeamInfoByDic:responseObject];
            self.teamBlock(self.dataSouce);
            [self dismissViewControllerAnimated:YES completion:nil];
        } responseFailed:^(NSError *error) {
            
        }];
    }
    else if (_buttonTag == 2){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:cell.textLabel.text forKey:@"province"];
        
        
        [ QYNetworkManger getTeamInfoByProvence:dic responseSuccess:^(id responseObject) {
            
            self.dataSouce =  [QYJsonPasser getTeamInfoByDic:responseObject];
            
            self.teamBlock(self.dataSouce);
            [self dismissViewControllerAnimated:YES completion:nil];
        } responseFailed:^(NSError *error) {
            
        }];

        
    }
    else if (_buttonTag == 3) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        QYTeam *team = _dataSouce[indexPath.row];
        dic[@"teamId"] = team.tID;
        
        [QYNetworkManger queryPlayByTeam:dic responseSuccess:^(id responseObject) {
            
            self.dataSouce =  [QYJsonPasser queryPlayByTeam:responseObject andTeamID:[NSString stringWithFormat:@"%@", team.tID]];
            
            self.teamBlock(self.dataSouce);
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } responseFailed:^(NSError *error) {
            
        }];
        
    }
    else if (_buttonTag == 4) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        QYTeam *team = _dataSouce[indexPath.row];
        dic[@"teamId"] = team.tID;
        [QYNetworkManger queryPlayByTeam:dic responseSuccess:^(id responseObject) {
            
            self.dataSouce =  [QYJsonPasser queryPlayByTeam:responseObject andTeamID:[NSString stringWithFormat:@"%@", team.tID]];
            
            self.teamBlock(self.dataSouce);
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } responseFailed:^(NSError *error) {
            
        }];
        
    }
    
    
    else{
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    
    
}

@end
