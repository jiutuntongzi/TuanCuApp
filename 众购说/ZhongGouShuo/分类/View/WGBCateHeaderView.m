//
//  WGBCateHeaderView.m
//  666Tuangou
//
//  Created by jifeng on 16/1/18.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBCateHeaderView.h"
#import "WGBSpecialViewController.h"


@interface WGBCateHeaderView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchBarTF;

- (IBAction)searchGoodsAction:(UIButton *)sender;

@property (nonatomic,strong) FMDatabase *database;

@end

@implementation WGBCateHeaderView



-(void)awakeFromNib
{
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


}


/**
 *  搜索
 */

- (IBAction)searchGoodsAction:(UIButton *)sender {

//    NSLog(@"搜索...%@",_searchBarTF.text);

    UIStoryboard *main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];



    WGBSpecialViewController *wvc=[main instantiateViewControllerWithIdentifier:@"WGBSpecialViewController"];

    wvc.keyword =_searchBarTF.text;
    wvc.name=_searchBarTF.text;


    if (![self.database executeUpdate:@"insert into Keywords (keyword) values (?)",_searchBarTF.text]) {

//        NSLog(@"插入失败");

    }else{

//        NSLog(@"成功");
    }

    _searchBarTF.text=@"";
    
    [self endEditing:YES];
    
    [[[self viewController] navigationController]pushViewController:wvc animated:YES];

}


/**
 *  退出键盘
 *
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self endEditing:YES];

}



/**
 *  获取控制器
 *
 */

- (UIViewController*)viewController{


    for (UIView*next=[self superview]; next; next=next.superview) {

        UIResponder *responder=[next nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]) {

            return (UIViewController*)responder;
        }

    }

    return nil;
}


#pragma mark -return

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [self.searchBarTF resignFirstResponder];

    return YES;
}



@end
