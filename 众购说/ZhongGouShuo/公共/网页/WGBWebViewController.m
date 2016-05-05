//
//  WGBWebViewController.m
//  666Tuangou
//
//  Created by jifeng on 16/1/13.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBWebViewController.h"

@interface WGBWebViewController ()<UMSocialUIDelegate,UMSocialDataDelegate>

- (IBAction)backLastPageAction:(UIButton *)sender;

- (IBAction)shareGoodsInfoAction:(UIButton *)sender;

@property (nonatomic,weak) IBOutlet UIWebView *webView;

@end

@implementation WGBWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /**
     创建webView
     */
    [self createWebView];


}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    /**
     *  设置导航栏
     */


    if ([self.title isEqualToString:@"淘宝订单"]||[self.title isEqualToString:@"淘宝物流"]) {

        self.navigationController.navigationBar.hidden=YES;

        [self createNav];


    }else{

        self.navigationController.navigationBar.hidden=YES;

    }


    /**
     *  隐藏tabbar
     */
    self.tabBarController.tabBar.hidden=YES;

}



- (void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];



}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];




}

- (void)createNav
{

    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 30, 30);

    [button setImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(callBack:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:button];

    self.navigationItem.leftBarButtonItem=left;


}


- (void)callBack:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark-商品详情 网页相关
/**
 创建webView
 */

- (void)createWebView
{


#if 0

    NSBlockOperation *opertionQueue=[NSBlockOperation blockOperationWithBlock:^{

        NSURL *webUrl=[[NSURL alloc]init];

        if (self.url) {

            webUrl=[NSURL URLWithString:self.url];

            [webView loadRequest:[NSURLRequest requestWithURL:webUrl]];
        }else{

            NSString *hixStr=@"?id=";

            self.url=[KDETAIL_URL stringByAppendingFormat:@"%@%@",hixStr,self.good_id];

            webUrl=[NSURL URLWithString:self.url];

            [webView loadRequest:[NSURLRequest requestWithURL:webUrl]];
        }



    }];

    NSOperationQueue *queue=[NSOperationQueue new];

    [queue addOperation:opertionQueue];

#endif


    //把耗时的操作放到子队列里  多线程异步刷新UI
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{

        NSURL *webUrl=[[NSURL alloc]init];

        if (self.url) {

         NSString * urlString =[self.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

            webUrl=[NSURL URLWithString:urlString];

            [self.webView loadRequest:[NSURLRequest requestWithURL:webUrl]];

        }


        dispatch_async(dispatch_get_main_queue(), ^{

            [self.view addSubview:self.webView];

        });

    });


}



//返回
- (IBAction)backLastPageAction:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

////分享
//
- (IBAction)shareGoodsInfoAction:(UIButton *)sender {

    UIImage *shareImage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageName]]];

    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:KAPPKEY
                                      shareText:self.shareText
                                     shareImage:shareImage
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToEmail,UMShareToSms,UMShareToFacebook,UMShareToTwitter,nil]
                                       delegate:self];
    
}

- (void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response
{

    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }


}



@end
