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
@property (nonatomic, strong)NSNumber *playerNumber;//注册号码
// loacal new add property
@property (nonatomic, copy) NSString *gameNum; // 本场号码
@property (nonatomic , copy) NSString *weight;
@property (nonatomic , copy) NSString *playingTimes;
@property (nonatomic, assign) BOOL isOn;
@property (nonatomic , copy) NSString *teamID;
@end
