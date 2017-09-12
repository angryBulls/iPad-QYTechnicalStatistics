//
//  QYUserInfoModel.m
//  QY
//
//  Created by lxd on 2017/2/27.
//  Copyright © 2017年 MacBook. All rights reserved.
//

#import "QYUserInfoModel.h"

@implementation QYUserInfoModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        if (![dictionary[@"token"] isKindOfClass:[NSNull class]]) {
            _token = dictionary[@"token"];
            _ID = dictionary[@"id"];
            _name = dictionary[@"name"];
            _sex = dictionary[@"sex"];
            _photo = dictionary[@"photo"];
            _level = dictionary[@"level"];
            _hitRate = dictionary[@"hitRate"];
            _rebound = dictionary[@"rebound"];
            _assists = dictionary[@"assists"];
            _gameCount = dictionary[@"gameCount"];
            _leader = dictionary[@"leader"];
            _password = dictionary[@"password"];
            _phone = dictionary[@"phone"];
        }
    }
    return self;
}

- (NSDictionary *)dictWithModel:(QYUserInfoModel *)model {
    NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
    
    newDict[@"token"] = model.token;
    newDict[@"id"] = model.ID;
    newDict[@"name"] = model.name;
    newDict[@"sex"] = model.sex;
    newDict[@"photo"] = model.photo;
    newDict[@"level"] = model.level;
    newDict[@"hitRate"] = model.hitRate;
    newDict[@"rebound"] = model.rebound;
    newDict[@"assists"] = model.assists;
    newDict[@"gameCount"] = model.gameCount;
    newDict[@"leader"] = model.leader;
    newDict[@"password"] = model.password;
    newDict[@"phone"] = model.phone;
    
    return newDict;
}
@end
