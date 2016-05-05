//
//  WGBHomePageVC.m
//  666Tuangou
//
//  Created by jifeng on 16/1/9.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBHomePageVC.h"
#import "AdScrollModel.h"
#import "BrandsModel.h"
#import "SpecialModel.h"
#import "AdsModel.h"
#import "WGBHotsSalesCell.h"
#import "WGBHeaderView.h"
#import "WGBSearchViewController.h"

@interface WGBHomePageVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/**轮播图的数据源*/
@property (nonatomic,strong) NSMutableArray *adHeaderDataSource;
/**品牌馆*/
@property (nonatomic,strong)NSMutableArray *brandsDataSource;

/***专场*/
@property (nonatomic,strong)NSMutableArray *specialDataSource;

/***广告位*/
@property (nonatomic,strong)NSMutableArray *adsDataSource;

/***限时特卖*/
@property (nonatomic,strong)NSMutableArray *hotsSaleData;

/**
 *  热卖商品列表
 */

@property (nonatomic,strong)NSMutableArray *goodsDataSource;

/**
 *  页数
 */
@property (nonatomic,assign) NSInteger page;

@property (nonatomic,assign)NSInteger totalPage;

@end

@implementation WGBHomePageVC

#pragma mark-数据源懒加载

/***轮播图的数据源*/
- (NSMutableArray *)adHeaderDataSource
{
    if (!_adHeaderDataSource) {
        _adHeaderDataSource=[NSMutableArray new];
    }
    return _adHeaderDataSource;
}

/**品牌馆数据源*/
- (NSMutableArray *)brandsDataSource
{
    if (!_brandsDataSource) {
        _brandsDataSource=[NSMutableArray new];
    }
    return _brandsDataSource;
}

/***专场数据源*/
- (NSMutableArray *)specialDataSource
{
    if (!_specialDataSource) {
        _specialDataSource=[NSMutableArray new];
    }
    return _specialDataSource;
}

/***广告位*/
- (NSMutableArray *)adsDataSource
{
    if (!_adsDataSource) {
        _adsDataSource=[NSMutableArray new];
    }
    return _adsDataSource;
}

/**限时热卖*/

- (NSMutableArray *)hotsSaleData
{
    if (!_hotsSaleData) {
        _hotsSaleData=[NSMutableArray new];
    }
    return _hotsSaleData;
}

/**
 *  商品列表
 */

- (NSMutableArray *)goodsDataSource
{
    if (!_goodsDataSource) {
        _goodsDataSource=[NSMutableArray new];
    }
    return _goodsDataSource;
}

#pragma mark-控制器生命周期

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.page=3;


    // 监测网络状态

    [self checkNetworkReachability];

    /**
     *  注册Cell
     */
    [self registerCells];

    /**
     *  注册组头视图
     */
    [self registerSectionHeaderView];


}

//视图将要出现时调用此方法
-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];

    /**
     *  隐藏系统导航栏(显示自定义的导航栏)
     */
    self.navigationController.navigationBar.hidden=YES;

    /**
     *  显示tabbar
     */

    self.tabBarController.tabBar.hidden=NO;

    /**
     *  设置tabbar的点击后的颜色
     */
    UITabBar *tab=self.tabBarController.tabBar;
    [tab setTintColor:[UIColor colorWithRed:1.0f green:38/255.0f blue:83/255.0f alpha:1.0f]];

}

