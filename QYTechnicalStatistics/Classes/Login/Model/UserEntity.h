//
//  UserEntity.h
//  ZBJ0923
//
//  Created by yanfa002 on 2016/12/20.
//  Copyright © 2016年 孙中山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject<NSCopying,NSMutableCopying>


@property (copy, nonatomic) NSString *userName;

@property (nonatomic,copy)NSString *token;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *nickName;
@property (nonatomic,copy)NSString *imgUrl;
@property (nonatomic,copy)NSString *location;
@property (nonatomic,strong)NSNumber *age;
@property (nonatomic,copy)NSString *birthdayer;
@property (nonatomic,copy)NSString *birthday;
@property (nonatomic,strong)NSNumber *payPassStatus;
@property (nonatomic,copy)NSString *hometown;
@property (nonatomic,copy)NSString *userTag;
@property (nonatomic,copy)NSString *userInfo;
@property (nonatomic,strong)NSNumber *sex;
@property (nonatomic,strong)NSNumber *userType;
//开始登陆时间
@property (nonatomic,copy)NSString *startTime;
@property (assign, nonatomic) BOOL isLogin;


/********记住密码，技术统计项目*********/

@property (nonatomic,copy)NSString *logInName;
@property (nonatomic , copy) NSString *psw;


+(instancetype)shareUserEntity;

@end
