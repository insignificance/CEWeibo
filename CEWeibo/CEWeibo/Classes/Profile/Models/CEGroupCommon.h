//
//  CEGroupCommon.h
//  CEWeibo
//
//  Created by insignificance on 2020/2/9.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEGroupCommon : NSObject

/**
 *  头部标题
 */
@property(nonatomic,copy)NSString *header;
/**
 *  底部标题
 */
@property(nonatomic,copy)NSString *footer;
/**
 *  所有cell的数据模型
 */
@property(nonatomic,strong)NSArray *items;




@end

NS_ASSUME_NONNULL_END
