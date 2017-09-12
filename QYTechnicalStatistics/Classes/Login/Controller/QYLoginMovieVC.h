//
//  QYLoginMovieVC.h
//  启动页
//
//  Created by 曹航玮 on 2017/6/7.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//  ***启动图视频***

#import <AVKit/AVKit.h>

@interface QYLoginMovieVC : AVPlayerViewController

/** 加载视频名字 */
@property (nonatomic, copy) NSString * resourceName;

// 根据视频名字 创建APP启动视频引导页
+ (instancetype)loadLoginMovieWithResourceName:(NSString *)resourceName;

@end
