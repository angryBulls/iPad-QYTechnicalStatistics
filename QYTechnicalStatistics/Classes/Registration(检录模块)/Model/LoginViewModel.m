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
            TSUserInfoModelBCBC *userInfo = [TSToolsMethod fetchUserInfoModelBCBC];
            userInfo.loginUserType = @"1";
            userInfo.loginName = responseObject[@"entity"][@"loginName"];
            userInfo.nickname = responseObject[@"entity"][@"nickname"];
            userInfo.status = responseObject[@"entity"][@"status"];
            userInfo.token = responseObject[@"entity"][@"token"];
            userInfo.userId = responseObject[@"entity"][@"userId"];
            userInfo.sn = responseObject[@"sn"];
            
//            userInfo.password = self.userInfoDict[@"password"];
//            userInfo.rememberPD = self.userInfoDict[@"rememberPD"];
            
            //            DDLog(@"userInfo is:%@", [userInfo dictWithModel:userInfo]);
            [TSToolsMethod setUserInfoBCBC:[userInfo dictWithModel:userInfo]];
            
            [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:CurrentLoginUserType];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
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
