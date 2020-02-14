//
//  CESqliteTools.m
//  CEWeibo
//
//  Created by insignificance on 2020/2/14.
//  Copyright © 2020 insignificance. All rights reserved.
//

#import "CESqliteTools.h"
#import <FMDB.h>
#import "CEStatues.h"

@implementation CESqliteTools

static FMDatabase *_db;

+ (instancetype)shareSqliteTools{
    
    static CESqliteTools *tools = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            
        tools = [[CESqliteTools alloc]init];
        
        
    });
    
    
    return tools;
    
}


+ (void)initialize{
    
    //获取地址
    
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *sqlitePath = [docPath stringByAppendingPathComponent:@"status.sqlite"];
    
   
    //创建数据库
    
   _db  = [FMDatabase databaseWithPath:sqlitePath];
    
    if ([_db open]) {
        
        DDLogDebug(@"打开数据库成功");
        //创建表
        
        BOOL success = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_status(id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT ,dict BLOB ,idstr TEXT,access_token TEXT);"];
        
        if (success) {
            //成功创建表
            
            DDLogDebug(@"成功创建表");
            
        }else{
            //创建表失败
            
            DDLogDebug(@"创建表失败");
  
        }
        
    
    }
    
    
    //创建表
    
    
    
    
}



- (BOOL)insterDict:(NSDictionary *)dict{
    
    
    //1. 将传入的对象转换成二进制数据
    
    NSError *error;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
 
    //2. 取出当前微博对应的微博id
    
    NSString *idstr = dict[@"idstr"];
    
    //3. 取出当前用户登陆的令牌
    
    NSString *accessToken = [CEAccountTool accountFromSandbox].access_token;
    
    
   BOOL success = [_db executeUpdate:@"INSERT INTO t_status(dict ,idstr, access_token) VALUES(?,?,?)",data,idstr,accessToken];
    
    
    
   return success;
    
    
}


- (NSArray *)statusesWithParameters:(CEStatuesRequest *)request{
    
    
   //查询数据
    
    FMResultSet *resultSet = nil;
    
    
   //判断count是否有值
    if (request.count ==nil) {
        
        request.count = @(18);
        
    }
    
    
    
    
    
    if (request.since_id != nil) {
        //1. 有since_id (下拉刷新), 返回大于since_id 的微博
       resultSet =  [_db executeQuery:@"SELECT *FROM t_status WHERE idstr > ? access_token = ? ORDER BY idstr DESC LIMIT 0,?",request.since_id,request.access_token,request.count];
             
    }else if(request.max_id !=nil){
        //2. 有max_id （上拉加载更多),返回小于等于max_id的微博
        
       resultSet =  [_db executeQuery:@"SELECT *FROM t_status WHERE idstr <= ? access_token = ? ORDER BY idstr DESC LIMIT 0,?",request.max_id,request.access_token,request.count];

        
    }else{
        //3. 什么都没有 （第一次启动), 返回指定条数（count）
        
         resultSet =  [_db executeQuery:@"SELECT *FROM t_status WHERE access_token = ? ORDER BY idstr DESC LIMIT 0,?",request.access_token,request.count];
        
    }
    

   //从结果集中取出数据转换为模型存储到数组中
    
    NSMutableArray *models = [NSMutableArray array];
    
    
    while ([resultSet next]) {
        
        //1. 取出微博字典二进制数据
        
        NSData *data = [resultSet dataForColumn:@"dict"];
        
        //2. 将取出的二进制数据转换为字典
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        
        //3. 将字典转换成模型
        CEStatues *status = [CEStatues mj_objectWithKeyValues:dict];
        
        [models addObject:status];
        
    }

   //返回数组
        
    return models;
    
}


@end
