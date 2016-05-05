//
//  BrandsListModel.h
//  666Tuangou
//
//  Created by jifeng on 16/1/13.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrandsItemModel.h"

@interface BrandsListModel : NSObject


@property (nonatomic,copy)NSString *abst;
@property (nonatomic,copy)NSString *add_time;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *bimg; //https://img.alicdn.com/imgextra/i2/1613095223/TB2R7.LjXXXXXc1XpXXXXXXXXXX_!!1613095223.jpg
@property (nonatomic,copy)NSString *cate_id;
@property (nonatomic,copy)NSString *hits;

@property (nonatomic,copy)NSString *brandsList_id;

@property (nonatomic,copy)NSString *img; // https://img.alicdn.com/imgextra/i2/1613095223/TB2R7.LjXXXXXc1XpXXXXXXXXXX_!!1613095223.jpg
@property (nonatomic,copy)NSString *info;

@property (nonatomic,copy)NSString *is_hots;

@property (nonatomic,strong)NSArray *item; //[]

@property (nonatomic,copy)NSString *logo; //https://img.alicdn.com/imgextra/i1/1613095223/TB2LIxmjpXXXXXxXXXXXXXXXXXX_!!1613095223.jpg
@property (nonatomic,copy)NSString *lprice;

@property (nonatomic,copy)NSString *ordid;
@property (nonatomic,copy)NSString *seo_desc;
@property (nonatomic,copy)NSString *seo_keys;
@property (nonatomic,copy)NSString *seo_title;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *tele;
@property (nonatomic,copy)NSString *title;


@end
