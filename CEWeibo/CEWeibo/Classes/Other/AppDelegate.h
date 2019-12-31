//
//  AppDelegate.h
//  CEWeibo
//
//  Created by insignificance on 2019/12/24.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import <UIKit/UIKit.h>

//发布代理协议
@protocol AppdelegateDelegate <NSObject>
//代理方法
- (void)doSomeThing;
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow * window;
@property(nonatomic,weak)id<AppdelegateDelegate>delegate;


@end

