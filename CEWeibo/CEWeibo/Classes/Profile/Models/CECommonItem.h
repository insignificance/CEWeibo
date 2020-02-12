//
//  CECommonItem.h
//  CEWeibo
//
//  Created by insignificance on 2020/2/9.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 实现封装的原理:
 每一行cell对应一个特殊的模型,以后设置数据时根据对应的模型设置右边的辅助视图即可
 例如, label中显示什么内容label对饮的模型最清楚
 switch是开还是关, 那么switch对应的模型最清楚
*/

@interface CECommonItem : NSObject

/**
 *  图标
 */
@property(nonatomic,copy)NSString *icon;
/**
 *  标题
 */
@property(nonatomic,copy)NSString *title;
/**
 *  子标题
 */
@property(nonatomic,copy)NSString * _Nullable subTitle;
/**
 *  提醒数字
 */
@property(nonatomic,copy)NSString *badgeValue;

/**
 *  目标控制器
 */
@property(nonatomic,assign)Class destClass;

/**
 *  保存将来需要执行的代码
 */
@property(nonatomic,copy) void (^option)(void);

+ (instancetype)itemWithIcon:(NSString * _Nullable)icon title:(NSString * _Nullable)title;
- (instancetype)initWithIcon:(NSString * _Nullable)icon title:(NSString *)title;

+ (instancetype)itemWithTitle:(NSString * _Nullable)title;

- (instancetype)initWithTitle:(NSString * _Nullable)title;


@end

NS_ASSUME_NONNULL_END
