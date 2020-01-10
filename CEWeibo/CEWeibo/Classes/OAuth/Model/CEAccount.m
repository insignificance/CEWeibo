//
//  CEAccount.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/7.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEAccount.h"
#import <objc/runtime.h>

@implementation CEAccount

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    
    return self;
}


+ (instancetype)accountWithDict:(NSDictionary *)dict{
    
    
    return [[self alloc]initWithDict:dict];
    
    
}

//将对象写入到文件时调用

- (void)encodeWithCoder:(NSCoder *)coder{
    
    
    unsigned int count = 0;
    
    //1. 取出所有的属性
    objc_property_t *propertes = class_copyPropertyList([self class], &count);
    
    //2. 便利所有的属性
    for (int i = 0; i<count; i++) {
        
        //3. 获取当前的属性名称
        const char *propertyName  = property_getName(propertes[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        
        // 利用kvc 取出对应属性的值
        id value = [self valueForKey:name];
        // 归档到文件中
        [coder encodeObject:value forKey:name];
        
        
    }
    
    
    
}




//从文件中读取对象时调用

- (instancetype)initWithCoder:(NSCoder *)coder{
    
    if (self = [super init]) {
        
        
        unsigned int count = 0;
        
        //1. 取出所有的属性
        objc_property_t *propertes = class_copyPropertyList([self class], &count);
        
        //2. 遍利所有的属性
        for (int i = 0; i<count; i++) {
            
            //3. 获取当前的属性名称
            const char *propertyName  = property_getName(propertes[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            
            //解档取值
            id value = [coder decodeObjectForKey:name];
            //kvc 赋值
            [self setValue:value forKey:name];
            
        }
        
        
    }
    
    
    return self;
    
    
}


+ (BOOL)supportsSecureCoding{
    
    return YES;
    
}



@end
