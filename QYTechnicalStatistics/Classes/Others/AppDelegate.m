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

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [QYLoginMovieVC loadLoginMovieWithResourceName:@"LaunchMovie"];
    [self.window makeKeyAndVisible];
    
    // 解决控制器跳转隐藏导航条瞬间黑色问题
    self.window.backgroundColor = [UIColor colorWithHexRGB:@"#326BFE" andAlpha:1.0f];
    return YES;
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
