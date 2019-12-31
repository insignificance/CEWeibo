//
//  AppDelegate.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/24.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "AppDelegate.h"
#import "CEViewController.h"


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
        
        UIViewController *vc = [[CEViewController alloc]init];
        
        vc.view.backgroundColor = [UIColor orangeColor];
        
        [self.window setRootViewController:vc];
        [self.window makeKeyWindow];
        [self.window makeKeyAndVisible];
        
        //统一修改图片文字颜色
        //[[UITabBar appearance] setTintColor:[UIColor redColor]];
        
    }
    

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  
  
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   
    if ([self.delegate respondsToSelector:@selector(doSomeThing)]) {
        
        [self.delegate doSomeThing];
        
    }
    
     
    DDFunc;
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    
    
  
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)) API_AVAILABLE(ios(13.0)) API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    
        return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
    
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
