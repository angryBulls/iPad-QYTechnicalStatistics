//
//  QYToolsMethod.m
//  QY
//
//  Created by lxd on 2017/2/27.
//  Copyright © 2017年 MacBook. All rights reserved.
//

#import "QYToolsMethod.h"
#import <AVFoundation/AVFoundation.h>
#import "QYLoginViewController.h"

#import "QY404TagSign.h"
static void completionCallback(SystemSoundID mySSID)
{
    // Play again after sound play completion
    //    AudioServicesPlaySystemSound(mySSID);
}

static NSString * const QY_USER_INFO = @"QY_user_info";

@interface QYToolsMethod ()
{
    SystemSoundID ditaVoice;
    dispatch_source_t _timer;
}
@end

@implementation QYToolsMethod

+ (BOOL) showErrorPage_CodeSign_404INView:(__kindof UIView *)view WithErrorMessage:(NSString *)errorMessage {
    
    __block BOOL isExist = NO;
    __block QY404TagSign * temp;
    
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[QY404TagSign class]]) {
            isExist = YES;
            temp = (QY404TagSign *)obj;
        }
        
    }];
    
    if (isExist && temp) {
        
        if ([temp respondsToSelector:@selector(removeFromSuperview)]) {
            
            [temp removeFromSuperview];
            
        } else {
            
            return NO;
            
        }
    }
    
    QY404TagSign * view_404 = [[QY404TagSign alloc] initWithFrame:CGRectMake(0, 0, view.width, view.height)];
    [view_404 setUserInteractionEnabled:YES];
    [view_404 setBackgroundColor:[QYToolsMethod themeBackgroundColor131722]];
    
    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"404_no_comment"]];
    [image setUserInteractionEnabled:YES];
    [image setFrame:CGRectMake(SCREEN_WIDTH / 2 - image.width / 2, H(129), image.width, image.height)];
    [view_404 addSubview:image];
    
    UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    messageLabel.y = CGRectGetMaxY(image.frame) + H(20.0f);
    messageLabel.font = [UIFont systemFontOfSize:H(15.0f)];
    [messageLabel setTextColor:[UIColor colorWithHexValue:0xffffff alpha:1]];
    messageLabel.numberOfLines = 0;
    
    messageLabel.textAlignment = NSTextAlignmentCenter;
    if (errorMessage) {
        [messageLabel setText:errorMessage];
    } else {
        [messageLabel setText:@"服务器去火星了, 待会儿再来吧"];
    }
    
    [messageLabel sizeToFit];
    
    if (messageLabel.width > SCREEN_WIDTH) {
        messageLabel.width = SCREEN_WIDTH - H(100);
        [messageLabel sizeToFit];
        messageLabel.x = SCREEN_WIDTH / 2 - messageLabel.width / 2;
        messageLabel.y = CGRectGetMaxY(image.frame) + H(20);
    } else {
//        [messageLabel setMj_origin:CGPointMake(SCREEN_WIDTH / 2 - messageLabel.width / 2, CGRectGetMaxY(image.frame) + H(20))];
    }
    [view_404 addSubview:messageLabel];
    
    [view insertSubview:view_404 atIndex:view.subviews.count];
    
    return YES;
}

+ (BOOL) dismissErrorPage_CodeSign_404INView:(__kindof UIView *)view {
    
    __block BOOL isExist = NO;
    __block QY404TagSign * temp;
    
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[QY404TagSign class]]) {
            isExist = YES;
            temp = (QY404TagSign *)obj;
        }
        
    }];
    
    if (isExist && temp) {
        
        if ([temp respondsToSelector:@selector(removeFromSuperview)]) {
            
            [temp removeFromSuperview];
            
        } else {
            
            return NO;
            
        }
    }
    
    return YES;
    
}

/**
 *  分享到微信
 *
 *  @param dic      {@"title":@"标题",@"description":@"描述",@"thumbImage":@"缩略图",@"thumbImage_url":@"缩略图URL",@"webpageUrl":@"跳转链接"}
 *  @param timeLine 是否是朋友圈?
 */

