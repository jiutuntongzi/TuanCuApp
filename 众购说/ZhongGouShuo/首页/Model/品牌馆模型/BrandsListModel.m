//
//  BrandsListModel.m
//  666Tuangou
//
//  Created by jifeng on 16/1/13.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "BrandsListModel.h"

@implementation BrandsListModel

/**
 *  容器类 重写该方法
 *
 *  @return 键值映射
 */

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"item" : [BrandsItemModel class]
             };
}


/**
 *  替换特殊属性名
 *
 */

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{

             @"brandsList_id" : @"id"

             };
}



@end
