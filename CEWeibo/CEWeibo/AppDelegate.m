//
//  AppDelegate.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/24.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/*
开发中经常进行暴力测试,也就是经常打印Log,但是NSLog有一个致命的弱点
非常消耗性能
1.什么时候需要显示Log ? 开发阶段,也就是说在应用程序发布阶段是不需要显示Log的
2.发布阶段如何取消Log的显示?
 一般在初始化项目的时候自定义Log
   采用DEBUG宏定义
*/


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  
    //CELog(@"自定义Log");
     
     [DDLog addLogger:[DDOSLogger sharedInstance]]; // Uses os_log
     DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
     fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
     fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
     [DDLog addLogger:fileLogger];
    
  //获取当前系统版本
    NSString *version = [UIDevice currentDevice].systemVersion;
    
    if (version.doubleValue <13.0) {
        
        /*
         
         适配ios13 以下
         
         */
        
        
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        UIViewController *vc = [[UIViewController alloc]init];
        vc.view.backgroundColor = [UIColor orangeColor];
        
        [self.window setRootViewController:vc];
        [self.window makeKeyWindow];
        [self.window makeKeyAndVisible];
        
        //统一修改图片文字颜色
        //[[UITabBar appearance] setTintColor:[UIColor redColor]];
        
    }
    

    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)) API_AVAILABLE(ios(13.0)) API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    if (@available(iOS 13.0, *)) {
        return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
    } else {
        // Fallback on earlier versions
        
        return nil;
    }
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
