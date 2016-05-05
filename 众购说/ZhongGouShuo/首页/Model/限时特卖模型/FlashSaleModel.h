//
//  FlashSaleModel.h
//  666Tuangou
//
//  Created by jifeng on 16/1/9.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemCategoryModel.h"
#import <UIKit/UIKit.h>

@interface FlashSaleModel : NSObject


@property (nonatomic,copy)NSString *abst;
@property (nonatomic,copy)NSString *add_time;
@property (nonatomic,copy)NSString *add_uid;
@property (nonatomic,copy)NSString *add_uname;
@property (nonatomic,copy)NSString *admin_uid;
@property (nonatomic,copy)NSString *admin_uname;
@property (nonatomic,copy)NSString *adv;
@property (nonatomic,copy)NSString *aid;
@property (nonatomic,copy)NSString *app_status;
@property (nonatomic,copy)NSString *bimg;
@property (nonatomic,copy)NSString *brand_id;
@property (nonatomic,copy)NSString *brand_name;
@property (nonatomic,copy)NSString *cate_id;
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *comments;
@property (nonatomic,copy)NSString *commission_per;
@property (nonatomic,copy)NSString *commission_price;
@property (nonatomic,copy)NSString *contacts;
@property (nonatomic,copy)NSString *etime;
@property (nonatomic,copy)NSString *express;
@property (nonatomic,copy)NSString *favs;
@property (nonatomic,copy)NSString *favs_status;
@property (nonatomic,copy)NSString *hits;
@property (nonatomic,copy)NSString *flashSale_id;
@property (nonatomic,copy)NSString *img;//https://img.alicdn.com/imgextra/i1/1976443010/TB2FM3.jXXXXXXcXpXXXXXXXXXX_!!1976443010.jpg_300x300.jpg
@property (nonatomic,copy)NSString *is_app;
@property (nonatomic,copy)NSString *is_baoyou;
@property (nonatomic,copy)NSString *is_discount;
@property (nonatomic,copy)NSString *is_guess;
@property (nonatomic,copy)NSString *is_hots;
@property (nonatomic,copy)NSString *is_index;
@property (nonatomic,copy)NSString *is_like;
@property (nonatomic,copy)NSString *is_link;
@property (nonatomic,copy)NSString *is_new;
@property (nonatomic,copy)NSString *is_taoke;
@property (nonatomic,copy)NSString *is_tuancu;
@property (nonatomic,copy)NSString *is_vip;
@property (nonatomic,copy)NSString *is_zero;
@property (nonatomic,strong)NSArray *item_brand;// [],

@property (nonatomic,strong)ItemCategoryModel *item_cate;//{}
@property (nonatomic,strong)NSArray *item_img;// [],
@property (nonatomic,copy)NSString *merchant;
@property (nonatomic,copy)NSString *miaosha_etime;
@property (nonatomic,copy)NSString *miaosha_status;
@property (nonatomic,copy)NSString *miaosha_stime;
@property (nonatomic,copy)NSString *mprice;
@property (nonatomic,copy)NSString *ordid;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *rates;
@property (nonatomic,copy)NSString *sales;
@property (nonatomic,copy)NSString *seo_desc;
@property (nonatomic,copy)NSString *seo_keys;
@property (nonatomic,copy)NSString *seo_titile;
@property (nonatomic,copy)NSString *services;
@property (nonatomic,copy)NSString *sku;
@property (nonatomic,copy)NSString *sn;
@property (nonatomic,copy)NSString *spec;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *stime;
@property (nonatomic,copy)NSString *stock;
@property (nonatomic,copy)NSString *tags;
@property (nonatomic,copy)NSString *taobao_id;
@property (nonatomic,copy)NSString *tel;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *topic_id;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *update_time;

@property (nonatomic,copy)NSString *url;// http://www.tuancu.com/proview-216643.html
@property (nonatomic,copy)NSString *url_h5;// http://www.tuancu.com/jump-216643.html
@property (nonatomic,copy)NSString *wangwang;//
@property (nonatomic,copy)NSString *weight;//
@property (nonatomic,copy)NSString *zid;//
@property (nonatomic,assign)CGSize mSize;

@end
