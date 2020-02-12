//
//  CESwitchCommonItem.h
//  CEWeibo
//
//  Created by insignificance on 2020/2/9.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CECommonItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface CESwitchCommonItem : CECommonItem

/**
 *  记录开关的打开状态
 */
@property(nonatomic,assign, getter=isOpen)BOOL open;


@end

NS_ASSUME_NONNULL_END
