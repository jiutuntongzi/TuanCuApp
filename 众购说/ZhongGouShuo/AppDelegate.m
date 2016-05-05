//
//  AppDelegate.m
//  666Tuangou
//
//  Created by jifeng on 16/1/9.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "AppDelegate.h"
#import "WGBMyTabbarViewController.h"


@interface AppDelegate ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.


    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];

//    设置根控制器

    UIStoryboard *main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];

    WGBMyTabbarViewController *tabarCtl=[main instantiateViewControllerWithIdentifier:@"WGBMyTabbarViewController"];

    self.window.rootViewController=tabarCtl;


    [UIApplication sharedApplication].statusBarHidden=YES;
    /**
     * 设置引导页
     */
    [self fristLoad];


    /**
     *  设置appkey
     */

    [UMSocialData setAppKey:KAPPKEY];



    return YES;
}


//分享回调方法
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等

    }
    return result;
}


//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}




//状态栏的格式
- (UIStatusBarStyle)preferredStatusBarStyle
{


    return UIStatusBarStyleLightContent;
}

//引导页相关
-(void)fristLoad{


    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"first"]) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.window.bounds];

        _scrollView.contentSize = CGSizeMake(KWidth * 4, KHight);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;

        _scrollView.showsHorizontalScrollIndicator=NO;
        
        for (int i = 0; i < 4; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWidth * i, 0, KWidth, KHight)];
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_help%d.png", i + 1]];
            if (i == 3) {
                imageView.userInteractionEnabled = YES;
                UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];

                b.frame=CGRectMake(0, 0, KWidth,KHight);
                b.backgroundColor = [UIColor clearColor];
                [b addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

                UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(60, KHight-60, KWidth, 40)];
                label.text=@"点击进入";
                label.font =[UIFont systemFontOfSize:24];
                label.textAlignment=NSTextAlignmentCenter;
                label.textColor=[UIColor redColor];
                label.backgroundColor=[UIColor clearColor];


                [imageView addSubview:label];
                [imageView addSubview:b];
            }

            [_scrollView addSubview:imageView];
        }

        [self.window addSubview:_scrollView];
        [UIApplication sharedApplication].statusBarHidden=NO;

    }


}

//butto点击回调
- (void)click:(UIButton *)button
{
    [UIView animateWithDuration:2.0f animations:^{
        _scrollView.transform = CGAffineTransformScale(_scrollView.transform, 1.5, 1.5);
        _scrollView.alpha = 0;
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
        [[NSUserDefaults standardUserDefaults] setObject:@"abc" forKey:@"first"];
    }];
}



- (void)applicationWillResignActive:(UIApplication *)application {



}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {


}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
