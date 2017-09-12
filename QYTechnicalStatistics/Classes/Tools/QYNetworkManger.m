//
//  QYNetworkManger.m
//  QY
//
//  Created by lxd on 2017/2/20.
//  Copyright © 2017年 MacBook. All rights reserved.
//

#import "QYNetworkManger.h"
#import "QYJsonPasser.h"
@implementation QYNetworkManger
//+ (void)changeName:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mine";
//    unEncodeDict[@"method"] = @"changeName";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)getVersionInfoResponseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"user";
//    unEncodeDict[@"method"] = @"version";
//    unEncodeDict[@"channel"] = @"ios";
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)getOrderUrlResponseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mall";
//    unEncodeDict[@"method"] = @"orders";
//    unEncodeDict[@"token"] = userInfo.token;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)saveThumbs:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"live";
//    unEncodeDict[@"method"] = @"saveThumbs";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)getChannelDetails:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"live";
//    unEncodeDict[@"method"] = @"getChannelDetailNoLogin";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)getChannelVideoList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"live";
//    unEncodeDict[@"method"] = @"getChannelVideoListNoLogin";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)getChannelList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"live";
//    unEncodeDict[@"method"] = @"getChannelListNoLogin";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)inviteFriends:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mine";
//    unEncodeDict[@"method"] = @"sendMessage";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)getMeLiveListResponseSuccess:(Success)success responseFailed:(Failed)failed {
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"live";
//    unEncodeDict[@"method"] = @"getVideoList";
//    unEncodeDict[@"token"] = userInfo.token;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)getMeRaceList:(NSMutableDictionary *)paramsDict method:(NSString *)method responseSuccess:(Success)success responseFailed:(Failed)failed {
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mine";
//    unEncodeDict[@"method"] = method;
//    unEncodeDict[@"params"] = paramsDict;
//    unEncodeDict[@"token"] = userInfo.token;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)createLive:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"live";
//    unEncodeDict[@"method"] = @"createLive";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)getLiveInfoResponseSuccess:(Success)success responseFailed:(Failed)failed {
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"live";
//    unEncodeDict[@"method"] = @"getLive";
//    unEncodeDict[@"token"] = userInfo.token;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
///**
// * 获取商城链接
// */
//+ (void)getMallLink:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mall";
//    unEncodeDict[@"method"] = @"index";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//
//}
//
///**
// * 同意入队
// */
//+ (void)agreeJointeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mine";
//    unEncodeDict[@"method"] = @"changeStatus";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//
//}
//
///**
// * 消息列表
// */
//+ (void)messageList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mine";
//    unEncodeDict[@"method"] = @"message";
//    unEncodeDict[@"token"] = userInfo.token;
////    unEncodeDict[@"token"] =  @"d88344e73bb847eaa849a27e470d5a6c";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//
//}
//
//+ (void)getRaceData:(NSMutableDictionary *)paramsDict method:(NSString *)method responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"match";
//    unEncodeDict[@"method"] = method;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
///**
// * 回复
// */
//+ (void)sendComment_and_replyUser:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"comment";
//    unEncodeDict[@"method"] = @"save";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//
//}
//
///**
// * 评论详情(回复列表)
// */
//+ (void)commentReplyList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"comment";
//    unEncodeDict[@"method"] = @"replyList";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//
//}
//
//+ (void)getRaceList:(NSMutableDictionary *)paramsDict method:(NSString *)method responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"match";
//    unEncodeDict[@"method"] = method;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//
//+ (void)getRaceCity:(NSMutableDictionary *)paramsDict method:(NSString *)method responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"index";
//    unEncodeDict[@"method"] = method;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//
//
//+ (void)getCarousel:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"carousel";
//    unEncodeDict[@"method"] = @"list";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)joinTeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mine";
//    unEncodeDict[@"method"] = @"addTeam";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)getNews:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"info";
//    unEncodeDict[@"method"] = @"list";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
///**
// * 资讯详情
// */
//+ (void)info_Detail:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"info";
//    unEncodeDict[@"method"] = @"detail";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//
//}
//
///**
// * 资讯列表
// */
//+ (void)info_List:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"info";
//    unEncodeDict[@"method"] = @"list";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//
//}
//
///**
// * 删除评论
// */
//+ (void)deletecomment:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"comment";
//    unEncodeDict[@"method"] = @"delete";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//    
//}
//
///**
// * 回复评论
// */
//+ (void)recomment:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"comment";
//    unEncodeDict[@"method"] = @"save";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//
//}
//
///**
// * 评论列表
// */
//+ (void)commentList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"comment";
//    unEncodeDict[@"method"] = @"list";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//
//}
//
///**
// * 视频详情
// */
//+ (void)videoDetail:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"video";
//    unEncodeDict[@"method"] = @"detail";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//    
//}
//
///**
// * 视频列表
// */
//+ (void)videoList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"video";
//    unEncodeDict[@"method"] = @"list";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//    
//}
//
//+ (void)feedBack:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mine";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"method"] = @"personalSetting";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)selectTeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mine";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"method"] = @"getSearchTeamList";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)deletePlayer:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mine";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"method"] = @"del";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)getMyTeamResponseSuccess:(Success)success responseFailed:(Failed)failed{
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mine";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"method"] = @"teamlist";
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)searchTeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mine";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"method"] = @"search";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)createTeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mine";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"method"] = @"saveTeam";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)getPlayerInfoResponseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mine";
//    unEncodeDict[@"method"] = @"getPlayerInfo";
//    unEncodeDict[@"token"] = userInfo.token;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)saveApproveInfo:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"mine";
//    unEncodeDict[@"token"] = userInfo.token;
//    unEncodeDict[@"method"] = @"savePlayerInfo";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)uploadThumbnailWithImage:(UIImage *)image method:(NSString *)method responseSuccess:(Success)success responseFailed:(Failed)failed {
//    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//    
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"upload";
//    unEncodeDict[@"method"] = method;
//    unEncodeDict[@"token"] = userInfo.token;
//    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
//    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    unEncodeDict[@"params"] = @{@"image" : encodedImageStr};
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager POST:QY_URL_SERVER_FORMAL parameters:encodeDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        //        PPLog(@"progress is:%lf",1.0*uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //        PPLog(@"thumbnail result is:%@", responseObject);
//        success(responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failed(error);
//        [SVProgressHUD showInfoWithStatus:@"加载失败，请检查网络状态"];
//    }];
//}
//
//+ (void)passworldRelated:(NSMutableDictionary *)paramsDict method:(NSString *)method responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"user";
//    unEncodeDict[@"method"] = method;
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
//+ (void)getVerificationCode:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
//    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
//    
//    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
//    unEncodeDict[@"service"] = @"user";
//    unEncodeDict[@"method"] = @"verificationCode";
//    unEncodeDict[@"params"] = paramsDict;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
//    
//    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
//        success(responseObject);
//    } responseFailed:^(NSError *error) {
//        failed(error);
//    }];
//}
//
/**
 *获得球队球员
 */
