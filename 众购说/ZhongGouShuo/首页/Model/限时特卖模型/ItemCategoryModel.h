//
//  ItemCategoryModel.h
//  666Tuangou
//
//  Created by jifeng on 16/1/9.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemCategoryModel : NSObject


@property (nonatomic,copy)NSString *add_time;
@property (nonatomic,copy)NSString *bg;

@property (nonatomic,copy)NSString *itemCate_id;

@property (nonatomic,copy)NSString *img;// http://7xjnu5.com2.z0.glb.qiniucdn.com/data/upload/assets/2015/09/01/55e5354277fa1.png
@property (nonatomic,copy)NSString *is_hots;
@property (nonatomic,strong)NSArray *items;// [],
@property (nonatomic,copy)NSString *name;//
@property (nonatomic,copy)NSString *ordid;//
@property (nonatomic,copy)NSString *pid;//
@property (nonatomic,copy)NSString *remark;//
@property (nonatomic,copy)NSString *seo_desc;//
@property (nonatomic,copy)NSString *seo_keys;//
@property (nonatomic,copy)NSString *seo_title;//
@property (nonatomic,copy)NSString *spid;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *update_time;


@end