/**
 *  设置状态栏的样式
 *
 *  @return 状态栏样式
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{

    return UIStatusBarStyleLightContent;
}

#pragma mark-注册Cell
- (void)registerCells
{
    /**
     *  限时热卖
     */
    [self.collectionView registerNib:[UINib nibWithNibName:@"WGBHotsSalesCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}
#pragma mark-注册组头视图
- (void)registerSectionHeaderView
{

    [self.collectionView registerClass:[WGBHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}


#pragma mark-私有方法
/**
 *  自动滚到底部
 *
 *  @param animated 是否动画
 */
- (void)scrollsToBottomAnimated:(BOOL)animated
{
    CGFloat offset = self.collectionView.contentSize.height - self.collectionView.bounds.size.height;
    if (offset > 0)
    {
        [self.collectionView setContentOffset:CGPointMake(0, offset) animated:NO];
    }
}

#pragma mark-监测网络状态

- (void)checkNetworkReachability{

    [self checkNetworkReachability:^{

        //有网才能请求数据
        [self requestData];

        /** 上下拉刷新***/
        [self refreshData];

    } andNONetWork:^{
        /**
         *  清空旧数据
         */
        [self.adHeaderDataSource removeAllObjects];
        [self.brandsDataSource removeAllObjects];
        [self.specialDataSource removeAllObjects];
        [self.adsDataSource removeAllObjects];
        [self.hotsSaleData removeAllObjects];
        [self.goodsDataSource removeAllObjects];
    }];

}

#pragma mark-定制上下拉刷新
- (void)refreshData
{

    /**
     *  下拉刷新
     */

    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        /**
         *  重置上拉刷新的页数
         */
        self.page=4;

        /**
         *  加菊花
         */
        [self addShowHUDAndNetworkActivityIndicator];

         //请求更多数据
         [self requestHotsSalesData];
    }];



    /**
     *  上拉刷新
     */

    self.collectionView.footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

        /**
         *  加入菊花
         */

        [self addShowHUDAndNetworkActivityIndicator];

        /**
         *  请求更多数据
         */

         //请求更多数据

         [self requestMoreGoodsData];

        self.page++;


        if (self.page==33) {

            /**
             *  到底了 没有更多数据了
             */
            [self.collectionView.footer resetNoMoreData];
        }

    }];

}

#pragma mark-请求数据
/**
 *  请求数据
 */
- (void)requestData
{
    /**头部广告的数据*/

    [self requestAdData];

    /**品牌馆的数据*/

    [self requestBrandsData];

    /***专场的数据*/
    [self requestSpecialData];

    /***广告位的数据*/

    [self requestAdsData];


    /**限时热卖数据*/
    [self requestHotsSalesData];


}

/**请求头部广告的数据*/
-(void)requestAdData
{

    [WGBNetWorking postWithURL:KHOMEPAGE_URL andParams:nil competionBlock:^(NSURLResponse *response, NSError *error, id obj) {

        for (NSDictionary *dict in obj[@"data"][@"ad_list"]) {

            AdScrollModel *model=[AdScrollModel yy_modelWithDictionary:dict];

            [self.adHeaderDataSource addObject:model];

            [self.collectionView reloadData];

        }

    }];

}

/**请求品牌馆的数据*/
- (void)requestBrandsData
{

    [WGBNetWorking postWithURL:KHOMEPAGE_URL andParams:nil competionBlock:^(NSURLResponse *response, NSError *error, id obj) {

        for (NSDictionary *dict in obj[@"data"][@"brand_list"]) {

            BrandsModel *model=[BrandsModel yy_modelWithDictionary:dict];

            [self.brandsDataSource addObject:model];

            [self.collectionView reloadData];

        }

    }];

}

/*****专场数据请求***/
- (void)requestSpecialData
{

    [WGBNetWorking postWithURL:KHOMEPAGE_URL andParams:nil competionBlock:^(NSURLResponse *response, NSError *error, id obj) {

        for (NSDictionary *dict in obj[@"data"][@"ad_list2"]) {

            SpecialModel *model=[SpecialModel yy_modelWithDictionary:dict];

            [self.specialDataSource addObject:model];

            [self.collectionView reloadData];

        }

    }];


}

/**
 *  广告位数据
 */
- (void)requestAdsData
{


    [WGBNetWorking postWithURL:KHOMEPAGE_URL andParams:nil competionBlock:^(NSURLResponse *response, NSError *error, id obj) {

        for (NSDictionary *dict in obj[@"data"][@"ad_list3"]) {

            AdsModel  * model=[AdsModel yy_modelWithDictionary:dict];

            [self.adsDataSource addObject:model];

            [self.collectionView reloadData];

        }

    }];

}

/**
 *   限时热卖数据
 */
