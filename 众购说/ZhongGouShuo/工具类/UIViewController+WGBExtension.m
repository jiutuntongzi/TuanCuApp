//
//  UIViewController+WGBExtension.m
//  ZhongGouShuo
//
//  Created by jifeng on 16/1/26.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "UIViewController+WGBExtension.h"

@implementation UIViewController (WGBExtension)

#pragma mark- 网络监测
/**
 *  监测网络
 *  @param haveNetWorkBlock         有网时回调 block
 *  @param noNetWorkBlock           没网络时回调 block
 */
- (void)checkNetworkReachability:(HaveNetWorkBlock)haveNetWorkBlock andNONetWork:(NONetWorkBlock)noNetWorkBlock
{

    //检测网络状态
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];

    //开始检测
    [reachabilityManager startMonitoring];

    //设置回调block(网络状态发生变化就会回调以下block)
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {

        if (status==AFNetworkReachabilityStatusNotReachable) {

            //没网 友好提示用户

            [self addShowHUDAndNetworkActivityIndicator];

            [self showAlertViewWithMessage:@"⚡️网络异常,正在尝试重新连接..."];

            noNetWorkBlock();

        }else{


            [self removeShowHUDAndNetworkActivityIndicator];

            haveNetWorkBlock();

        }
        
    }];
    

}


#pragma mark- 转动菊花
/**
 * 添加菊花
 */
- (void)addShowHUDAndNetworkActivityIndicator
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
}


#pragma mark- 移除菊花

/**
 *  移除菊花
 */
- (void)removeShowHUDAndNetworkActivityIndicator
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;

}

#pragma mark- 弹窗方法

/**
 *  弹窗方法
 *
 *  @param message 弹窗的信息
 */
-(void)showAlertViewWithMessage:(NSString *)message{

//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];

    UIAlertController *alertVc=[UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction*confirmBtn=[UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleCancel handler:nil];

    [alertVc addAction:confirmBtn];

    [self presentViewController:alertVc animated:YES completion:nil];

}


#pragma mark-





@end
