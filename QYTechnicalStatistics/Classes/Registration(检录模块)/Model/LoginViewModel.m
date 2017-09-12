//
//  LoginViewModel.m
//  QiuYouHui
//
//  Created by 安鹏 on 2017/7/18.
//  Copyright © 2017年 longcai. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel ()
@property (nonatomic, strong) NSMutableDictionary *dic;
@end

@implementation LoginViewModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        _dic = dic;
    }
    return self;
}

- (void)startLogin {
    NSLog(@"%@",_dic);
    
    
    [QYNetworkManger startLogin:_dic responseSuccess:^(id responseObject) {
        if ([responseObject[@"success"] isEqual:@1]) {
            QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
            userInfo.token = responseObject[@"entity"][@"token"];
            userInfo.ID = responseObject[@"entity"][@"user"][@"id"];
            userInfo.name = responseObject[@"entity"][@"user"][@"name"];
            userInfo.sex = responseObject[@"entity"][@"user"][@"sex"];
            userInfo.photo = responseObject[@"entity"][@"user"][@"photo"];
            userInfo.level = responseObject[@"entity"][@"user"][@"level"];
            userInfo.hitRate = responseObject[@"entity"][@"user"][@"hitRate"];
            userInfo.rebound = responseObject[@"entity"][@"user"][@"rebound"];
            userInfo.assists = responseObject[@"entity"][@"user"][@"assists"];
            userInfo.gameCount = responseObject[@"entity"][@"user"][@"gameCount"];
            userInfo.leader = responseObject[@"entity"][@"user"][@"leader"];
            
            [QYToolsMethod setUserInfo:[userInfo dictWithModel:userInfo]];
            
            self.returnBlock(responseObject);
        } else {
            NSString *reason = responseObject[@"reason"];
            [self errorCodeWithReason:reason];
        }
    } responseFailed:^(NSError *error) {
        [self netFailure];
    }];
}

- (void)loginOut {
    [QYNetworkManger loginOut:_dic responseSuccess:^(id responseObject) {
        if ([responseObject[@"success"] isEqual:@1]) {
            [QYToolsMethod loginOut];
            self.returnBlock(responseObject);
            QYLog(@"loginOut success!!!!!!");
        } else {
            NSString *reason = responseObject[@"message"];
            [self errorCodeWithReason:reason];
        }
    } responseFailed:^(NSError *error) {
        [self netFailure];
    }];
}

#pragma 对ErrorCode进行处理
- (void)errorCodeWithReason:(NSString *)reason {
    self.errorBlock(reason);
}

#pragma 对网路异常进行处理
- (void)netFailure {
    self.failureBlock ? self.failureBlock() : nil;
}

@end
