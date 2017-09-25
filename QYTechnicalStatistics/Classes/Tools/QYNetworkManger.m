//
//  QYNetworkManger.m
//  QY
//
//  Created by lxd on 2017/2/20.
//  Copyright © 2017年 MacBook. All rights reserved.
//

#import "QYNetworkManger.h"
#import "QYJsonPasser.h"
#import "QYToolsMethod.h"

@implementation QYNetworkManger


+ (void)getBCBCMatchId:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed { // 获取BCBC的MatchId
    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
    
    
    unEncodeDict[@"sn"] = [TSToolsMethod creatUUID];
    TSUserInfoModelBCBC *userInfo = [TSToolsMethod fetchUserInfoModelBCBC];
    
    unEncodeDict[@"token"] = userInfo.token;
    unEncodeDict[@"service"] = @"playerMatch";
    unEncodeDict[@"method"] = @"getMatchId";
    unEncodeDict[@"params"] = paramsDict;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
    
    [self p_PrivateGET:TS_SERVER_URL_TEST paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
        success(responseObject);
    } responseFailed:^(NSError *error) {
        failed(error);
    }];
}




+ (void)abstention:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
    

    
    TSUserInfoModelBCBC *userInfo = [TSToolsMethod fetchUserInfoModelBCBC];
    unEncodeDict[@"token"] = userInfo.token;
    
    unEncodeDict[@"sn"] = [TSToolsMethod creatUUID];
    unEncodeDict[@"service"] = @"amateurstatistic";
    unEncodeDict[@"method"] = @"abstention";
    unEncodeDict[@"params"] = paramsDict;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
    
    [self p_PrivateGET:TS_SERVER_URL_TEST paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
        success(responseObject);
    } responseFailed:^(NSError *error) {
        failed(error);
    }];
}




+ (void)sendCurrentStageDataBCBC:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];

    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    unEncodeDict[@"sn"] = [NSString stringWithFormat:@"%lf", interval];
    
    TSUserInfoModelBCBC *userInfo = [TSToolsMethod fetchUserInfoModelBCBC];
    unEncodeDict[@"token"] = userInfo.token;
    
    unEncodeDict[@"service"] = @"playerMatch";
    unEncodeDict[@"method"] = @"save";
    unEncodeDict[@"params"] = paramsDict;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
    
    NSLog(@"unEncodeDict:%@",unEncodeDict);
    
    
    [self p_PrivatePOST:TS_SERVER_URL_TEST paramsDict:encodeDic responseSuccess:^(id responseObject) {
        
        NSLog(@"responseObject:%@", responseObject);
        success(responseObject);

    } responseFailed:^(NSError *error) {
         failed(error);
    }];
//    [self p_PrivatePOST:TS_SERVER_URL_TEST paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//                NSLog(@"responseObject:%@", responseObject);
//        success(responseObject);
//        
//    } responseFailed:^(NSError *error) {
//        failed(error);
//        
//    }];
}




+ (void)getPlaysDataByTeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
    
    TSUserInfoModelBCBC *userInfo = [TSToolsMethod fetchUserInfoModelBCBC];
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    unEncodeDict[@"sn"] = [NSString stringWithFormat:@"%lf", interval];
    unEncodeDict[@"token"] = userInfo.token;
    unEncodeDict[@"service"] = @"playerMatch";
    unEncodeDict[@"method"] = @"queryPlayByTeam";
    unEncodeDict[@"params"] = paramsDict;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
    
    [self p_PrivateGET:TS_SERVER_URL_TEST paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
        //        DDLog(@"responseObject:%@", responseObject);
        success(responseObject);
    } responseFailed:^(NSError *error) {
        failed(error);
    }];
}


/**
 *获得球队球员
 */
