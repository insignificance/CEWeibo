//
//  CEAccountTool.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/7.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEAccountTool.h"
#import "CEAccount.h"
#import <objc/runtime.h>

#define CEAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]


@implementation CEAccountTool

+ (BOOL)savaAccount:(CEAccount *)account{
    
    //计算真正的过期时间
    
    account.expires_time = [[NSDate date] dateByAddingTimeInterval:[account.expires_in doubleValue]];
    
    DDLogDebug(@"expires_in %@", account.expires_in);
    DDLogDebug(@"expires_time %@", account.expires_time);
    
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:account requiringSecureCoding:NO error:NULL];
    
    
    DDLogDebug(@"%@",data);
    
    return [data writeToFile:CEAccountPath atomically:YES];
    
    
    
}


+ (CEAccount*)accountFromSandbox{
    
    
    DDLogDebug(@"%@",CEAccountPath);
    
    NSData *data = [NSData dataWithContentsOfFile:CEAccountPath];
    
    
    
    //从沙盒中获取解档数据
    CEAccount *account = [NSKeyedUnarchiver unarchivedObjectOfClasses:[self getPropertiesClassNames:[CEAccount class]] fromData:data error:NULL];
    
    //CEAccount *account = [NSKeyedUnarchiver unarchivedObjectOfClass:[CEAccount class] fromData:data error:NULL];
    
    
    DDLogDebug(@"account from sandbox %@",account);
    
    
    //判断是否过期
    if ([[NSDate date] compare:account.expires_time] == NSOrderedDescending) {
        //如果过期
        
        return nil;
        
        
    }
    
    return account;
    
    
}



#pragma mark -
#pragma mark -- 获取某个类所有属性对应类 组成的集合对象 (包括该类本身)


+ (NSSet *)getPropertiesClassNames:(Class )Class{
    
    
    
    NSMutableArray *classNameArray = [NSMutableArray array];
    
    
    unsigned int outCount ,i;
    
    objc_property_t *propertis  = class_copyPropertyList([Class class], &outCount);
    
    for (i = 0 ; i<outCount; i++) {
        
        objc_property_t property = propertis[i];
        
        NSString *attributesString = [NSString stringWithUTF8String:property_getAttributes(property)];
        
        
        //NSLog(@"%@",attributesString);
        
        //按照指定的字符串分割字符串
        
        NSArray *SeparatedString = [attributesString componentsSeparatedByString:@","];
        
        NSRange range = [attributesString rangeOfString:@"T@"];
        
        //判断是否存在
        if (range.location !=NSNotFound) {
            
            NSUInteger index = range.location + range.length ;
            
            //获取属性对于类的名称 //会包含""
            
            NSString *className = [SeparatedString[0] substringFromIndex:index];
            
            //去除两端的双引号
            
            NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"\""];
            
            NSString *realclassName = [className stringByTrimmingCharactersInSet:characterSet];
            
            
            //将类加入数组
            [classNameArray addObject: NSClassFromString(realclassName)];
            
            
            
        }
        
        
        
    }
    
    //将传入的类也加入数组中
    [classNameArray addObject:Class];
    
    //去除重复的class
    NSSet *set = [NSSet setWithArray:classNameArray];
    
    
    //    for (NSObject *obj in set) {
    //
    //
    //        NSLog(@"%@",obj);
    //
    //    }
    
    
    return set;
    
    
    
    
}




@end
