//
//  BrandsItemModel.m
//  666Tuangou
//
//  Created by jifeng on 16/1/13.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "BrandsItemModel.h"

@implementation BrandsItemModel


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{

             @"item_id" : @"id"

             };
}



-(void)setMprice:(NSString *)mprice
{

    _mprice =mprice;

    /**
     *  设置自适应宽度的尺寸
     */
    _mSize = [mprice boundingRectWithSize:CGSizeMake(58, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} context:nil].size;
}


@end
