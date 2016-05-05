//
//  UIViewController+WGBExtension.h
//  ZhongGouShuo
//
//  Created by jifeng on 16/1/26.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HaveNetWorkBlock)(void);
typedef void(^NONetWorkBlock)(void);

@interface UIViewController (WGBExtension)

/**
 *  监测网络
 *  @param haveNetWorkBlock         有网时回调 block
 *  @param noNetWorkBlock           没网络时回调 block
 */
- (void)checkNetworkReachability:(HaveNetWorkBlock)haveNetWorkBlock andNONetWork:(NONetWorkBlock)noNetWorkBlock;

/**
 * 添加菊花
 */
- (void)addShowHUDAndNetworkActivityIndicator;


/**
 *  移除菊花
 */
- (void)removeShowHUDAndNetworkActivityIndicator;


/**
 *  弹窗方法
 *
 *  @param message 弹窗的信息
 */
-(void)showAlertViewWithMessage:(NSString *)message;



@end
