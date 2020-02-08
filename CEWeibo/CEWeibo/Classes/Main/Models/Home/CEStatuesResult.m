//
//  CEStatuesResult.m
//  CEWeibo
//
//  Created by insignificance on 2020/2/6.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEStatuesResult.h"
#import "CEStatues.h"


@implementation CEStatuesResult

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"statues" : [CEStatues class]};
    
    
}



@end
