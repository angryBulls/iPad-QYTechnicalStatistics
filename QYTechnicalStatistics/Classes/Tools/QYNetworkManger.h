//
//  QYNetworkManger.h
//  QY
//
//  Created by lxd on 2017/2/20.
//  Copyright © 2017年 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Success)(id responseObject);
typedef void (^Failed)(NSError * error);

@interface QYNetworkManger : NSObject

/**
 *获得球队球员
 */
+(void)queryPlayByTeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;

/**
 * 登录接口
 */
+ (void)startLogin:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;

/**
 * 登出接口
 */
+ (void)loginOut:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;

/**
 获取决赛球队
 */
+ (void)getTeamInfoFinalMatch:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;


/**
 获取大区球队
 */
+ (void)getTeamInfoByZone:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;

/**
 获取地区球队
 */
+ (void)getTeamInfoByProvence:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
/**
 *根据球队获取球员
 */
+ (void)getPlaysDataByTeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;

/**
 * 提交单节数据
 */
+ (void)sendCurrentStageDataBCBC:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;

/**
 * 
 */
+ (void)abstention:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;


@end
