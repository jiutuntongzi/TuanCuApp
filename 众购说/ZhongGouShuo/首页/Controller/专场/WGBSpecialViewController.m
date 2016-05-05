//
//  WGBSpecialViewController.m
//  666Tuangou
//
//  Created by jifeng on 16/1/14.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBSpecialViewController.h"
#import "WGBHotsSalesCell.h"

@interface WGBSpecialViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


/**
 *  返回按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *backButton;

/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleViewLabel;


/**
 *  默认的底图
 */
@property (weak, nonatomic) IBOutlet UIView *defaultView;

/**
 *  销量的底图
 */
@property (weak, nonatomic) IBOutlet UIView *salesView;

/**
 *  最新的底图
 */
@property (weak, nonatomic) IBOutlet UIView *bestNewView;
/**
 *  记录点击事件 改变背景颜色
 */
@property (nonatomic,strong)UIView *lastView;

/**
 *  collectionView对象
 */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/**
 *  数据源
 */
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation WGBSpecialViewController


/**
 *   数据源 懒加载
 */

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];
    }
    return _dataSource;
}

#pragma mark-控制器生命周期相关

- (void)viewDidLoad {
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


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    /**
     *  隐藏导航栏和tabbar
     */
    self.navigationController.navigationBar.hidden=YES;
    /**
     *  隐藏tabbar
     */
    self.tabBarController.tabBar.hidden=YES;
    /**
     *  设置导航栏标题
     */
    self.titleViewLabel.text=self.name;

}


///**
// *  设置9.9包邮的导航栏
// */
//- (void)navSettings
//{
//
//    if ([self.name isEqualToString:@"9.9包邮"]) {
//
//        self.tabBarController.tabBar.hidden=NO;
//
//        self.backButton.hidden=YES;
//
//    }
//}


#pragma mark- 注册cell
-(void)registerCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"WGBHotsSalesCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];

}

#pragma mark-按钮点击事件相关
/**
 *  返回
 *
 *  @param sender
 */
- (IBAction)popViewControllerAction:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}


/**
 *  默认
 *
 *  @param sender
 */
- (IBAction)defaultBtnAction:(UIButton*)sender {

    /**
     *  移除旧数据
     */

    [self.dataSource removeAllObjects];


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


/**
 *  销量
 *
 *  @param sender
 */
- (IBAction)salesAction:(UIButton *)sender {

    /**
     *  移除旧数据
     */

    [self.dataSource removeAllObjects];

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


/**
 *  最新
 *
 *  @param sender
 */
- (IBAction)bestNewAction:(UIButton *)sender {

    /**
     *  移除旧数据
     */
    [self.dataSource removeAllObjects];



    /**
     *  添加转动菊花
     */

    [self addShowHUDAndNetworkActivityIndicator];


    _lastView.backgroundColor=[UIColor whiteColor];
    _lastView = self.bestNewView;

    self.bestNewView.backgroundColor=[UIColor redColor];

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

        [self.dataSource removeAllObjects];

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

        //        if (self.page==11) {
        //            /**
        //             *  最多只能加载11页数据
        //             */
        //            [self.collectionView.footer noticeNoMoreData];
        //        }
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

    if ([self.key isEqualToString:@"baoyou"]) {//9.9包邮专场

        NSDictionary*dictData1=@{@"key":self.key,@"order":self.order,@"order_by":self.order_by,@"page":[NSString stringWithFormat:@"%zd",self.page],@"perpage":@"10"};
        NSString *string=[WGBTools objectTransformStringWithObject:dictData1];

        params=@{@"data" :string};

    }else if(!self.key&&!self.keyword){//分类

        NSDictionary *dictData2 = @{@"cate_id":self.cate_id,@"order":self.order,@"order_by":self.order_by,@"page":[NSString stringWithFormat:@"%zd",self.page],@"perpage":@"10"};

        NSString *string=[WGBTools objectTransformStringWithObject:dictData2];

        params=@{@"data":string};

    }else if(self.keyword){//搜索

        NSDictionary *dictData3 = @{@"keyword":self.keyword,@"order":self.order,@"order_by":self.order_by,@"page":[NSString stringWithFormat:@"%zd",self.page],@"perpage":@"10"};

        NSString *string=[WGBTools objectTransformStringWithObject:dictData3];

        params=@{@"data":string};


    }else if(self.cate_id&&self.key){//其它的专场

        NSDictionary *dictData4 = @{@"cate_id":self.cate_id,@"key":self.key,@"order":self.order,@"order_by":self.order_by,@"page":[NSString stringWithFormat:@"%zd",self.page],@"perpage":@"10"};

        NSString *string=[WGBTools objectTransformStringWithObject:dictData4];

        params=@{@"data":string};

    }








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
            [self.dataSource removeAllObjects];
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
            [self.dataSource addObject:model];
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

    return self.dataSource.count;
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

    cell.itemListModel =self.dataSource[indexPath.row];

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
    
    ItemListModel*model=self.dataSource[indexPath.row];
    
    webView.url=model.url_h5;
    webView.shareText=[NSString stringWithFormat:@"%@,%@",model.title,model.url_h5];
    webView.imageName=model.img;
    
    [self.navigationController pushViewController:webView animated:YES];
    
}

@end
