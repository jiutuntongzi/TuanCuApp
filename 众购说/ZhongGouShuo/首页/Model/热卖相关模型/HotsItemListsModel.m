//
//  HotsItemListsModel.m
//  666Tuangou
//
//  Created by jifeng on 16/1/9.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "HotsItemListsModel.h"

@implementation HotsItemListsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{

             @"homeItem_id" : @"id"

             };
}


-(void)setMprice:(NSString *)mprice
{

    _mprice =mprice;

    /**
     *  设置自适应宽度的尺寸
     */
    _mSize = [mprice boundingRectWithSize:CGSizeMake(58, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]} context:nil].size;
}


@end
