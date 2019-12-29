//
//  UIBarButtonItem+CEBarButtonItem.h
//  CEWeibo
//
//  Created by insignificance on 2019/12/11.
//  Copyright © 2019 insignificance. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (CEBarButtonItem)


//设计一个分类 其中有个方法 能返回一个自定义的UIBarButtonItem 对象

//按钮中图片分 normal 和 高亮
//需要一个参数 接受 指定方法


///  创建一个能区分高亮和正常状态的BarnButtonItem
/// @param image 默认显示的图片
/// @param highlitedImg 高亮状态显示的图片
/// @param target 谁来监听BarButtonItem
/// @param action 监听到点击事件后调用的方法
+ (instancetype)itemWithImage:(NSString *)image highlightedImg:(NSString *)highlitedImg target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
