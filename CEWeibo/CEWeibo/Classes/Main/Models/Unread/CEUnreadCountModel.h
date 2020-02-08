//
//  CEUnreadModel.h
//  CEWeibo
//
//  Created by insignificance on 2020/2/6.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEUnreadCountModel : NSObject

/**
 *  新微博未读数
 */
@property (nonatomic, assign) NSNumber *status;

/**
 *  新粉丝数
 */
@property (nonatomic, assign) NSNumber * follower;

/**
 *  新评论数
 */
@property (nonatomic, assign) NSNumber * cmt;

/**
 *  新私信数
 */
@property (nonatomic, assign) NSNumber * dm;

/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) NSNumber * mention_cmt;

/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) NSNumber * mention_status;





@end

NS_ASSUME_NONNULL_END
