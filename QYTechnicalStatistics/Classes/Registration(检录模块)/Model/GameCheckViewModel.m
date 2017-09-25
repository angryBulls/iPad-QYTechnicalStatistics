//
//  GameCheckViewModel.m
//  QYTS
//
//  Created by lxd on 2017/7/27.
//  Copyright © 2017年 longcai. All rights reserved.
//

#import "GameCheckViewModel.h"

@interface GameCheckViewModel ()
@property (nonatomic, strong) NSMutableDictionary *pramasDict;
@end

@implementation GameCheckViewModel
- (instancetype)initWithPramasDict:(NSMutableDictionary *)pramasDict {
    if (self = [super init]) {
        if (pramasDict) {
            _pramasDict = pramasDict;
        }
    }
    return self;
}

#pragma mark - 群众用户获取服务器数据 ************************************start*****************************************
//- (void)getMatchAndTeamInfoNormal {
//    [QYNetworkManger getMatchAndTeamInfoNormal:self.pramasDict responseSuccess:^(id responseObject) {
//        if ([responseObject[@"success"] isEqual:@1]) {
//            self.returnBlock(responseObject);
//        } else {
//            NSString *reason = @"请求失败";
//            if (responseObject[@"reason"]) {
//                reason = responseObject[@"reason"];
//            }
//            [self errorCodeWithReason:reason];
//        }
//    } responseFailed:^(NSError *error) {
//        [self netFailure];
//    }];
//}

#pragma mark - 群众用户获取服务器数据 ************************************end*****************************************

//- (void)getTeamFinalsData {
//    [QYNetworkManger getTeamFinalsData:self.pramasDict responseSuccess:^(id responseObject) {
//        if ([responseObject[@"success"] isEqual:@1]) {
//            self.returnBlock(responseObject);
//        } else {
//            NSString *reason = @"请求失败";
//            if (responseObject[@"reason"]) {
//                reason = responseObject[@"reason"];
//            }
//            [self errorCodeWithReason:reason];
//        }
//    } responseFailed:^(NSError *error) {
//        [self netFailure];
//    }];
//}
//
//- (void)getTeamAreaData {
//    [QYNetworkManger getTeamAreaData:self.pramasDict responseSuccess:^(id responseObject) {
//        if ([responseObject[@"success"] isEqual:@1]) {
//            self.returnBlock(responseObject);
//        } else {
//            NSString *reason = @"请求失败";
//            if (responseObject[@"reason"]) {
//                reason = responseObject[@"reason"];
//            }
//            [self errorCodeWithReason:reason];
//        }
//    } responseFailed:^(NSError *error) {
//        [self netFailure];
//    }];
//}
//
//- (void)getTeamProvinceData {
//    [QYNetworkManger getTeamProvinceData:self.pramasDict responseSuccess:^(id responseObject) {
//        if ([responseObject[@"success"] isEqual:@1]) {
//            self.returnBlock(responseObject);
//        } else {
//            NSString *reason = @"请求失败";
//            if (responseObject[@"reason"]) {
//                reason = responseObject[@"reason"];
//            }
//            [self errorCodeWithReason:reason];
//        }
//    } responseFailed:^(NSError *error) {
//        [self netFailure];
//    }];
//}

- (void)getBCBCMatchId {
    [QYNetworkManger getBCBCMatchId:self.pramasDict responseSuccess:^(id responseObject) {
        if ([responseObject[@"success"] isEqual:@1]) {
            self.returnBlock(responseObject);
        } else {
            NSString *reason = @"请求失败";
            if (responseObject[@"reason"]) {
                reason = responseObject[@"reason"];
            }
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
