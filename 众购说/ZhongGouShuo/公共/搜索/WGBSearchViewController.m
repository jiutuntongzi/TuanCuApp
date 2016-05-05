//
//  WGBSearchViewController.m
//  ZhongGouShuo
//
//  Created by jifeng on 16/1/19.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBSearchViewController.h"
#import "WGBSpecialViewController.h"
#import "WGBTagViewCell.h"

@interface WGBSearchViewController ()<UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//搜索栏
@property (weak, nonatomic) IBOutlet UITextField *searchTF;

//返回
- (IBAction)backAction:(UIButton *)sender;

//底视图的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundViewHight;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong,nonatomic) WGBTagViewCell *cell;

//清除历史记录
- (IBAction)clearHistoryData:(UIButton *)sender;

//数据源数组
@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong) FMDatabase *database;


@end

@implementation WGBSearchViewController


#pragma mark-数据源懒加载

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];

        //实例化一个数据库对象
        self.database = [[FMDatabase alloc] initWithPath:[NSHomeDirectory() stringByAppendingString:@"/Documents/Keywords.rdb"]];

        //如果数据不存在,就创建一个数据库文件,如果存在,就直接打开数据库
        if (![self.database   open]) {

            //        NSLog(@"打开失败");

        }else{
            
            //        NSLog(@"%@",NSHomeDirectory());
            
        }

        //创建表
        //图片要储存进数据库,是以二进制的形式保存
        if (![self.database executeUpdate:@"create table if not exists Keywords (id integer primary key autoincrement ,keyword text)"]) {

            //        NSLog(@"创建表失败");
            
        }

        FMResultSet *set = [self.database executeQuery:@"select * from Keywords"];

        while ([set next]) {

            [_dataSource addObject:[set stringForColumn:@"keyword"]];
//            NSLog(@"%@",[set stringForColumn:@"keyword"]);
        }


    }
    return _dataSource;
}


#pragma mark-控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];

    self.backgroundViewHight.constant=0;

    //设置leftView
    UIImageView *leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_search"]];
    self.searchTF.leftView=leftView;
    // 设置左视图的模式:
    _searchTF.leftViewMode = UITextFieldViewModeAlways;

    /**
     *  注册cell
     */
    [self.collectionView registerNib:[UINib nibWithNibName:@"WGBTagViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];

    [self dataSource];
    [self.collectionView reloadData];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    WGBTagViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    cell.keyword=self.dataSource[indexPath.row];

    return cell;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (_cell == nil) {
        _cell = [[NSBundle mainBundle]loadNibNamed:@"WGBTagViewCell" owner:nil options:nil][0];
    }
    _cell.keyword = _dataSource[indexPath.row];

    CGSize cellSize =[_cell sizeForCell];

    if (_backgroundViewHight.constant < KHight-124) {

        _backgroundViewHight.constant=cellSize.height*(indexPath.row +2);
    }else{

        _backgroundViewHight.constant=KHight-124;
    }

    return cellSize;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    WGBSpecialViewController *svc=[self.storyboard instantiateViewControllerWithIdentifier:@"WGBSpecialViewController"];

    svc.keyword=self.dataSource[indexPath.row];
    svc.name=self.dataSource[indexPath.row];

    [self.navigationController pushViewController:svc animated:YES];

}


#pragma mark-点击事件相关


//取消搜索 返回原来控制器
- (IBAction)backAction:(UIButton *)sender {


        CATransition* transition = [CATransition animation];
        transition.duration = 1.0;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
    
        //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
        //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [[self navigationController] popViewControllerAnimated:NO];


#pragma mark-私有接口不能上架的
//    CATransition *transition = [CATransition animation];
//    transition.duration = 1.0f;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = @"cube";
//    transition.subtype = kCATransitionFromLeft;
//    transition.delegate = self;
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//
//    [self.navigationController popViewControllerAnimated:YES];

}



//清除历史记录
- (IBAction)clearHistoryData:(UIButton *)sender {


    self.backgroundViewHight.constant=0;

    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(120, KHight-40, 150, 30)];

    label.text=@"清除历史记录成功!";
    label.backgroundColor=[UIColor blackColor];
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.layer.cornerRadius=15.0f;
    label.clipsToBounds=YES;

    [self.view bringSubviewToFront:label];

    [self.view addSubview:label];

    //延时动画移除 label
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [UIView animateWithDuration:1.0 animations:^{

            label.alpha=0;

        } completion:^(BOOL finished) {

            [label removeFromSuperview];
        }];
        
    });


#pragma mark -删除表的操作


    //删除数据
    if (![self.database executeUpdate:@"delete from Keywords"]) {

//        NSLog(@"删除失败");

    }else{

//        NSLog(@"删除表成功");
    }

}

//退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self.view endEditing:YES];
}


#pragma mark -UITextFieldDelegate代理方法回调

// 按return按键时会调用:
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    WGBSpecialViewController *wvc=[self.storyboard instantiateViewControllerWithIdentifier:@"WGBSpecialViewController"];

    wvc.keyword=_searchTF.text;
    wvc.name=_searchTF.text;

#pragma mark-插入表的操作
    /**
     *  数据库插入操作
     *
     *  @param keyword 字段
     */
    if (![self.database executeUpdate:@"insert into Keywords (keyword) values (?)",_searchTF.text]) {

//        NSLog(@"插入失败");

    }else{

//        NSLog(@"成功");
    }

    _searchTF.text=@"";
    [self.view endEditing:YES];
    [self.navigationController pushViewController:wvc animated:YES];

    return YES;
}




@end