- (void)requestHotsSalesData
{
    [WGBNetWorking postWithURL:KHOMEPAGE_URL andParams:nil competionBlock:^(NSURLResponse *response, NSError *error, id obj) {

        /**
         *  判断是先上拉刷新  在进行下拉刷新时 让展示页面滚到底部(平滑过渡)
         */
        if (self.goodsDataSource.count) {

            [self scrollsToBottomAnimated:YES];
        }

        /**
         *  下拉刷新之前 清空之前的数据
         */

        if (self.collectionView.header.isRefreshing) {

            /**移除 下拉刷新数据*/
            [self.hotsSaleData removeAllObjects];
            /**移除 上拉刷新数据*/
            [self.goodsDataSource removeAllObjects];
        }

        /**
         *  结束刷新
         */

        [self.collectionView.header endRefreshing];
        /**
         *  隐藏菊花
         */

        [self removeShowHUDAndNetworkActivityIndicator];


        /**
         *  遍历数组字典 转模型数组
         */

        for (NSDictionary *dict in obj[@"data"][@"hots_item_list"]) {

            FlashSaleModel  * model=[FlashSaleModel yy_modelWithDictionary:dict];

            [self.hotsSaleData addObject:model];

        }

        //刷新UI
        [self.collectionView reloadData];

    }];

}

/**
 *  请求更多商品数据
 */
- (void)requestMoreGoodsData
{

    NSDictionary*params=@{@"page":[NSString stringWithFormat:@"%ld",self.page],@"perPage":@"10",@"key":@"index"};

    //字典转字符串 拼特殊请求头
    NSString *string = [WGBTools objectTransformStringWithObject:params];

    NSDictionary *dic = @{@"data":string};


    [WGBNetWorking postWithURL:KHOTSALES_URL andParams:dic competionBlock:^(NSURLResponse *response, NSError *error, id obj) {

        /**
         *  结束上拉刷新
         */

        [self.collectionView.footer endRefreshing];

        /**
         *  隐藏菊花
         */

        [self removeShowHUDAndNetworkActivityIndicator];


        /**
         *  遍历数组字典 转模型数组
         */

        for (NSDictionary *dic in obj[@"data"][@"list"]) {

            FlashSaleModel  * model=[FlashSaleModel yy_modelWithDictionary:dic];

            [self.goodsDataSource addObject:model];
        }
        //刷新UI
        [self.collectionView reloadData];

    }];

}

#pragma mark <UICollectionViewDataSource>

//返回item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (_goodsDataSource.count) {
        return _goodsDataSource.count;
    }


    return self.hotsSaleData.count;
}

//设置item的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    WGBHotsSalesCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    if (_goodsDataSource.count) {

        cell.model =self.goodsDataSource[indexPath.row];

        return cell;
    }

    cell.model =self.hotsSaleData[indexPath.row];

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


//返回头视图
- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    WGBHeaderView *headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];

    /**
     *  头部滚动广告,品牌馆,专场,广告位各个模型数组 导入组头
     */

    //    头部滚动广告
    [headerView getArrayWithDataSource:self.adHeaderDataSource Type:WGBSCrollAdsType];

    //  品牌馆
    [headerView getArrayWithDataSource:self.brandsDataSource Type:WGBBrandsType];

    //    专场
    [headerView getArrayWithDataSource:self.specialDataSource Type:WGBSpecialType];
    //  广告位
    [headerView getArrayWithDataSource:self.adsDataSource Type:WGBAdsType];
    return headerView;
}

//返回组头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(KWidth, (KHight/3)+(KHight/6)+(KHight/2)-5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WGBWebViewController *wvc=[self.storyboard instantiateViewControllerWithIdentifier:@"WGBWebViewController"];
    
    FlashSaleModel*model=[FlashSaleModel new];
    
    if (_goodsDataSource.count) {
        
        model =self.goodsDataSource[indexPath.row];
        wvc.url=model.url_h5;
        wvc.shareText=[NSString stringWithFormat:@"%@%@",model.title,model.url_h5];
        wvc.imageName=model.img;
        
        [self.navigationController pushViewController:wvc animated:YES];
        
    }else if (self.hotsSaleData.count){
        
        model =self.hotsSaleData[indexPath.row];
        
        wvc.url=model.url_h5;
        wvc.shareText=[NSString stringWithFormat:@"%@%@",model.title,model.url_h5];
        wvc.imageName=model.img;
        
        [self.navigationController pushViewController:wvc animated:YES];
    }
    
}

#pragma mark-导航栏按钮点击回调
//搜索放大镜
- (IBAction)leftSearchAction:(id)sender {

    WGBSearchViewController *svc=[self.storyboard instantiateViewControllerWithIdentifier:@"WGBSearchViewController"];

    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];

    [self.navigationController pushViewController: svc animated:YES];

}



@end