//+ (void) shareToWeiChartWithMessage:(NSDictionary *)dic andIsTimeline:(BOOL)timeLine {
//    
//    
//    
//    WXMediaMessage *message = [WXMediaMessage message];
//    
//    message.title = [NSString stringWithFormat:@"%@" , [dic objectForKey:@"title"]];
//    
//    message.description = [NSString stringWithFormat:@"%@" , [dic objectForKey:@"description"]];
//    
//    //设置缩略图
//    UIImage * thumbImage = (UIImage *)[dic objectForKey:@"thumbImage"];
//    
//    [message setThumbImage:thumbImage];
//    
//    //设置网页响应对象
//    WXWebpageObject *ext = [WXWebpageObject object];
//    ext.webpageUrl = [NSString stringWithFormat:@"%@" , [dic objectForKey:@"webpageUrl"]];
//    
//    message.mediaObject = ext;
//    
//    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.message = message;
//    if (timeLine) {
//        req.scene = WXSceneTimeline;
//    }else
//    {
//        req.scene = WXSceneSession;
//    }
//    
//    [WXApi sendReq:req];
//    
//}

+ (BOOL)isLogin {
    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
    if (userInfo.token && userInfo.token.length) {
        return YES;
    } else {
        return NO;
    }
}
+ (void)setUserInfo:(NSDictionary *)newUserInfoDict {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:newUserInfoDict forKey:QY_USER_INFO];
    [userDefaults synchronize];
}

+ (UIActivityIndicatorView *)showActivityIndicatorWithView:(UIView *)view {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    activityIndicator.center = view.center;
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [activityIndicator startAnimating];
    [view addSubview:activityIndicator];
    
    return activityIndicator;
}

+ (QYUserInfoModel *)fetchUserInfoModel {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDict = [userDefaults objectForKey:QY_USER_INFO];
    QYUserInfoModel *userInfoModel = [[QYUserInfoModel alloc] initWithDictionary:userDict];
    
    return userInfoModel;
}

+ (void)loginOut {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:QY_USER_INFO];
    [userDefaults synchronize];
}

+ (void)p_PrivateUploadLogVideoLastPosition:(NSDictionary *)videoInfoDict {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
    });
}

+ (float)heightForString:(NSString *)value andWidth:(float)width attrStr:(NSAttributedString *)attrStr {
    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 16.0, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height + 16.0;
}

/************************************************ object method*****************************************************/
- (void)p_PrivatePlayAudioWithURL:(NSString *)audioUrl audioType:(ExerciseAudio)audioType {
    // 1. 定义要播放的音频文件的URL
    NSURL *voiceURL = [[NSBundle mainBundle]URLForResource:audioUrl withExtension:nil];
    // 2. 注册音频文件（第一个参数是音频文件的URL 第二个参数是音频文件的SystemSoundID）
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(voiceURL),&ditaVoice);
    // 3. 为crash播放完成绑定回调函数
    AudioServicesAddSystemSoundCompletion(ditaVoice,NULL,NULL,(void*)completionCallback,NULL);
    // 4. 播放 ditaVoice 注册的音频 并控制手机震动
//    AudioServicesPlayAlertSound(ditaVoice); // 有震动
        AudioServicesPlaySystemSound(ditaVoice); // 无振动
    //    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); // 控制手机振动
}

+ (NSString *)creatUUID {
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (__bridge NSString *)CFStringCreateCopy(NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

// 登陆后淡入淡出更换rootViewController
+ (void)restoreRootViewController:(UIViewController *)rootViewController {
    typedef void (^Animation)(void);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}

#pragma mark - gcd实现的倒计时功能
- (void)startGCDTimerWithDuration:(CGFloat)duration countdownReturnBlock:(CountdownReturnBlock)countdownReturnBlock {
    __block int timeOut = duration;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行一次
    dispatch_source_set_event_handler(_timer, ^{
        countdownReturnBlock(timeOut);
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
        } else {
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

- (void)stopGCDTimer {
    if(_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

+ (void)loginOperation:(UIViewController *)viewController {
//    QYLoginViewController *login = [[QYLoginViewController alloc] init];
//    login.hidesBottomBarWhenPushed = YES;
//    login.viewController = viewController;
//    [viewController.navigationController pushViewController:login animated:YES];
}
+ (void)showInputError {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"最多只能输入%d个字符" , kMaxCommentWordCount]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD dismiss];
        
    });
}
+ (void)showSVDMessage:(NSString *) str andIsSuccess:(BOOL) success{

    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    if (success) {
    
        [SVProgressHUD showSuccessWithStatus:str];
        
    } else {
    
        [SVProgressHUD showErrorWithStatus:str];
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD dismiss];
        
    });
    
}
+ (UIColor *) themeBackgroundColor131722 {

    return [UIColor colorWithHexValue:0x131722 alpha:1];
    
}
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}
+ (UIImage *)logo_Image {
    return [UIImage imageNamed:@"profile_logo"];
}
@end
