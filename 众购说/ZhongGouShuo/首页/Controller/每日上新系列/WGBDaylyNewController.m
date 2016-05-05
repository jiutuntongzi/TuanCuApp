//
//  WGBDaylyNewController.m
//  666Tuangou
//
//  Created by jifeng on 16/1/15.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBDaylyNewController.h"
#import "WGBDaylyCell.h"

@interface WGBDaylyNewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *titleViewLabel;

@property (weak, nonatomic) IBOutlet UIView *defaultView;

@property (weak, nonatomic) IBOutlet UIView *salesView;


@property (weak, nonatomic) IBOutlet UIView *bestNewsView;

/**
 *  记录点击事件 改变背景颜色
 */
@property (nonatomic,strong)UIView *lastView;



@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataSource;

@end


@implementation WGBDaylyNewController


- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];
    }
    return _dataSource;
}

- (void)viewDidLoad
{

    [super viewDidLoad];


    /**
     *  初始化参数(默认)
     */
    self.page=1;

    _lastView = _defaultView;

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


#pragma mark-点击事件相关

/**
 *
 * 返回
 */
- (IBAction)backAction:(UIButton*)sender {


    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  默认
 */
- (IBAction)defaultClickAction:(UIButton*)sender {

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

    //异步请求数据

    [self reloadTableViewData];


}

/**
 *  销量
 */
- (IBAction)salesAction:(UIButton*)sender {

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

    //异步请求数据

    [self reloadTableViewData];

    
}



/**
 *  最新
 */

- (IBAction)bestNewAction:(UIButton*)sender {

    /**
     *  移除旧数据
     */
    [self.dataSource removeAllObjects];



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



    [self reloadTableViewData];


}



#pragma mark-私有方法


- (void)reloadTableViewData
{

    //异步请求数据

    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);//全局子队列

    dispatch_async(queue, ^{

        //    请求数据
        [self checkNetworkReachability];

        //滚动到顶部
        [self.tableView setContentOffset:CGPointMake(0, 0)animated:YES];

        //异步刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.tableView reloadData];
        });
        
    });


}



#pragma mark-网络监测相关
- (void)checkNetworkReachability
{
    [self  checkNetworkReachability:^{

        //有网才能请求数据
        [self requestData];

    } andNONetWork:^{

    }];

}

#pragma mark-上下拉刷新相关
- (void)refreshData
{

    /**
     *  下拉刷新
     */
    self.tableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{

        self.page=1;

        [self checkNetworkReachability];
    }];

    /**
     *  上拉刷新
     */

    self.tableView.footer =[MJRefreshAutoNormalFooter  footerWithRefreshingBlock:^{

        self.page++;

        [self checkNetworkReachability];

    }];

}

#pragma mark-网络请求数据相关

- (void)requestData
{

    NSDictionary *dictData = @{@"cate_id":self.cate_id,@"key":self.key,@"order":self.order,@"order_by":self.order_by,@"page":[NSString stringWithFormat:@"%ld",self.page],@"perpage":@"10"};
    /**
     *  字典转字符串
     */
    NSString *string=[WGBTools objectTransformStringWithObject:dictData];

    NSDictionary *params=@{@"data":string};

    /**
     *  请求数据
     *
     *  @param response 响应头
     *  @param error    错误信息
     *  @param obj      json数据
     */

    [WGBNetWorking postWithURL:KHOTSALES_URL andParams:params competionBlock:^(NSURLResponse *response, NSError *error, id obj) {

        /**
         *  下拉刷新清空旧数据
         */
        if(self.tableView.header.isRefreshing){

            [self.dataSource removeAllObjects];
        }

        /**
         *  移除菊花
         */
        [self removeShowHUDAndNetworkActivityIndicator];


        /**
         *  解析数据
         */
        for (NSDictionary*dict in obj[@"data"][@"list"]) {

            ItemListModel *model=[ItemListModel yy_modelWithDictionary:dict];

            [_dataSource addObject:model];
        }


        /**
         *  刷新UI
         */
        [self.tableView reloadData];

        /**
         *  结束刷新
         */
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];


    }];


}


#pragma mark - tableView代理方法
/**
 *
 *  @param tableView 表格视图
 *  @param section     组
 *
 *  @return         返回cell个数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}

//设置cell的内容

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    WGBDaylyCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.model=self.dataSource[indexPath.row];

    return cell;
}

//选择某一个商品 (传值 跳转详情页面)
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    WGBWebViewController *wvc=[self.storyboard  instantiateViewControllerWithIdentifier:@"WGBWebViewController"];


    ItemListModel *model=self.dataSource[indexPath.row];

    wvc.url=model.url_h5;
    wvc.shareText=[NSString stringWithFormat:@"%@,%@",model.title,model.url_h5];
    wvc.imageName=model.img;

    [self.navigationController pushViewController:wvc animated:YES];

}


@end
