//
//  CEPhoto.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/12.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEPhoto.h"



@implementation CEPhoto



- (NSString *)bmiddle_pic{
    
    
    return [self.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    

}


@end
