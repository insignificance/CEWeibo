//
//  CENetWorkingTools.h
//  CEWeibo
//
//  Created by insignificance on 2020/2/4.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@class CEUser,CEUnreadCountModel,CEStatues,CEStatuesRequest,CEStatuesSendRequest,CEStatuesResult;
NS_ASSUME_NONNULL_BEGIN



typedef void (^successBlock)(CEUser * responseObject);
typedef void (^failureBlock)(NSError * _Nonnull error);


@interface CENetWorkingTools : AFHTTPSessionManager


/// 网络工具类单例
+ (instancetype)shareNetworkTools;


/// 获取用户信息
- (void)loadUserInfo:(successBlock)success failure:(failureBlock)failure;


/// 获取未读数
/// @param success 成功的回调 返回获取的未读模型
/// @param failure 失败的回掉 返回错误信息
- (void)loadUnreadCount:(void (^)(CEUnreadCountModel *unreadModel))success failure:(failureBlock)failure;



/// 获取用户授权信息
/// @param code 已经授权的requesttoken
/// @param success 成功的回掉 返回授权模型
/// @param failure 失败的回掉 返回错误信息
- (void)loadAccessTokenWithCode:(NSString *)code success:(void (^)(CEAccount *acount))success failure:(failureBlock)failure;



/// 发送信息
/// @param parameters 请求参数
/// @param success 成功的回掉 返回微博模型
/// @param failure 失败的回掉 返回错误信息
- (void)sendStatusWithParameters:(CEStatuesSendRequest *)parameters success:(void(^)(CEStatues *statues))success failure:(failureBlock)failure;



/// 获取微博数据
/// @param parameters 请求参数
/// @param success 成功的回掉 返回获取的微博模型
/// @param failure 失败的回掉 返回失败信息
- (void)loadHomeStatusWithParameters:(CEStatuesRequest *)parameters success:(void (^)(CEStatuesResult *result))success failure:(failureBlock)failure;


@end

NS_ASSUME_NONNULL_END
