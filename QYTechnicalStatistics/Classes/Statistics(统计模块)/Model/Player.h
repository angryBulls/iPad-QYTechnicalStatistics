//
//  Player.h
//  QYTechnicalStatistics
//
//  Created by 孙中山 on 2017/9/5.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property (nonatomic , copy) NSString *pid;
@property (nonatomic , copy) NSString *playName;
@property (nonatomic , assign) BOOL team;
@property (nonatomic , assign) int scroe;
@property (nonatomic , copy) NSString *photo;
@property (nonatomic, strong)NSNumber *pinyin;
@property (nonatomic , copy) NSString *userId;
@property (nonatomic , copy) NSString *positional;
@property (nonatomic , copy) NSString *birthday;
@property (nonatomic , copy) NSString *height;
@property (nonatomic, strong)NSNumber *playerNumber;
@property (nonatomic , copy) NSString *weight;
@end
