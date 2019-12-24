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
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
