//
//  CEColorUtils.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/1.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEColorUtils.h"

@implementation CEColorUtils

/// 将uinavigationBar 及 uitabbar 设置成透明
+ (void)setTransparentColorForBarWithController:(UIViewController *)vc{
    
    
    [vc.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                forBarMetrics:UIBarMetricsDefault];
    vc.navigationController.navigationBar.shadowImage = [UIImage new];
    vc.navigationController.navigationBar.translucent = YES;
    
    
    [vc.tabBarController.tabBar setBackgroundImage:[UIImage new]];
    
    vc.tabBarController.tabBar.shadowImage = [UIImage new];
    
    vc.tabBarController.tabBar.translucent = YES;
    
    
}


@end
