//
//  CEStatuesRequest.h
//  CEWeibo
//
//  Created by insignificance on 2020/2/6.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEStatuesRequest : NSObject

/// 令牌
@property (nonatomic,copy) NSString *access_token;


/// 若指定此参数 则返回id 比since_id 大的微博 默认为0
@property (nonatomic,copy) NSNumber *since_id;


/// 若指定此参数 则返回id 小于等于max_id 的微博 默认为0
@property (nonatomic,copy) NSNumber *max_id;


/// 返回的微博数量
@property (nonatomic,strong) NSNumber *count;
@end

NS_ASSUME_NONNULL_END
