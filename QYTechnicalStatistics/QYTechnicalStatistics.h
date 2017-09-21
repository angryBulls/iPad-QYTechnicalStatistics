//
//  QYTechnicalStatistics.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/6.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//


#ifdef DEBUG

#define QYLog(...) NSLog(__VA_ARGS__)

#else

#define QYLog(...)

#endif
#import "AppDelegate.h"
#import "UIView+ScaleFrame.h"
#import "UIColor+QYHexRGB.h"

// network
#import "TS_URL_Header.h"
#import "AFNetworking.h"
#import "QYNetworkManger.h"

// third
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"

// Utility class
#import "QYToolsMethod.h"
#import "TSToolsMethod.h"
#import "TSUserInfoModelBCBC.h"
#import "TSUserInfoModelNormal.h"

#import "QYUserInfoModel.h"
#import "TSUserInfoModelBCBC.h"
#import "LCActionSheet.h"
#import "AuditButton.h"
//category
#import "UIView+ScaleFrame.h"
#import "UIColor+QYHexRGB.h"

//FMDB
#import "TS_URL_Header.h"
#import "TSDBManager.h"
#import "TSCalculationTool.h"


//typedef enum {
//    GameFinish,
//    QuarterOne,
//    QuarterTwo,
//    QuarterThree,
//    QuarterFour,
//    AddOne,
//    AddTwo,
//    AddThree
//    
//}Finish;

typedef enum {
    Host,
    Guest
}TeamHostOrGuest;
#define ACCOUNT @"ACCOUNT"
#define PWD @"PWD"

#define W(float) SCREEN_WIDTH / 1024 * (float)
#define H(float) SCREEN_HEIGHT / 768 * (float)
#define kMAIN_SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define kREGISTRATION_HEADER_VIEW_COLOR @"#316BFE"
#define kMAIN_RESOLUTION_SCALE [UIScreen mainScreen].scale
#define kWidth(w) ([UIScreen mainScreen].bounds.size.width/1024*(w))
#define kHeight(h) ([UIScreen mainScreen].bounds.size.height/768*(h))

//球队选择

#define GameLevelArray @[@"总决赛", @"大区赛", @"地区赛"]
#define GameAreaArray @[@"东北赛区", @"东南赛区", @"西南赛区", @"西北赛区"]
#define GameProvinceArray @[@"北京市", @"天津市", @"辽宁省", @"吉林省", @"黑龙江省", @"河北省", @"山东省", @"上海市", @"江苏省", @"浙江省", @"安徽省", @"福建省", @"江西省", @"广东省", @"海南省", @"台湾省", @"香港特别行政区", @"澳门特别行政区", @"湖北省", @"湖南省", @"广西壮族自治区", @"贵州省", @"云南省", @"四川省", @"重庆市", @"西藏自治区", @"山西省", @"陕西省", @"甘肃省", @"新疆维吾尔自治区", @"青海省", @"宁夏回族自治区", @"内蒙古自治区", @"河南省"]

#define lastTime @"lastTime"
#define startTag @"0"
#define isStartGaming @"1"
static NSString * const CurrentLoginUserType = @"CurrentLoginUserType";

// 通知类型
#define NOTIFICATION_MASKING @"masking" // 点击技术统计页面球员按钮通知

/**log输出*****/
#ifndef __OPTIMIZE__
#define NSLog(FORMAT,...) {\
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
[dateFormatter setDateStyle:NSDateFormatterMediumStyle];\
[dateFormatter setTimeStyle:NSDateFormatterShortStyle];\
[dateFormatter setDateFormat:@"HH:mm:ss:SSSSSS"]; \
NSString *str = [dateFormatter stringFromDate:[NSDate date]];\
fprintf(stderr,"time：%s\nfile：%s\nline：%d\nfunc：%s\noutput：%s\n\n",[str UTF8String],[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__,__func__ ,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);\
}
#else
#define NSLog(...)  {}
#endif