+(void)queryPlayByTeam:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed{
    
    NSMutableDictionary *unEncodeDict = [NSMutableDictionary dictionary];
    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
    unEncodeDict[@"token"] = userInfo.token;
    unEncodeDict[@"service"] = @"playerMatch";
    unEncodeDict[@"method"] = @"queryPlayByTeam";
    unEncodeDict[@"params"] = paramsDict;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
    
    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
        //        NSlog(@"responseObject:%@", responseObject);
        
        
        
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
    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
    unEncodeDict[@"token"] = userInfo.token;
    unEncodeDict[@"service"] = @"playerMatch";
    unEncodeDict[@"method"] = @"queryTeamByZone";
    unEncodeDict[@"params"] = paramsDict;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
    
    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
        NSLog(@"responseObject:%@", responseObject);
   
        
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
    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
    unEncodeDict[@"sn"] = [QYToolsMethod creatUUID];
    unEncodeDict[@"token"] = userInfo.token;
    unEncodeDict[@"service"] = @"playerMatch";
    unEncodeDict[@"method"] = @"queryTeamByProvince";
    unEncodeDict[@"params"] = paramsDict;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:unEncodeDict options:0 error:nil];
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *encodeDic = [[NSDictionary alloc] initWithObjectsAndKeys:myString, @"body", nil];
    
    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
        //        NSlog(@"responseObject:%@", responseObject);
        NSLog(@"responseObject:%@", responseObject);
        
        
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
    
    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
        
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
    
    [self p_PrivateGET:QY_URL_SERVER_FORMAL paramsDict:encodeDic showActivityView:NO responseSuccess:^(id responseObject) {
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
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
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
