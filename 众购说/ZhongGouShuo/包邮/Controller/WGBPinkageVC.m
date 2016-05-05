//
//  WGBPinkageVC.m
//  666Tuangou
//
//  Created by jifeng on 16/1/9.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBPinkageVC.h"
#import "ItemListModel.h"
#import "WGBHotsSalesCell.h"


@interface WGBPinkageVC ()

@property (weak, nonatomic) IBOutlet UIView *defaultView;

- (IBAction)defaultAction:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIView *salesView;


- (IBAction)salesAction:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIView *bestNewsView;

- (IBAction)bestNewsAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray  *data;

@property (nonatomic,strong) UIView *lastView;
@property (nonatomic,assign) NSInteger page;

@property (nonatomic,copy) NSString *order;
@property (nonatomic,copy) NSString *order_by;

@end

@implementation WGBPinkageVC


- (NSMutableArray *)data
{
    if (!_data) {
        _data=[NSMutableArray new];
    }
    return _data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    /**
     *  默认选中第一个
     */
    _lastView=self.defaultView;

    /**
     *  注册cell
     */
    [self registerCell];

    /**
     *  初始化参数
     */
    self.page=1;
    self.order=@"ordid";
    self.order_by=@"desc";

    //监测网络状态
    [self checkNetworkReachability];

    //上下拉刷新
    [self refreshData];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];


    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=NO;

}

#pragma mark- 注册cell
-(void)registerCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"WGBHotsSalesCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];

}

#pragma mark -点击事件相关

//默认
- (IBAction)defaultAction:(UIButton *)sender {


    /**
     *  移除旧数据
     */

    [self.data removeAllObjects];


    /**
     *  添加转动菊花
     */

    [self addShowHUDAndNetworkActivityIndicator];

    _lastView.backgroundColor=[UIColor whiteColor];
    _lastView = self.defaultView;

    self.defaultView.backgroundColor=[UIColor redColor];

    self.order=@"ordid";

    //根据点击事件改变参数
    sender.selected=!sender.selected;

    if (sender.selected) {
        self.order_by=@"asc";

    }else{

        self.order_by=@"desc";
    }
    
    [self reloadCollectionViewData];

}


//销量
- (IBAction)salesAction:(UIButton *)sender {

    /**
     *  移除旧数据
     */

    [self.data removeAllObjects];

    /**
     *  添加转动菊花
     */

    [self addShowHUDAndNetworkActivityIndicator];

    _lastView.backgroundColor=[UIColor whiteColor];
    _lastView = self.salesView;

    self.salesView.backgroundColor=[UIColor redColor];

    self.order=@"sales";


    //根据点击事件改变参数
    sender.selected=!sender.selected;

    if (sender.selected) {
        self.order_by=@"asc";

    }else{

        self.order_by=@"desc";
    }
    
    
    [self reloadCollectionViewData];

}


//最新

- (IBAction)bestNewsAction:(UIButton *)sender {

    /**
     *  移除旧数据
     */
    [self.data removeAllObjects];

    /**
     *  添加转动菊花
     */

    [self addShowHUDAndNetworkActivityIndicator];


    _lastView.backgroundColor=[UIColor whiteColor];
    _lastView = self.bestNewsView;

    self.bestNewsView.backgroundColor=[UIColor redColor];

    self.order=@"add_time";


    //根据点击事件改变参数
    sender.selected=!sender.selected;


    if (sender.selected) {
        self.order_by=@"asc";

    }else{

        self.order_by=@"desc";
    }
    
    [self reloadCollectionViewData];

}


#pragma mark-私有方法

/**
 *  刷新UI
 */
- (void)reloadCollectionViewData
{

    //异步请求数据

    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);//全局子队列

    dispatch_async(queue, ^{

        //    请求数据
        [self checkNetworkReachability];
    });


    dispatch_async(queue, ^{
        [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];


        dispatch_async(dispatch_get_main_queue(), ^{

            [self.collectionView reloadData];

        });

    });


}

#pragma mark-监测网络状态

- (void)checkNetworkReachability
{
    [self checkNetworkReachability:^{

        //有网才能请求数据
        [self requestData];

    } andNONetWork:^{

    }];

}


#pragma mark-刷新相关

- (void)refreshData
{

    /**
     *  下拉刷新
     */
    self.collectionView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{

        /**
         *  重置数据
         */
        self.page=1;

        /**
         *  加菊花
         */
        [self addShowHUDAndNetworkActivityIndicator];
        /**
         *  请求数据
         */

        [self checkNetworkReachability];
    }];


    /**
     *  上拉刷新
     */

    self.collectionView.footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

        self.page++;

        /**
         *  加菊花
         */
        [self addShowHUDAndNetworkActivityIndicator];
        /**
         *  请求数据
         */
        [self checkNetworkReachability];
    }];


}

#pragma mark-网络数据相关
- (void)requestData
{
        NSDictionary *params=nil;

            //9.9包邮专场

        NSDictionary*dictData1=@{@"key":@"baoyou",@"order":self.order,@"order_by":self.order_by,@"page":[NSString stringWithFormat:@"%zd",self.page],@"perpage":@"10"};
        NSString *string=[WGBTools objectTransformStringWithObject:dictData1];

        params=@{@"data" :string};


    /**
     *  请求数据
     *
     *  @param response 响应头
     *  @param error    错误信息
     *  @param obj      json数据
     */

    [WGBNetWorking postWithURL:KHOTSALES_URL andParams:params competionBlock:^(NSURLResponse *response, NSError *error, id obj) {
        /**
         *  下拉刷新 清空旧数据
         */
        if (self.collectionView.header.isRefreshing) {
            [self.data removeAllObjects];
        }
        /**
         *  刷新结束 移除菊花
         */
        [self removeShowHUDAndNetworkActivityIndicator];

        /**
         *  取消刷新
         */
        [self.collectionView.header endRefreshing];
        [self.collectionView.footer endRefreshing];


        /**
         *  解析数据
         */
        for (NSDictionary*dict in obj[@"data"][@"list"]) {

            ItemListModel *model=[ItemListModel yy_modelWithDictionary:dict];
            [self.data addObject:model];
        }

        /**
         *  刷新UI
         */
        [self.collectionView reloadData];

    }];

}

#pragma mark <UICollectionViewDataSource>

/**
 *  返回cell个数
 *  @param collectionView
 *  @param section
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.data.count;
}

/**
 *  给cell设置数据
 *  @param collectionView
 *  @param indexPath
 *
 *  @return 返回cell
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    WGBHotsSalesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    cell.itemListModel =self.data[indexPath.row];

    return cell;
}

//设置cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake((KWidth-30)/2, 180);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    /***上左下右*/
    
    return UIEdgeInsetsMake(5, 10,5, 10);
}

//设置纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 5.0f;
}

//设置横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 5.0f;
}

//传值 跳转

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    WGBWebViewController *webView=[self.storyboard instantiateViewControllerWithIdentifier:@"WGBWebViewController"];

    ItemListModel*model=self.data[indexPath.row];

    webView.url=model.url_h5;
    webView.shareText=[NSString stringWithFormat:@"%@,%@",model.title,model.url_h5];
    webView.imageName=model.img;

    [self.navigationController pushViewController:webView animated:YES];

}

@end
