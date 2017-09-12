//
//  QYMuDuNetworkManger.m
//  QiuYouHui
//
//  Created by 安鹏 on 2017/8/1.
//  Copyright © 2017年 longcai. All rights reserved.
//

#import "QYMuDuNetworkManger.h"

static NSString *channelList = @"http://api.mudu.tv/v1/activities?live=1";
static NSString *videoList = @"http://api.mudu.tv/v1/videos";

@implementation QYMuDuNetworkManger

+ (void)getVideoList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
    [self p_PrivateGET:videoList paramsDict:nil showActivityView:NO responseSuccess:^(id responseObject) {
        success(responseObject);
    } responseFailed:^(NSError *error) {
        failed(error);
    }];
}

+ (void)getChannelList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed {
    
    [self p_PrivateGET:channelList paramsDict:nil showActivityView:NO responseSuccess:^(id responseObject) {
        success(responseObject);
    } responseFailed:^(NSError *error) {
        failed(error);
    }];
}

+ (void)p_PrivateGET:(NSString *)url paramsDict:(NSDictionary *)paramsDict showActivityView:(BOOL)showActivityView responseSuccess:(Success)success responseFailed:(Failed)failed {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"Bearer ef7egxrq3x8w9m4t1u1aqx8tfw5ddw9m" forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:url parameters:paramsDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
        if (url.length) {
            [SVProgressHUD showInfoWithStatus:@"加载失败，请检查网络状态"];
            QYLog(@"error is:%@ ---------- url is:%@", error, url);
        }
    }];
}

@end
