//
//  QYJsonPasser.h
//  QYTechnicalStatistics
//
//  Created by 孙中山 on 2017/9/11.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYJsonPasser : NSObject
/**
 获取球队
 */
+(NSMutableArray *)getTeamInfoByDic:(NSDictionary *)dic;

/**
 *获得球队球员
 */
+(NSMutableArray *)queryPlayByTeam:(NSDictionary *)dic andTeamID:(NSString *)teamID;
@end