+(void)queryPlayByTeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed{
    
    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
    TSUserInfoModelBCBC *userInfo = [TSToolsMethod fetchUserInfoModelBCBC];
    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
    unEncodeDict[@"token"] = userInfo.token;
    unEncodeDict[@"service"] = @"playerMatch";
    unEncodeDict[@"method"] = @"queryPlayByTeam";
    unEncodeDict[@"params"] = paramsDict;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
    
    [self p_PrivateGET:TS_SERVER_URL_TEST paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
        
        
        
        
        success(responseObject);
    } responseFailed:^(NSError *error) {
        failed(error);
    }];
    
}
/**
 获取决赛球队
 */
+ (void)getTeamInfoFinalMatch:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed{
    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
    TSUserInfoModelBCBC *userInfo = [TSToolsMethod fetchUserInfoModelBCBC];
    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
    unEncodeDict[@"token"] = userInfo.token;
    unEncodeDict[@"service"] = @"playerMatch";
    unEncodeDict[@"method"] = @"queryTeamByFinalMatch";
    unEncodeDict[@"params"] = paramsDict;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
    
    [self p_PrivateGET:TS_SERVER_URL_TEST paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
        
        
        
        success(responseObject);
    } responseFailed:^(NSError *error) {
        failed(error);
    }];

}


/**
 获取大区球队
 */
+ (void)getTeamInfoByZone:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed{
    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
    TSUserInfoModelBCBC *userInfo = [TSToolsMethod fetchUserInfoModelBCBC];
    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
    unEncodeDict[@"token"] = userInfo.token;
    unEncodeDict[@"service"] = @"playerMatch";
    unEncodeDict[@"method"] = @"queryTeamByZone";
    unEncodeDict[@"params"] = paramsDict;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
    
    [self p_PrivateGET:TS_SERVER_URL_TEST paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
        
   
        
        success(responseObject);
    } responseFailed:^(NSError *error) {
        failed(error);
    }];
}

/**
 获取地区球队
 */
+ (void)getTeamInfoByProvence:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed{
    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
    TSUserInfoModelBCBC *userInfo = [TSToolsMethod fetchUserInfoModelBCBC];
    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
    unEncodeDict[@"token"] = userInfo.token;
    unEncodeDict[@"service"] = @"playerMatch";
    unEncodeDict[@"method"] = @"queryTeamByProvince";
    unEncodeDict[@"params"] = paramsDict;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
    
    [self p_PrivateGET:TS_SERVER_URL_TEST paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
        
        
        
        
        success(responseObject);
    } responseFailed:^(NSError *error) {
        failed(error);
    }];
}

/**
 登出
 */

+ (void)loginOut:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
    
    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
    
    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
    unEncodeDict[@"service"] = @"user";
    unEncodeDict[@"method"] = @"logout";
    unEncodeDict[@"token"] = userInfo.token;
    unEncodeDict[@"params"] = paramsDict;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
    
    [self p_PrivateGET:TS_SERVER_URL_TEST paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
        
        success(responseObject);
    } responseFailed:^(NSError *error) {
        failed(error);
    }];
}

/**
 登陆
 */
+ (void)startLogin:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
    
    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
    unEncodeDict[@"service"] = @"playerMatch";
    unEncodeDict[@"method"] = @"login";
    unEncodeDict[@"params"] = paramsDict;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
    
    [self p_PrivateGET:TS_SERVER_URL_TEST paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
        
        success(responseObject);
    } responseFailed:^(NSError *error) {
        
        failed(error);
    }];
}

+ (void)p_PrivateGET:(NSString *)url paramsDict:(NSDictionary *)paramsDict showActivityView:(BOOL)showActivityView responseSuccess:(Success)success responseFailed:(Failed)failed {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:url parameters:paramsDict progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        [self p_PrivatePOST:url paramsDict:paramsDict responseSuccess:^(id responseObject) {
            success(responseObject);
        } responseFailed:^(NSError *error) {
            failed(error);
            
        }];
    }];
}


+ (void)p_PrivatePOST:(NSString *)url paramsDict:(NSDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:url parameters:paramsDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
        if (url.length) {
            [SVProgressHUD showInfoWithStatus:@"加载失败，请检查网络状态"];
            
        }
    }];
}
@end
