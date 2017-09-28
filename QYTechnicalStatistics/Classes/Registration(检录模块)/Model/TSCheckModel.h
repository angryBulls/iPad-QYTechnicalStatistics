//
//  TSCheckModel.h
//  QYTS
//
//  Created by lxd on 2017/7/27.
//  Copyright © 2017年 longcai. All rights reserved.
//  赛前检录模型

#import <Foundation/Foundation.h>

@interface TSCheckModel : NSObject
@property (nonatomic, copy) NSString *gameLevel;
@property (nonatomic, copy) NSString *gameArea;
@property (nonatomic, copy) NSString *gameProvince;

@property (nonatomic, copy) NSString *teamIdH;
@property (nonatomic, copy) NSString *teamNameH;

@property (nonatomic, copy) NSString *teamIdG;
@property (nonatomic, copy) NSString *teamNameG;

@property (nonatomic, copy) NSString *teamColorH;
@property (nonatomic, copy) NSString *teamColorG;

@property (nonatomic, copy) NSString *mainReferee; // 主裁判
@property (nonatomic, copy) NSString *firstReferee; // 第一副裁
@property (nonatomic, copy) NSString *secondReferee; // 第二副裁
@property (nonatomic, copy) NSString *td; // 技术代表
@property (nonatomic , copy) NSString *ts01;
@property (nonatomic , copy) NSString *ts02;

@property (nonatomic , copy) NSString *teamCoachH;
@property (nonatomic , copy) NSString *teamCoachG;
@property (nonatomic , copy) NSString *matchId;

@property (nonatomic , copy) NSString *isStart;

@end
