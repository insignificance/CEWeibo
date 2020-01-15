//
//  CEStatues.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/12.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEStatues.h"
#import "CEPhoto.h"

@implementation CEStatues
//
//+(NSMutableArray *)mj_objectArrayWithKeyValuesArray:(id)keyValuesArray{
//
//
//    NSMutableArray *mutableArray = [NSMutableArray arrayWithObject:@{@"pic_urls":@"CEPhoto"}];
//
//
//    return mutableArray;
//
//
//}


+(NSDictionary *)mj_objectClassInArray{
    
    
    return @{@"pic_urls":[CEPhoto class]};
    
    
}

@end
