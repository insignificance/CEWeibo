//
//  CESqliteTools.h
//  CEWeibo
//
//  Created by insignificance on 2020/2/14.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEStatuesRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface CESqliteTools : NSObject

+ (instancetype)shareSqliteTools;


/// 存储微博数据（包含微博和微博对应的用户）
/// @param dict 需要存储的微博数据
/// 返回是否执行成功
- (BOOL)insterDict:(NSDictionary *)dict;



/// 获取微博数据
/// @param request 传入的请求参数
/// 返回请求结果
- (NSArray *)statusesWithParameters:(CEStatuesRequest *)request;

@end

NS_ASSUME_NONNULL_END
