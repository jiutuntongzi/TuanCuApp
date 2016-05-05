//
//  WGBSpecialViewController.m
//  666Tuangou
//
//  Created by jifeng on 16/1/13.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBBrandViewController.h"
#import "WGBHotsSalesCell.h"
#import "WGBBrandsHeaderCell.h"
#import "BrandsListModel.h"

@interface WGBBrandViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

/**
 *  collectionView对象
 */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/**
 *  小模型数组
 */
@property (nonatomic,strong)NSMutableArray *data;

/**
 *  大模型数组
 */
@property (nonatomic,strong)NSMutableArray *bigData;

/**
 *  头部图片
 */
@property (nonatomic,copy) NSString *bigPic;

- (IBAction)backLastPageAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabels;


@end

@implementation WGBBrandViewController

/**
 *  数据源 懒加载
 *
 *  小模型数组
 */
- (NSMutableArray *)data
{
    if (!_data) {
        _data=[NSMutableArray new];
    }
    return _data;
}

/**
 *  数据源 懒加载
 *  大模型数组
 *
 */
- (NSMutableArray *)bigData
{
    if (!_bigData) {
        _bigData=[NSMutableArray new];
    }
    return _bigData;
}

#pragma mark-控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];

    /**
     *  取消自动下移64
     */
    self.automaticallyAdjustsScrollViewInsets=NO;

    //监测网络状态 请求数据
    [self checkNetworkReachability];

        /**
     *  注册cell
     */
    [self registerAboutCellAndReuseView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];


    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;

}



#pragma mark-注册相关
- (void)registerAboutCellAndReuseView
{
    /**
     *  注册cell
     */

            /**头部图片cell**/
    [self.collectionView registerNib:[UINib nibWithNibName:@"WGBBrandsHeaderCell" bundle:nil] forCellWithReuseIdentifier:@"header"];

             /**商品展示cell**/
    [self.collectionView registerNib:[UINib nibWithNibName:@"WGBHotsSalesCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}

#pragma mark-网络监测相关
- (void)checkNetworkReachability
{
    [self checkNetworkReachability:^{

        //有网才能请求数据
        [self requestData];

    } andNONetWork:^{

        [self.data removeAllObjects];
        [self.bigData removeAllObjects];

    }];

}

#pragma mark-网络数据相关
//请求数据
-(void)requestData
{
    /**
     *  拼参数
     */

    NSDictionary *dict=@{@"brand_id":self.brand_id};

    /**
     *  @{字典} 转化 @"字符串"
     */

    NSString *str =[WGBTools objectTransformStringWithObject:dict];

    /**
     *  拼接完整参数
     */

    NSDictionary*params=@{@"data":str};

    /**
     *  网络请求block
     *
     *  @param response 响应头
     *  @param error    错误信息
     *  @param obj      返回的json数据
     */

    [WGBNetWorking postWithURL:KBRANDS_URL andParams:params competionBlock:^(NSURLResponse *response, NSError *error, id obj) {

        /**
         *  大模型数据
         */
        BrandsListModel *model=[BrandsListModel yy_modelWithDictionary:obj[@"data"]];

        [self.bigData addObject:model];

        /**
         *  头部图片
         */
        self.bigPic = model.bimg;

        /**
         * 导航栏标题
         */
        self.titleLabels.text=model.title;

        if (model.item.count) {
            self.data =[model.item mutableCopy];
            
        }

        [self.collectionView reloadData];
    }];


    
}

#pragma mark <UICollectionViewDataSource>

//分2组cell
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 2;
}

/**
 *  @param collectionView
 *  @param section
 *
 *  @return 返回cell个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (section==0) {

        return self.bigData.count;
    }else{

        return self.data.count;
    }

}

/**
 *  @param collectionView
 *  @param indexPath
 *
 *  @return 设置数据 返回每个cell
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.section==0){

        WGBBrandsHeaderCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"header" forIndexPath:indexPath];

        [cell.showImageView sd_setImageWithURL:[NSURL URLWithString:self.bigPic]];

        return cell;

    }else{


        WGBHotsSalesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];


        cell.itemModel=self.data[indexPath.row];
        
        return cell;
        
    }
    
}

/**
 *
 *  @param collectionView
 *  @param collectionViewLayout 布局对象
 *  @param indexPath
 *
 *  @return 返回cell的尺寸
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {

        return CGSizeMake(KWidth-20, KHight/4);

    }else{

        return CGSizeMake((KWidth-30)/2, KHight/3);
    }
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    /***上左下右*/

    if (section==0) {
        return UIEdgeInsetsMake(10, 10,5, 10);
    }

    return UIEdgeInsetsMake(5, 10,10, 10);
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

/**
 *  跳转商品详情
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {

        [collectionView deselectItemAtIndexPath:indexPath animated:NO];

    }else if(indexPath.section==1){
        /**
         *  取出模型
         */

        BrandsItemModel *model=self.data[indexPath.row];

        /**
         *  创建webView
         */
        WGBWebViewController *wvc=[self.storyboard instantiateViewControllerWithIdentifier:@"WGBWebViewController"];

        /**
         *  传值
         */
        wvc.url =model.url_h5;
        wvc.shareText=[NSString stringWithFormat:@"%@,%@",model.title,model.url_h5];
        wvc.imageName=model.img;

        /**
         *  跳转
         */
        [self.navigationController pushViewController:wvc animated:YES];
    }
    
}


//返回

- (IBAction)backLastPageAction:(UIButton *)sender {


    [self.navigationController popViewControllerAnimated:YES];
}
@end
