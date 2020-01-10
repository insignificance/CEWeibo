//
//  CEAccountTool.h
//  CEWeibo
//
//  Created by insignificance on 2020/1/7.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CEAccount;
@interface CEAccountTool : NSObject


/// 存储授权信息
/// @param account 需要存储的信息
+ (BOOL)savaAccount:(CEAccount *)account;



/// 读取授权信息
+ (CEAccount *)account;

@end

NS_ASSUME_NONNULL_END
