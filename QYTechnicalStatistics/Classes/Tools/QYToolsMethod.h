//
//  QYToolsMethod.h
//  QY
//
//  Created by lxd on 2017/2/27.
//  Copyright © 2017年 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMaxCommentWordCount                            50

typedef NS_ENUM(NSInteger, ExerciseAudio) {
    ExerciseAudioGoodjob,
    ExerciseAudioWrong,
    ExerciseAudioWelldone
};

typedef void(^CountdownReturnBlock)(int time);

@class QYUserInfoModel;

@interface QYToolsMethod : NSObject
/**
 *  加载404页面的方法
 *
 *  @param view         基础View
 *  @param errorMessage 显示给用户的错误信息
 *  @param delegate     代理
 *  @param selector     404界面的点击操作
 *
 *  @return 成功或失败
 */
+ (BOOL) showErrorPage_CodeSign_404INView:(__kindof UIView *)view WithErrorMessage:(NSString *)errorMessage;

/**
 *  移除404界面的方法
 *
 *  @param view 当前加载的View
 *
 *  @return 成功或失败
 */
+ (BOOL) dismissErrorPage_CodeSign_404INView:(__kindof UIView *)view;

/**
 *  分享到微信
 *
 *  @param dic      {@"title":@"标题",@"description":@"描述",@"thumbImage":@"缩略图",@"thumbImage_url":@"缩略图URL",@"webpageUrl":@"跳转链接"}
 *  @param timeLine 是否是朋友圈?
 */

+ (void) shareToWeiChartWithMessage:(NSDictionary *)dic andIsTimeline:(BOOL)timeLine;
+ (void)setUserInfo:(NSDictionary *)newUserInfoDict;
+ (QYUserInfoModel *)fetchUserInfoModel;
+ (void)loginOut;
+ (void)p_PrivateUploadLogVideoLastPosition:(NSDictionary *)videoInfoDict;
+ (UIActivityIndicatorView *)showActivityIndicatorWithView:(UIView *)view;
// 计算UITextView的高度
+ (float)heightForString:(NSString *)value andWidth:(float)width attrStr:(NSAttributedString *)attrStr;


- (void)p_PrivatePlayAudioWithURL:(NSString *)audioUrl audioType:(ExerciseAudio)audioType;

+ (NSString *)creatUUID;
+ (void)restoreRootViewController:(UIViewController *)rootViewController;

- (void)startGCDTimerWithDuration:(CGFloat)duration countdownReturnBlock:(CountdownReturnBlock)countdownReturnBlock;
-(void)stopGCDTimer;
+ (void)loginOperation:(UIViewController *)viewController;
+ (void)showInputError;
+ (void)showSVDMessage:(NSString *) str andIsSuccess:(BOOL) success;
+ (BOOL)isLogin;
+ (UIColor *) themeBackgroundColor131722;
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
+ (UIImage *)logo_Image;
@end
