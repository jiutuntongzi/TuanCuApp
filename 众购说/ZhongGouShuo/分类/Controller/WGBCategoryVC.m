//
//  WGBCategoryVC.m
//  666Tuangou
//
//  Created by jifeng on 16/1/9.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBCategoryVC.h"
#import "Cate_listModel.h"
#import "Host_brandModel.h"
#import "WGBCategoryCell.h"
#import "WGBCateViewCell.h"
#import "WGBCateHeaderView.h"
#import "WGBHotsBrandsHeaderView.h"
#import "WGBBrandViewController.h"


@interface WGBCategoryVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *cateDataSource;

@property (nonatomic,strong) NSMutableArray *brandDataSource;

@end


@implementation WGBCategoryVC


#pragma mark-懒加载
/**
 *  数据源懒加载
 */

- (NSMutableArray *)cateDataSource
{
    if (!_cateDataSource) {
        _cateDataSource=[NSMutableArray new];
    }
    return _cateDataSource;
}

- (NSMutableArray *)brandDataSource
{
    if (!_brandDataSource) {
        _brandDataSource=[NSMutableArray new];
    }
    return _brandDataSource;
}




-(void)viewDidLoad
{
    [super viewDidLoad];

    [self registerCellAndHeaderView];
    /**
     *  请求数据
     */

    [self requestData];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=NO;

}


#pragma mark-注册视图(cell和头视图)相关

- (void)registerCellAndHeaderView
{
    //注册头视图

    [self.collectionView registerNib:[UINib nibWithNibName:@"WGBCateHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

    [self.collectionView registerNib:[UINib nibWithNibName:@"WGBHotsBrandsHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2"];
    /**
     *  注册cell
     */
    [self.collectionView registerNib:[UINib nibWithNibName:@"WGBCateViewCell" bundle:nil] forCellWithReuseIdentifier:@"cate1cell"];
    

}

#pragma mark-请求数据

- (void)requestData
{

    [self requestCateData];

    [self requestBrandData];

}



/**
 *  分类数据
 */
- (void)requestCateData{

    [WGBNetWorking postWithURL:KCATEGORY_URL andParams:nil competionBlock:^(NSURLResponse *response, NSError *error, id obj) {

        for (NSDictionary*dict in obj[@"data"][@"cate_list"]) {

            Cate_listModel *model=[Cate_listModel yy_modelWithDictionary:dict];

            [self.cateDataSource addObject:model];

        }

            [self.collectionView reloadData];
    }];

}

/**
 *  品牌数据
 */
- (void)requestBrandData
{
    [WGBNetWorking postWithURL:KCATEGORY_URL andParams:nil competionBlock:^(NSURLResponse *response, NSError *error, id obj) {


        for (NSDictionary*dict in obj[@"data"][@"host_brand"]) {

            Host_brandModel *model=[Host_brandModel yy_modelWithDictionary:dict];
            [self.brandDataSource addObject:model];


        }
        [self.collectionView reloadData];
    }];


}


#pragma mark <UICollectionViewDataSource>


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (section==0) {




        return self.cateDataSource.count;


    }else if (section==1){


        return self.brandDataSource.count;
    }

    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section==0) {

        WGBCateViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cate1cell" forIndexPath:indexPath];

        cell.model=self.cateDataSource[indexPath.row];


        return cell;

    }else if(indexPath.section==1){

        WGBCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];


        Host_brandModel *model =self.brandDataSource[indexPath.row];

        [cell.showCateImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];

        return cell;


    }

    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0) {

        return CGSizeMake(KWidth/3-20, KHight/4);
    }

    return CGSizeMake(KWidth/2-15, KHight/6);
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    if ([kind isKindOfClass:[UICollectionElementKindSectionHeader class]]) {

        if (indexPath.section==0) {

            WGBCateHeaderView *headerViewOne=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];

            return headerViewOne;

        }else{

            WGBHotsBrandsHeaderView *headerViewTwo=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2" forIndexPath:indexPath];
            
            return headerViewTwo;
        }

    }
    
    return nil;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0) {

        return CGSizeMake(KWidth, 120);

    }
    return CGSizeMake(KWidth, 30);
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0) {

        Cate_listModel *model=self.cateDataSource[indexPath.row];

        WGBSpecialViewController *svc=[self.storyboard instantiateViewControllerWithIdentifier:@"WGBSpecialViewController"];

        svc.key=nil;
        svc.cate_id=model.cate_id;
        svc.name=model.name;

        [self.navigationController pushViewController:svc animated:YES];


    }else if(indexPath.section==1){


        Host_brandModel *model=self.brandDataSource[indexPath.row];

        WGBBrandViewController *wvc=[self.storyboard instantiateViewControllerWithIdentifier:@"WGBBrandViewController"];
        wvc.brand_id=model.brand_id;

        [self.navigationController pushViewController:wvc animated:YES];


    }




}


@end
