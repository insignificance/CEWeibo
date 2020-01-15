//
//  CEStatues.m
//  CEWeibo
//
//  Created by insignificance on 2020/1/12.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CEStatues.h"
#import "CEPhoto.h"
#import "NSDate+Extension.h"

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



#pragma mark -
#pragma mark -- 重写set方法 处理 微博来源
- (void)setSource:(NSString *)source{
    
    _source = source;
    
    
    // source = "<a href=\"http://app.weibo.com/t/feed/1a6JNo\" rel=\"nofollow\">\U5c0f\U7c739 Pro 5G</a>";
    
    
    NSRange startRange = [_source rangeOfString:@">"];
    
    NSInteger startIndex = startRange.location + 1;
    
    //rangeOfString 从头开始找 找到就停止
    
    NSRange endRange = [_source rangeOfString:@"</"];
    
    NSInteger length = endRange.location - startIndex;
    
    // 注意: 有时候服务器返回的微博数据中可能没有来源, 那么如果没有来源直接截取字符串会报错
    if (startRange.location !=NSNotFound && endRange.location != NSNotFound) {
        
        NSString *resultStr = [_source substringWithRange:NSMakeRange(startIndex, length)];
        
        _source = _source = [NSString stringWithFormat:@"来自:%@", resultStr];;
        
    }
    
    
    
    
    
}


/**
 
 1. 今年发布
 > 今天
 *一分钟内 :  刚刚
 *一个小时内 : xx分钟前
 *其它：xx小时前
 
 >昨天
 *昨天 xx时 : xx分
 
 >其它
 xx月-xx日 xx时 : xx 分
 
 2.非今年发布
 
 xx年xx月-xx日 xx时：xx分
 
 */
/*
 新浪时间分为三大类
 1. 今年和非今年
 2. 今天/昨天/其它天
 3. 1分钟内/一小时内/其它小时
 
 
 2029-1-1
 1-1-2029
 2029/01/01
 29/1/1
 */

#pragma mark -
#pragma mark -- 重写get方法处理时间

- (NSString *)created_at{
    
    
    //1. 将服务器返回的字符串转换为NSDate
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    //真机需要指定时区
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    //指定服务器返回时间的格式
    //Mon Feb 02 18:15:20 +0800 2029
    formatter.dateFormat = @"EEE MMM  dd HH:mm:ss Z yyyy";
    
    NSDate *createdDate = [formatter dateFromString:_created_at];
    
    //2. 获取本地时间
    //NSDate *currentDate = [NSDate date];
    //3. 比较两个时间返回对应的值
    //nscalendar 提供了获取年月日时分秒的方法
    
    //创建日历对象
    //NSCalendar *calendar = [NSCalendar currentCalendar];
    //取出服务器时间的年月秒
    //NSCalendarUnit flag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitSecond;
    
    //NSDateComponents *createDateCmp = [calendar components:flag fromDate:createdDate];
    
    //DDLogDebug(@"%tu",createDateCmp.year);
    //DDLogDebug(@"%tu",createDateCmp.month);
    //DDLogDebug(@"%tu",createDateCmp.day);
    
    //取出当前时间的年月日
    
    //NSDateComponents *currentDateCmp =  [calendar components:flag fromDate:currentDate];
    
    
    //DDLogDebug(@"%tu",currentDateCmp.year);
    //DDLogDebug(@"%tu",currentDateCmp.month);
    //DDLogDebug(@"%tu",currentDateCmp.day);
    
    //2. 判断服务器返回的时间 , 根据时间返回对应的字符串
    if ([createdDate isThisYear]) {
        
        //今年
        if ([createdDate isToday]) {
            //是今天
            //取出服务器返回时间的十分秒
            NSDateComponents *comps = [createdDate deltaWithNow];
            
            if (comps.hour >= 1) {
                //其它小时
                
                return [NSString stringWithFormat:@"%tu小时以前",comps.hour];
                
            }else if (comps.minute >1){
                
                //一小时以内
                
                return [NSString stringWithFormat:@"%tu分钟以前",comps.minute];
                
                
            }else{
                
                //刚刚
                
                return @"刚刚";
                
            }
        }else if ([createdDate isYesterday]){
            //是昨天
            formatter.dateFormat = @"昨天 HH时:mm分";
            return [formatter stringFromDate:createdDate];
        }else{
            //其它天
            formatter.dateFormat = @"MM月dd日  HH时:mm分";
            
            return [formatter stringFromDate:createdDate];
            
        }
        
        
    }else{
        
        //非今年
        
        formatter.dateFormat = @"yy年MM月dd日 HH时:mm分";
        
        return [formatter stringFromDate:createdDate];
   
    }
    

}




@end
