//
//  WGBNetWorking.h
//  SuprizeShopping
//
//  Created by jifeng on 16/1/8.
//  Copyright © 2016年 jifeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Block)(NSURLResponse*response,NSError *error,id obj);

@interface WGBNetWorking : NSObject

/**get请求*/

+(void)getWithURL:(NSString*)url andParams:(NSDictionary*)params competionBlock:(Block)block;

/**post请求数据*/

+(void)postWithURL:(NSString*)url andParams:(NSDictionary*)params competionBlock:(Block)block;


@end
