//
//  WGBWebViewController.h
//  666Tuangou
//
//  Created by jifeng on 16/1/13.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGBWebViewController : UIViewController

/**
 *  路径
 */
@property (nonatomic,copy)NSString *url;

/**
 *  分享的内容
 */
@property (nonatomic,copy)NSString *shareText;

/**
 *  图片名
 */
@property (nonatomic,copy)NSString *imageName;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


@end
