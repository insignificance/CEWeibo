//
//  CEStatuesSendRequest.h
//  CEWeibo
//
//  Created by insignificance on 2020/2/6.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEStatuesSendRequest : NSObject


/// 令牌
@property (nonatomic,copy) NSString *access_token;


/// 需要发送的微博文本
@property (nonatomic,copy) NSString *status;


/// 需要发送的图片
@property (nonatomic,strong) UIImage *image;

@end

NS_ASSUME_NONNULL_END
