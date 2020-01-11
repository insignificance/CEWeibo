//
//  CEAccount.h
//  CEWeibo
//
//  Created by insignificance on 2020/1/7.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEAccount : NSObject<NSSecureCoding>

/*
 
 "access_token" = "2.007TwXcCKExSSD140768f9a50DTZuZ";
 "expires_in" = 157679999;
 isRealName = true;
 "remind_in" = 157679999;
 uid = 2401856032;
 
 */


/**
 令牌
 */
@property (nonatomic,copy)NSString *access_token;
/**
 过期时间，相对于现在多少秒之后过期
 */
@property (nonatomic,strong)NSNumber *expires_in;
/**
 提醒时间
 */
@property (nonatomic,strong)NSNumber *remind_in;
/**
 用户id
 */
@property (nonatomic,copy)NSString *uid;
/**
 过期时间 = 授权的那一刻时间+expires_in
 */
@property (nonatomic,strong)NSDate *expires_time;

@property (nonatomic,assign)BOOL isRealName;

/**
 用户头像地址
 */
@property(nonatomic,copy)NSString *profile_image_url;

/**
 高清用户头像图片地址
 */

@property(nonatomic,copy)NSString *avatar_large;




- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)accountWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
