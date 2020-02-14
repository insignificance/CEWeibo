//
//  CENetWorkingTools.m
//  CEWeibo
//
//  Created by insignificance on 2020/2/4.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CENetWorkingTools.h"
#import "CEUser.h"
#import "CEUnreadCountModel.h"
#import "CEStatues.h"
#import "CEStatuesSendRequest.h"
#import "CEStatuesResult.h"
#import "CEStatuesRequest.h"
#import "CESqliteTools.h"


//#define client_id @"3018889502"
//#define redirect_uri @"http://www.youku.com"
//#define secret @"8af3169367d05364544835dbf1598e40"
#define client_id @"2223713944"
#define redirect_uri @"http://www.youku.com"
#define secret @"2224f1cb88b3236a9039cd6cd607c5da"

//根url
#define CEWeiboBaseUrl @"https://api.weibo.com/"

//授权信息
#define CEAuthorizeUrl @"oauth2/access_token"

//未读数
#define CEWeiboUnreadCount @"2/remind/unread_count.json"

//用户信息
#define CEWeiboUserInfo @"2/users/show.json"

//发送文本微博

#define CEWeiboSendStatus @"2/statuses/share.json"

//获取微博
#define CEWeiboStatus @"2/statuses/home_timeline.json"



@implementation CENetWorkingTools

+ (instancetype)shareNetworkTools{
    
    
    static CENetWorkingTools *tools = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        tools = [[self alloc] initWithBaseURL:[NSURL URLWithString:CEWeiboBaseUrl] sessionConfiguration:nil];
        // 让afn 支持text/plain 类型 unable to determine interface type without an established connection
        tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",nil];
        
    });
    
    return tools;
    
    
}



- (void)loadUserInfo:(successBlock)success failure:(failureBlock)failure{
    
    
    //1. 封装请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    //1.1 获取用户模型对象
    
    CEAccount *accout = [CEAccountTool accountFromSandbox];
    
    parameters[@"access_token"] = accout.access_token;
    parameters[@"uid"] = accout.uid;
    
    
    
    NSString *urlString = CEWeiboUserInfo;
    
    [self GET:urlString parameters:parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if (success) {
            
            // 1. 将服务器返回的json 数据转换为模型
            
            CEUser *user = [CEUser mj_objectWithKeyValues:responseObject];
            
            success(user);
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DDLogDebug(@"%@",error);
        
        
        if (failure) {
            
            failure(error);
            
            
        }
        
        
        
        
    }];
    
    
    
    
    
    
}



- (void)loadUnreadCount:(void (^)(CEUnreadCountModel * _Nonnull))success failure:(failureBlock)failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    CEAccount *account = [CEAccountTool accountFromSandbox];
    
    parameters[@"access_token"] = account.access_token;
    parameters[@"uid"] = account.uid;
    
    NSString *urlString = CEWeiboUnreadCount;
    
    
    [self GET:urlString parameters:parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        CEUnreadCountModel *unreadCount = [CEUnreadCountModel mj_objectWithKeyValues:responseObject];
        
        if (success) {
            
            success(unreadCount);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        if (failure) {
            
            failure(error);
            
        }
        
        
    }];
    
    
    
    
    
}



- (void)loadAccessTokenWithCode:(NSString *)code success:(void (^)(CEAccount * _Nonnull))success failure:(failureBlock)failure{
    
    //1. 封装请求参数
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = client_id;
    parameters[@"client_secret"] = secret;
    parameters[@"grant_type"] = @"authorization_code";
    
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = redirect_uri;
    
    
    [self POST:CEAuthorizeUrl parameters:parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            //1. 将服务器返回的字典转换成模型对象
            CEAccount *account = [CEAccount mj_objectWithKeyValues:responseObject];
            //2. 将模型对象保存到沙盒中
            BOOL successSave = [CEAccountTool savaAccount:account];
            
            
            if (successSave) {
                
                DDLogDebug(@"保存成功");
                
            }else{
                
                DDLogDebug(@"保存失败");
                
            }
            
            
            //3. 返回授权模型
            success(account);
            
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            
        }
    }];
    
    
    
    
}



- (void)sendStatusWithParameters:(CEStatuesSendRequest *)parameters success:(void (^)(CEStatues * _Nonnull))success failure:(failureBlock)failure{
    
    //处理status 参数
    [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"https://api.weibo.com/2/statuses/share.json" parameters:parameters error:nil];
    
    
    if (parameters.image !=nil) {
        //发送图片微博
        
        NSDictionary *realParameters = @{@"status":parameters.status,@"access_token":parameters.access_token};
        [self POST:CEWeiboSendStatus parameters:realParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            
            /**
             参数1: 需要上传的二进制数据
             参数2: 服务器参数的名称pic
             参数3: 文件名称(画用于服务器保存)
             参数4:文件类型
             */
            
            // 接口限制只能传一张
            UIImage *image = parameters.image;
         
            NSLog(@"%@",[NSThread currentThread]);
            
            //处理图片大小
            //
            //        __block NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            //
            //        //若大于5m
            //        if (imageData.length/1024 > (5.0*1024)) {
            //
            //            dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //
            //               imageData = [self compressOriginalImage:image toMaxDataSizeKBytes:5.0];
            //
            //            });
            //        }
            //
            //NSData *imageData = UIImagePNGRepresentation(image);
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
            
            [formData appendPartWithFileData:imageData name:@"pic" fileName:@"abc" mimeType:@"image/png"];
            
            
            
        } progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (success) {
                
                CEStatues *status = [CEStatues mj_objectWithKeyValues:responseObject];
                success(status);
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                
                failure(error);
                
            }
        }];
        
        
        
    }else{
        //发送文本微博
        
        [self POST:CEWeiboSendStatus parameters:[parameters mj_keyValues]  progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (success) {
                
                CEStatues *status = [CEStatues mj_objectWithKeyValues:responseObject];
                success(status);
            }
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failure) {
                
                failure(error);
                
            }
            
            
        }];
        
    }
    
    
    
    
    
}


- (void)loadHomeStatusWithParameters:(CEStatuesRequest *)parameters success:(void (^)(CEStatuesResult * _Nonnull))success failure:(failureBlock)failure{
    
    
    
    NSArray *models = [[CESqliteTools shareSqliteTools] statusesWithParameters:parameters];
  
    if (models.count > 0) {
        // 加载本地缓存数据
        
        if (success) {
            
            //将服务器返回的数据转换成模型对象
            CEStatuesResult *result = [CEStatuesResult new];
            
            //注意statues 里装的是CEStatues 对象
            result.statues = models;
            
            DDLogDebug(@"加载数据库中缓存数据成功");
            
            
            success(result);
            
        }
        
        

    }else{
        
    //加载网络数据
    [self GET:CEWeiboStatus parameters:parameters.mj_keyValues progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
  
        for (NSDictionary *dict  in responseObject[@"statuses"]) {
            
            //存储微博数据
           BOOL success =  [[CESqliteTools shareSqliteTools] insterDict:dict];
            
            if (success) {
                //插入数据成功
                
                DDLogDebug(@"插入数据成功");
                
            }else{
                //插入数据失败
                
                DDLogDebug(@"插入数据失败");
                
                
            }
            
            
            
        }
        

        
        //将服务器返回的数据转换成模型对象
        CEStatuesResult *result = [CEStatuesResult new];
        
        //注意statues 里装的是CEStatues 对象
        result.statues = [CEStatues mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"] context:nil];
        
        if (success) {
            //返回模型
            success(result);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        if (failure) {
            
            failure(error);
            
        }
        
        
        
    }];
        
        
}
    

    
}


@end
