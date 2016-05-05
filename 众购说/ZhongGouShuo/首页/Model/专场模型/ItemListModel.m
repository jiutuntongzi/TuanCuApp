//
//  ItemListModel.m
//  666Tuangou
//
//  Created by jifeng on 16/1/14.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "ItemListModel.h"

@implementation ItemListModel

+(NSDictionary*)modelCustomPropertyMapper{

    return @{

             @"itemList_id":@"id"

             };
}


- (void)setMprice:(NSString *)mprice
{

    _mprice =mprice;

    _mSize=[mprice boundingRectWithSize:CGSizeMake(58, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} context:nil].size;
}


@end
