//
//  QYUserInfoModel.h
//  QY
//
//  Created by lxd on 2017/2/27.
//  Copyright © 2017年 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYUserInfoModel : NSObject
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *hitRate;
@property (nonatomic, copy) NSString *rebound;
@property (nonatomic, copy) NSString *assists;
@property (nonatomic, copy) NSString *gameCount;
@property (nonatomic, copy) NSString *leader;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)dictWithModel:(QYUserInfoModel *)model;
@end
