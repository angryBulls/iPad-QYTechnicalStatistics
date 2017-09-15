//
//  TSToolsMethod.m
//  TS
//
//  Created by lxd on 2017/2/27.
//  Copyright © 2017年 MacBook. All rights reserved.
//

#import "TSToolsMethod.h"

static void completionCallback(SystemSoundID mySSID)
{
    // Play again after sound play completion
    //    AudioServicesPlaySystemSound(mySSID);
}

static NSString * const TS_USER_INFO_BCBC = @"ts_user_info_bcbc";
static NSString * const TS_USER_INFO_NORMAL = @"ts_user_info_normal";

@interface TSToolsMethod ()
{
    SystemSoundID ditaVoice;
    dispatch_source_t _timer;
}

@property (nonatomic, assign) CountDownType countDownType;
@property (nonatomic, copy) CountdownReturnBlock countdownReturnBlock;
@end

@implementation TSToolsMethod
+ (void)setUserInfoBCBC:(NSDictionary *)newUserInfoDict {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:newUserInfoDict forKey:TS_USER_INFO_BCBC];
    [userDefaults synchronize];
}

+ (void)setUserInfoNormal:(NSDictionary *)newUserInfoDict {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:newUserInfoDict forKey:TS_USER_INFO_NORMAL];
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

+ (TSUserInfoModelBCBC *)fetchUserInfoModelBCBC {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDict = [userDefaults objectForKey:TS_USER_INFO_BCBC];
    TSUserInfoModelBCBC *userInfoModel = [[TSUserInfoModelBCBC alloc] initWithDictionary:userDict];
    
    return userInfoModel;
}

+ (TSUserInfoModelNormal *)fetchUserInfoModelNormal {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDict = [userDefaults objectForKey:TS_USER_INFO_NORMAL];
    TSUserInfoModelNormal *userInfoModel = [[TSUserInfoModelNormal alloc] initWithDictionary:userDict];
    
    return userInfoModel;
}

+ (void)loginOut {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:TS_USER_INFO_NORMAL];
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
        if (self.countDownType == CountDownTypeSecond) {
            countdownReturnBlock([NSString stringWithFormat:@"%d", timeOut]);
        } else {
            int minutes = timeOut / 60;
            int seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d:%.2d",minutes, seconds];
            countdownReturnBlock(strTime);
        }
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
        } else {
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - gcd实现的正计时功能
- (void)startGCDTimerWithDuration:(CGFloat)duration timeupReturnBlock:(CountdownReturnBlock)timeupReturnBlock {
    __block int timeOut = duration;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行一次
    dispatch_source_set_event_handler(_timer, ^{
        if (self.countDownType == CountDownTypeSecond) {
            timeupReturnBlock([NSString stringWithFormat:@"%d", timeOut]);
        } else {
            int minutes = timeOut / 60;
            int seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d:%.2d",minutes, seconds];
            timeupReturnBlock(strTime);
        }
        
        //倒计时结束，关闭
        timeOut ++;
    });
    dispatch_resume(_timer);
}

- (void)pauseGCDTimer {
    if(_timer) {
        dispatch_suspend(_timer);
    }
}

- (void)resumeGCDTimer {
    if(_timer){
        dispatch_resume(_timer);
    }
}

- (void)stopGCDTimer {
    if(_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

+ (AVAuthorizationStatus)checkMicrophoneAuthorizationStatus {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    return authStatus;
}

+ (BOOL)createDirec:(NSString *)direcName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *subDirectory = [documentsDirectory stringByAppendingPathComponent:direcName];
    
    BOOL ret = YES;
    if(![fileManager fileExistsAtPath:subDirectory]) {
        // 创建目录
        ret = [fileManager createDirectoryAtPath:subDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return ret;
}

/*
 *****文件读取*****
 */
+ (NSString *)readFile:(NSString *)filePath {
    NSData *reader = [NSData dataWithContentsOfFile:filePath];
    return [[NSString alloc] initWithData:reader encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
