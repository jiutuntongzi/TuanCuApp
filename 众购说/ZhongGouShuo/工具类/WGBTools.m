//
//  WGBTools.m
//  666Tuangou
//
//  Created by jifeng on 16/1/12.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBTools.h"

@implementation WGBTools


/**
 *  字典 转 字符串方法
 *
 *  @param params 字典
 *
 *  @return 字符串
 */
+ (NSString *)objectTransformStringWithObject:(NSDictionary*)params
{
    NSError *error=nil;
    /**    序列化   */
    NSData *data =[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];

    NSString *string =nil;

    if (!data) {
        NSLog(@"error=%@",error);
    }else{
        string =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    return string;
}








@end
