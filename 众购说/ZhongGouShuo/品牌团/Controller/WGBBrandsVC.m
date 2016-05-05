//
//  WGBBrandsVC.m
//  666Tuangou
//
//  Created by wanggguibin on 16/1/9.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBBrandsVC.h"
#import "WGBBrandsTabbleCell.h"
#import "WGBBrandViewController.h"

@interface WGBBrandsVC ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong)NSMutableArray  *dataSource;


@property (nonatomic,assign) NSInteger  page;
@end


@implementation WGBBrandsVC


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
    

    self.page=1;


    [self checkNetworkReachability];

    [self refreshData];
}


- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];


    self.navigationController.navigationBar.hidden =YES;

    self.tabBarController.tabBar.hidden=NO;

}



#pragma mark-私有方法

/**
 * 添加菊花
 */
- (void)addShowHUDAndNetworkActivityIndicator
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
}

/**
 *  移除菊花
 */
- (void)removeShowHUDAndNetworkActivityIndicator
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}


/**
 *  弹窗方法
 *
 *  @param message 弹窗的信息
 */
-(void)showAlertViewWithMessage:(NSString *)message{

    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

#pragma mark-监测网络状态

- (void)checkNetworkReachability
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

        }else{

            [self removeShowHUDAndNetworkActivityIndicator];
            //有网才能请求数据
            [self requestData];
            
            
        }
        
    }];
    
    
}



#pragma mark-定制上下拉刷新

- (void)refreshData
{
    self.tableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{

        self.page=1;

        [self addShowHUDAndNetworkActivityIndicator];

        [self checkNetworkReachability];
    }];



    self.tableView.footer =[MJRefreshAutoStateFooter  footerWithRefreshingBlock:^{

        self.page++;

        [self addShowHUDAndNetworkActivityIndicator];

        [self checkNetworkReachability];
    }];
}


#pragma mark-网络数据相关

- (void)requestData
{
//    data	{"page":1,"perPage":"10"}
    NSDictionary *dic =@{@"page":[NSString stringWithFormat:@"%ld",self.page],@"perPage" :@"10"};

    NSString *string =[WGBTools objectTransformStringWithObject:dic];

    NSDictionary *params=@{@"data":string};



    [WGBNetWorking postWithURL:KBRANDSTEAM_URL andParams:params competionBlock:^(NSURLResponse *response, NSError *error, id obj) {


        if (self.tableView.header.isRefreshing) {
            [self.dataSource removeAllObjects];
        }

        [self removeShowHUDAndNetworkActivityIndicator];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
        for (NSDictionary*dict in obj[@"data"][@"list"]) {

            BrandsListTeamModel *model=[BrandsListTeamModel yy_modelWithDictionary:dict];

            [self.dataSource addObject:model];
        }

        [self.tableView reloadData];
    }];

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WGBBrandsTabbleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.model =self.dataSource[indexPath.row];


    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


    BrandsListTeamModel *model=self.dataSource[indexPath.row];

    WGBBrandViewController *wvc=[self.storyboard instantiateViewControllerWithIdentifier:@"WGBBrandViewController"];

    wvc.brand_id=model.brand_id;

    [self.navigationController pushViewController:wvc animated:YES];

}



@end
