//
//  CETabBar2.h
//  CEWeibo
//
//  Created by insignificance on 2019/12/10.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CETabBar2,CEItem;

NS_ASSUME_NONNULL_BEGIN

@protocol CETabBar2Delegate <NSObject>

- (void)CETabBar2:(CETabBar2 *)tabBar withCEItem:(CEItem *)item from:(NSInteger)from to:(NSInteger)to;


- (void)CETabBar2:(CETabBar2 *)tabBar selectedAddbtn:(UIButton *)addBtn;

@end

@interface CETabBar2 : UIView

@property (nonatomic,weak)id<CETabBar2Delegate>delegate;

/// 对外提供添加 item 方法
- (void)addItemFromBarItem:(UITabBarItem *)item;


@end

NS_ASSUME_NONNULL_END
