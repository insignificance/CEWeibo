//
//  UIBarButtonItem+CEBarButtonItem.m
//  CEWeibo
//
//  Created by insignificance on 2019/12/11.
//  Copyright © 2019 insignificance. All rights reserved.
//

#import "UIBarButtonItem+CEBarButtonItem.h"


@implementation UIBarButtonItem (CEBarButtonItem)

+ (instancetype)itemWithImage:(NSString *)image highlightedImg:(NSString *)highlitedImg target:(id)target action:(SEL)action{
    
    
    UIButton *btn = [[UIButton alloc]init];
    
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlitedImg] forState:UIControlStateHighlighted];
    
    //根据图片大小设置btn大小
   
    CGRect frame = btn.frame;
    
    frame.size = btn.currentImage.size;
    
    btn.frame = frame;
    
    
    //为btn 添加点击事件
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
   // UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    
    
    return [[self alloc]initWithCustomView:btn];
    
}


@end
