//
//  UserEntity.m
//  ZBJ0923
//
//  Created by yanfa002 on 2016/12/20.
//  Copyright © 2016年 孙中山. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity

+ (instancetype)shareUserEntity
{
    return [[self alloc] init];
}

static UserEntity *_instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    // 由于alloc方法内部会调用allocWithZone: 所以我们只需要保证在该方法只创建一个对象即可
    dispatch_once(&onceToken,^{
        
        // 只执行1次的代码(这里面默认是线程安全的)
        _instance = [super allocWithZone:zone];
        
    });
    
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}


@end
