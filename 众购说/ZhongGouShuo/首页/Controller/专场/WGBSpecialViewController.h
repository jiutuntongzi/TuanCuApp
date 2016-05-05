//
//  WGBSpecialViewController.h
//  666Tuangou
//
//  Created by jifeng on 16/1/14.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGBSpecialViewController : UIViewController

/**
 *  关键字
 */
@property (nonatomic,copy)NSString *keyword;
/**
 *  主题名
 */
@property (nonatomic,copy)NSString *name;
/**
*  类型id
*/
@property (nonatomic,copy)NSString *cate_id;

/**
 *  对应的名字
 */
@property (nonatomic,copy)NSString *key;

/**
 *  按什么来排序
 */
@property (nonatomic,copy)NSString *order;

/**
 *  升序或降序
 */
@property (nonatomic,copy)NSString *order_by;

/**
 *  页数
 */
@property (nonatomic,assign)NSInteger page;



@end
