//
//  QYMuDuNetworkManger.h
//  QiuYouHui
//
//  Created by 安鹏 on 2017/8/1.
//  Copyright © 2017年 longcai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYMuDuNetworkManger : NSObject

+ (void)getChannelList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;
+ (void)getVideoList:(NSMutableDictionary *)paramsDict responseSuccess:(Success)success responseFailed:(Failed)failed;

@end
