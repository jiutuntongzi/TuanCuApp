//
//  WGBMyCenterVC.m
//  666Tuangou
//
//  Created by jifeng on 16/1/9.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBMyCenterVC.h"
#import "WGBToolsCell.h"
#import "WGBLoginStatusCell.h"


@interface WGBMyCenterVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataOne;

@property (nonatomic,strong)NSMutableArray *dataTwo;

@end

@implementation WGBMyCenterVC


#pragma mark-数据源懒加载

- (NSMutableArray *)dataOne
{
    if (!_dataOne) {
        _dataOne=[NSMutableArray new];
    }
    return _dataOne;
}


- (NSMutableArray *)dataTwo
{
    if (!_dataTwo) {
        _dataTwo=[NSMutableArray new];
    }
    return _dataTwo;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setDataSource];


    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];

    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=NO;


}

#pragma mark-设置数据

- (void)setDataSource
{

    NSArray *desArr=@[@"淘宝订单",@"淘宝物流",@"帮助中心",@"清除缓存"];
    NSArray*imagesArr=@[@"taobaodingdan",@"wuliuxinxi",@"banzhuzhongxin",@"yijianfankui"];


    for (int i =0; i < 4; i++) {


        if (i < 2) {

            WGBToolModel *model=[WGBToolModel new];
            model.imageName = imagesArr[i];
            model.desLabel =desArr[i];

            [self.dataOne  addObject:model];

        }else{

            WGBToolModel *model=[WGBToolModel new];
            model.imageName = imagesArr[i];
            model.desLabel =desArr[i];

            [self.dataTwo addObject:model];
        }

    }

    [self.tableView reloadData];

}

#pragma mark-tableView的代理方法

/**分组*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{


    return 3;

}

//有几个同种类型的cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {

        return 1;
    }else if (section==1){

        return 2;
    }

    return 2;
}


//设置Cell
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0) {



        WGBLoginStatusCell*cell=[tableView dequeueReusableCellWithIdentifier:@"logincell"];

        //取消选中颜色

        UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView = backView;
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];

        //取消边框线

        [cell setBackgroundView:[[UIView alloc] init]];          //取消边框线
        cell.backgroundColor = [UIColor whiteColor];

        return cell;

    }else if (indexPath.section==1){


        WGBToolsCell *cell =[tableView dequeueReusableCellWithIdentifier:@"toolcell"];

        cell.model=self.dataOne[indexPath.row];

        //取消选中颜色

        UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView = backView;
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];

        //取消边框线

        [cell setBackgroundView:[[UIView alloc] init]];          //取消边框线
        cell.backgroundColor = [UIColor whiteColor];



        return cell;

    }

    WGBToolsCell *cell =[tableView dequeueReusableCellWithIdentifier:@"toolcell"];

    cell.model=self.dataTwo[indexPath.row];


    //取消选中颜色

    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];

    //取消边框线

    [cell setBackgroundView:[[UIView alloc] init]];          //取消边框线
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}








- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0) {

        return 86.0f;
    }

    return 50.0f;

}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    if (section==2) {

        return 0;
    }

    return 8;


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    [tableView deselectRowAtIndexPath:indexPath animated:NO];



    if (indexPath.section==0) {


        NSLog(@"登录");


    }else if (indexPath.section==1){

        WGBWebViewController *wvc=[self.storyboard instantiateViewControllerWithIdentifier:@"WGBWebViewController"];

        if (indexPath.row==0) {

            
            wvc.url=KTAOBAOORDER_URL;
        }else{
            
            wvc.url=KWULIU_URL;
        }

        WGBToolModel*model=self.dataOne[indexPath.row];

        wvc.titleLabel.text=model.desLabel;

        
        [self.navigationController pushViewController:wvc animated:YES];
        
    }else if (indexPath.section==2){
        
        if (indexPath.row==0) {
//             NSLog(@"1....");
        }else{

//            NSLog(@"2....");
            NSString *path = [NSHomeDirectory()stringByAppendingString:@"/Library/Caches"];
            [self actionWithCleanString:[NSString stringWithFormat:@"缓存大小为%.2fM，确定要清空缓存吗",[self folderSizeAtPath:path]]];
        }
        
        
    }
    

}


- (float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

-(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

- (void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}


- (void)actionWithCleanString:(NSString *)str
{
    UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];

    [a show];
}

#pragma mark - 代理方法:
// 选择哪一个按钮:
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{

    if (buttonIndex==0) {
        NSString *str = [NSHomeDirectory()stringByAppendingString:@"/Library/Caches"];
        [self clearCache:str];
    }
}




@end
