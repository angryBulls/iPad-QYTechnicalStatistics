//
//  QYJsonPasser.m
//  QYTechnicalStatistics
//
//  Created by 孙中山 on 2017/9/11.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYJsonPasser.h"
#import "QYTeam.h"
#import "Player.h"
@implementation QYJsonPasser
/**
 获取球队
 */
+(NSMutableArray *)getTeamInfoByDic:(NSDictionary *)dic{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *entityDic = dic[@"entity"];
    NSArray *teamInfos = entityDic[@"teamInfos"];
    for (NSDictionary *teamInfoDic in teamInfos) {
        QYTeam *t = [[QYTeam alloc] init];
        t.tID = teamInfoDic[@"id"];
        t.name  = teamInfoDic[@"name"];
        t.logo = teamInfoDic[@"logo"];
        t.translator  = teamInfoDic[@"translator"];
        t.playZone = teamInfoDic[@"playZone"];
        [arr addObject:t];
    }
    
    return arr;
}


/**
 *获得球队球员
 */
+(NSMutableArray *)queryPlayByTeam:(NSDictionary *)dic{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *entityDic = dic[@"entity"];
    NSArray *palyInfos = entityDic[@"playInfos"];
    for (NSDictionary *playDic in palyInfos) {
        Player *p = [Player new];
        p.birthday = playDic[@"birthday"];
        p.height = playDic[@"height"];
        p.pid = playDic[@"id"];
        p.playName = playDic[@"name"];
        p.photo = playDic[@"photo"];
        p.pinyin = playDic[@"pinyin"];
        p.playerNumber = playDic[@"playerNumber"];
        p.positional = playDic[@"positional"];
        p.userId = playDic[@"userId"];
        p.weight = playDic[@"weight"];
        [arr addObject:p];
    }
    
    
    return arr;
}


@end
