//
//  CECommonItem.m
//  CEWeibo
//
//  Created by insignificance on 2020/2/9.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CECommonItem.h"

@implementation CECommonItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    return [[self alloc] initWithIcon:icon title:title];
}

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title
{
    if (self = [super init]) {
        self.icon  = icon;
        self.title = title;
    }
    return self;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:title];
}
- (instancetype)initWithTitle:(NSString *)title
{
    return [self initWithIcon:nil title:title];
}



@end
