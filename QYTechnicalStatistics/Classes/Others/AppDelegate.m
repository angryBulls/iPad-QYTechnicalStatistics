//
//  AppDelegate.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/1.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "AppDelegate.h"
#import "QYLoginMovieVC.h"
#import "UIColor+QYHexRGB.h"
#import "QYMovieCoveringView.h"
#import "QYLoginViewController.h"
#import "QYRegistrationVC.h"
#import "QYStatisticsVC.h"
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self p_switchWindowView];
    
    
    // 解决控制器跳转隐藏导航条瞬间黑色问题
    self.window.backgroundColor = [UIColor colorWithHexRGB:@"#326BFE" andAlpha:1.0f];
    return YES;
}

- (void)p_switchWindowView {
    NSString *documentsPath = nil;
    NSArray *appArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([appArray count] > 0) {
        documentsPath = [appArray objectAtIndex:0];
    }
    NSLog(@"%@",documentsPath);
    NSString *tsdbPath = [documentsPath stringByAppendingString:[NSString stringWithFormat:@"/%@", TSDBName]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:tsdbPath]) {
        [self setVoicePageBeRootView];
    } else {
        [self setGuidPageBeRootView];
    }
}


- (void)setGuidPageBeRootView {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL areadlyLoad =  [defaults boolForKey:@"areadlyLoad"];
    if (areadlyLoad) {
        UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:[QYLoginViewController createLoginVC]];
        rootNav.navigationBar.hidden = YES;
        [self setCurrentPageBeRootView:rootNav];
            
    }
    else
    {
        UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:[QYLoginMovieVC loadLoginMovieWithResourceName:@"LaunchMovie"]];
        rootNav.navigationBar.hidden = YES;
        [self setCurrentPageBeRootView:rootNav];
    }
    [defaults setBool:YES forKey:@"areadlyLoad"];
    [defaults synchronize];
    
}

- (void)setVoicePageBeRootView {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[QYStatisticsVC alloc] init]];
    nav.navigationBar.hidden = YES;
    [self setCurrentPageBeRootView:nav];
}

- (void)setCurrentPageBeRootView:(UIViewController *)viewController {
    if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
        [QYToolsMethod restoreRootViewController:viewController];
    } else {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController = viewController;
        [self.window makeKeyAndVisible];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
