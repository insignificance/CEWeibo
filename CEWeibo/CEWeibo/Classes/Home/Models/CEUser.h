//
//  CEUser.h
//  CEWeibo
//
//  Created by insignificance on 2020/1/12.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEUser : NSObject

/*  字符串类型的用户UID  */
@property (nonatomic,copy) NSString *idstr;

/*  显示名称  */
@property (nonatomic,copy) NSString *name;

/*  用户头像地址 50x50 */
@property (nonatomic,copy) NSString *profile_image_url;

/*  背景图片  */
@property (nonatomic,copy) NSString *cover_image_phone;


@end

NS_ASSUME_NONNULL_END
