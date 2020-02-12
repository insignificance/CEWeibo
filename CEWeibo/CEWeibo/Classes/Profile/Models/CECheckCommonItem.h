//
//  CECheckCommonItem.h
//  CEWeibo
//
//  Created by insignificance on 2020/2/9.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CECommonItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface CECheckCommonItem : CECommonItem

/**
 *  是否需要打钩
 */
@property(nonatomic,assign, getter=isCheck)BOOL check;


@end

NS_ASSUME_NONNULL_END
