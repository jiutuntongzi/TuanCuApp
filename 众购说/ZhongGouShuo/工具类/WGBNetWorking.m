//
//  WGBNetWorking.m
//  SuprizeShopping
//
//  Created by jifeng on 16/1/8.
//  Copyright © 2016年 jifeng. All rights reserved.
//

#import "WGBNetWorking.h"

@implementation WGBNetWorking


//GET
+(void)getWithURL:(NSString *)url andParams:(NSDictionary *)params competionBlock:(Block)block
{
    AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];

    [manager GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        block(task.response,nil,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        block(nil,error,nil);
    }];

}

//POST

+(void)postWithURL:(NSString *)url andParams:(NSDictionary *)params competionBlock:(Block)block
{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];

    [manager POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {

        block(task.response,nil,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        block(nil,error,nil);
    }];

}



@end
