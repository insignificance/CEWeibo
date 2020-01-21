//
//  CEUser.h
//  CEWeibo
//
//  Created by insignificance on 2020/1/12.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum {
    
    IWUserVerifiedTypeNone = -1, // 没有任何认证
    
    //  黄V
    IWUserVerifiedPersonal = 0,  // 个人认证
    
    // 蓝V
    IWUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    IWUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    IWUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    // 红色行星
    IWUserVerifiedDaren = 220 // 微博达人
    
} CEUserVerifiedType;



@interface CEUser : NSObject

/*  字符串类型的用户UID  */
@property (nonatomic,copy) NSString *idstr;

/*  显示名称  */
@property (nonatomic,copy) NSString *name;

/*  用户头像地址 50x50 */
@property (nonatomic,copy) NSString *profile_image_url;

/*  背景图片  */
@property (nonatomic,copy) NSString *cover_image_phone;


/*  会员等级  */

@property (nonatomic,strong)NSNumber *mbrank;


/*  会员类型,如果大于2就是会员  */

@property (nonatomic,strong) NSNumber *mbtype;

- (BOOL)isVip;

/** 认证类型 */
@property (nonatomic, assign) CEUserVerifiedType verified_type;






@end

NS_ASSUME_NONNULL_END
