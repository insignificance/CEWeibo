//
//  CEStatues.h
//  CEWeibo
//
//  Created by insignificance on 2020/1/12.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface CEStatues : NSObject



#pragma mark -
#pragma mark -- NSString

/*  微博创建时间  */
@property (nonatomic,copy) NSString *created_at;

/*  字符串类型的微博ID  */
@property (nonatomic,copy) NSString *idstr;

/*  字符串类型的微博ID  */
@property (nonatomic,copy) NSString *mid;

/*  字符串类型的微博ID  */
@property (nonatomic,copy) NSString *text;

/*  字符串类型的微博ID  */
@property (nonatomic,copy) NSString *source;

/*  微博作者的用户信息字段  */
@property (nonatomic,strong) CEUser *user;

/*  被转发的原微博信息字段 ,当该微博为转发微博时返回  */
@property (nonatomic,strong) CEStatues *retweeted_status;

/*  微博配图地址.多图时返回多图链接。无配图时返回“[ ]” */

@property (nonatomic,copy) NSArray *pic_urls;


/**
 (暂未支持）回复ID
*/
@property (nonatomic,copy) NSString *in_reply_to_status_id;
/**
 (暂未支持）回复人UID
*/
@property (nonatomic,copy) NSString *in_reply_to_user_id;
/**
（暂未支持）回复人昵称
*/
@property (nonatomic,copy) NSString *in_reply_to_screen_name;
/**
缩略图片地址，没有时不返回此字段
*/
@property (nonatomic,copy) NSString *thumbnail_pic;
/**
中等尺寸图片地址，没有时不返回此字段
*/
@property (nonatomic,copy) NSString *bmiddle_pic;
/**
原始图片地址，没有时不返回此字段
*/
@property (nonatomic,copy) NSString *original_pic;
/**
被转发的原微博信息字段，当该微博为转发微博时返回
*/
@property (nonatomic,copy) NSString *picStatus;
/**

*/
@property (nonatomic,copy) NSString *reward_scheme;
/**

*/
@property (nonatomic,copy) NSString *rid;
/**

*/
@property (nonatomic,copy) NSString *gif_ids;

/**
 地理位置
 */
@property (nonatomic,copy) NSString *geo;





#pragma mark -
#pragma mark -- ========= int , BOOL


@property (nonatomic,unsafe_unretained) int show_additional_indication;

@property (nonatomic,unsafe_unretained) int textLength;

@property (nonatomic,unsafe_unretained) int source_allowclick;

@property (nonatomic,unsafe_unretained) int source_type;

@property (nonatomic,unsafe_unretained) int mblog_vip_type;

//转发数
@property (nonatomic,unsafe_unretained) int reposts_count;
//评论数
@property (nonatomic,unsafe_unretained) int comments_count;
//表太数（赞）
@property (nonatomic,unsafe_unretained) int attitudes_count;

@property (nonatomic,unsafe_unretained) int pending_approval_count;

@property (nonatomic,unsafe_unretained) int reward_exhibition_type;

@property (nonatomic,unsafe_unretained) int hide_flag;

@property (nonatomic,unsafe_unretained) int mlevel;

@property (nonatomic,unsafe_unretained) int biz_feature;


@property (nonatomic,unsafe_unretained) int hasActionTypeCard;


@property (nonatomic,unsafe_unretained) int mblogtype;


@property (nonatomic,assign) BOOL can_edit;

@property (nonatomic,assign) BOOL favorited;

@property (nonatomic,assign) BOOL truncated;

@property (nonatomic,assign) BOOL is_paid;

@property (nonatomic,assign) BOOL isLongText;


#pragma mark -
#pragma mark -- =====strong

@end




NS_ASSUME_NONNULL_END
