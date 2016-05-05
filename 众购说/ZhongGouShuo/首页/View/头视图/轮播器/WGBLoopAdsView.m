//
//  WGBLoopAdsView.m
//  666Tuangou
//
//  Created by jifeng on 16/1/11.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBLoopAdsView.h"
#import "AdScrollModel.h"

@interface WGBLoopAdsView ()<UIScrollViewDelegate>

/**
 *  滚动视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/**
 *  定时器
 */
@property (nonatomic,strong) NSTimer *timer;
/**
 *  翻页控件
 */
@property (weak, nonatomic) IBOutlet UIPageControl *page;

/**
 *  定时器计数
 */
@property (nonatomic,assign) NSInteger count;

/**
 *  数组计数
 */
@property (nonatomic,assign) NSInteger flag;

/**
 *  接收url的数组
 */
@property (nonatomic,strong) NSMutableArray *urlArr;
/**
 *  接收key的数组
 */
@property (nonatomic,strong) NSMutableArray *keyArr;
/**
 *  接收cate_id的数组
 */
@property (nonatomic,strong) NSMutableArray *cate_idArr;
/**
 *  接收name的数组
 */
@property (nonatomic,strong) NSMutableArray *nameArr;

@end

@implementation WGBLoopAdsView


/**
 *  初始化定时器
 */
- (void)awakeFromNib
{

    [self addTimer];

}


//接收外面传进来的数据
-(void)setLoopImagesWithArray:(NSArray *)images
{

    if (images.count) {

        /**
         *  取图片 和 url
         */
        NSMutableArray *dataImage=[NSMutableArray new];

        _urlArr=[NSMutableArray new];

        _keyArr=[NSMutableArray new];

        _cate_idArr=[NSMutableArray new];
        _nameArr =[NSMutableArray new];

        for (AdScrollModel *model in images) {

            [dataImage addObject:model.img];

            [_urlArr addObject:model.html];

            [_keyArr addObject:model.key];
            [_cate_idArr addObject:model.cate_id];
            [_nameArr addObject:model.name];

        }

        /**
         *  传图片给滚动视图
         */
        [self setScrollViewWithArray:dataImage];


    }

}

/**
 *  取到控制器
 */

-(UIViewController *)myViewcotroller{

    for (UIView *next=[self superview]; next; next=next.superview) {
        UIResponder* respomder=[next nextResponder];
        if ([respomder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)respomder;
        }
    }
    return nil;

}

//跳转传值 网页
- (void)pushNavgationControllerToWebView:(NSString*)url
{

    UIStoryboard *main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WGBWebViewController *webView=[main instantiateViewControllerWithIdentifier:@"WGBWebViewController"];

    webView.url=url;
    webView.shareText=[NSString stringWithFormat:@"浴袍更多精彩,更多优惠!!重磅出击!!!,%@",url];
    webView.imageName=nil;

    [[[self myViewcotroller] navigationController] pushViewController:webView animated:YES];
}

//传值 到 专场
- (void)pushNavgationControllerToSpecialControllerWith:(NSString*)key Cate_id:(NSString*)cate_id Name:(NSString*)name
{

    UIStoryboard *main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];

    WGBSpecialViewController *svc=[main instantiateViewControllerWithIdentifier:@"WGBSpecialViewController"];

    svc.key=key;
    svc.cate_id=cate_id;
    svc.name=name;


    [[[self myViewcotroller] navigationController] pushViewController:svc animated:YES];

}


#pragma mark-滚动视图
//创建滚动视图
- (void)setScrollViewWithArray:(NSArray*)images
{

    _flag=images.count+2;

    _scrollView.contentSize=CGSizeMake(KWidth*_flag, _scrollView.bounds.size.height);

    for (int i =0; i < _flag; i++) {

        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(KWidth*i, 0, KWidth, _scrollView.bounds.size.height)];

        if (i==0) {

            [imageView sd_setImageWithURL:[NSURL URLWithString:images[images.count-1]]];

        }else if(i==_flag-1){

            [imageView sd_setImageWithURL:[NSURL URLWithString:images[0]]];

        }else{

            [imageView sd_setImageWithURL:[NSURL URLWithString:images[i-1]]];
            imageView.tag=100+i;

            imageView.userInteractionEnabled=YES;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick:)];

            [imageView addGestureRecognizer:tap];

        }

        [_scrollView addSubview:imageView];

        _scrollView.contentOffset=CGPointMake(KWidth, 0);

        _page.numberOfPages=_flag-2;

        _page.currentPage=0;

        [self bringSubviewToFront:_page];


    }

}


/**
 *  手势回调方法
 *
 *  @param tap 点击手势
 */
- (void)TapClick:(UITapGestureRecognizer*)tap
{

    //    NSLog(@"第%ld个",tap.view.tag-100);
    NSInteger index = tap.view.tag-101;


    if (![_urlArr[index] isEqualToString:@""]) { //判断是网页的时候 跳转webView

        [self pushNavgationControllerToWebView:_urlArr[index]];
    }else{

        //不是网页 跳转专场

        [self pushNavgationControllerToSpecialControllerWith:_keyArr[index] Cate_id:_cate_idArr[index] Name:_nameArr[index]];
    }


}


/**
 *  添加定时器
 */
- (void)addTimer
{
    _count =1;

    self.timer =[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}

/**
 *  定时器回调方法
 */

- (void)updateTimer
{

    _count++;

    if (_count==_flag-1) {

        _count=1;
        _scrollView.contentOffset=CGPointMake(0, 0);
        
    }
    
    _page.currentPage=_count-1;
    
    [_scrollView setContentOffset:CGPointMake(KWidth*_count, 0) animated:YES];
}

#pragma mark- 代理方法
//滑动结束后计算pageControl的位置
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 循环移动:
    if (scrollView.contentOffset.x /KWidth==0) { // 第一张
        scrollView.contentOffset = CGPointMake(KWidth * _flag-2, 0); // 瞬间切换倒数第二张;
    }else if (scrollView.contentOffset.x / KWidth == _flag-1)// 最后一张
    {
        scrollView.contentOffset = CGPointMake(KWidth, 0); // 瞬间切换到第二张;
    }

    _page.currentPage = scrollView.contentOffset.x / KWidth - 1;
    _count = _page.currentPage + 1;
}


@end
