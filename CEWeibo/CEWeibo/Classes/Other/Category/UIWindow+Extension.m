//
//  UIWindow+Extension.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/7.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "CENewfeatureVC.h"
#import "CEWelcomeVC.h"




@implementation UIWindow (Extension)


- (void)chooseRootViewController{
    
    
    //1.  判断是否需要显示新特性
    //注意: 获取出来的版本号, 一定不能存储为整形, 或者浮点型
    
    //2.1 获取当前版本豪
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    DDLogDebug(@"currentVersion = %@", currentVersion);
    
    //2.2 获取本地保存的软件版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *locationVersion = [defaults objectForKey:@"CFBundleShortVersionString"];
    DDLogDebug(@"locationVersion = %@", locationVersion);
    
    
    // 2.3比较当前软件版本号和本地版本号
    // 如果当前大于本地 , 1. 第一次使用 2.升级
    // ”54321“ 这样一个个比较
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if ([currentVersion compare:locationVersion] == NSOrderedDescending) {
        
        // 2.3.1显示新特性
        CENewfeatureVC *newfeatureVc = [[CENewfeatureVC alloc] init];
        
        window.rootViewController = newfeatureVc;
        
        // 2.3.2存储当前软件版本号
        [defaults setObject:currentVersion forKey:@"CFBundleShortVersionString"];
        [defaults synchronize];
        
    }else
    {
        CEWelcomeVC *welcomeVc = [[CEWelcomeVC alloc] init];
        window.rootViewController = welcomeVc;
    }
    
    
    
    
    
    
    
    
    
    
}



@end
