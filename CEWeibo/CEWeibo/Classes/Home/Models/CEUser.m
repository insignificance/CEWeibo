//
//  CEUser.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/12.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEUser.h"

@implementation CEUser


- (BOOL)isVip{
    
    
    return [self.mbtype intValue] >2;
    
    
}


@end
