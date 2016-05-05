//
//  WGBSpecialView.m
//  666Tuangou
//
//  Created by jifeng on 16/1/11.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBSpecialView.h"
#import "SpecialModel.h"




@interface WGBSpecialView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

@property (weak, nonatomic) IBOutlet UIImageView *imageView4;


@property (nonatomic,strong)NSMutableArray *keyArr;

@property (nonatomic,strong)NSMutableArray *cate_idArr;

@property (nonatomic,strong)NSMutableArray *nameArr;


@end

@implementation WGBSpecialView


#pragma mark-展示数据相关
/**
 *  设置展示图片以及添加手势 传值的处理
 *
 * specialData 从控制器传过来的模型数组 ctl -> headerView -> View
 */
-(void)getSpecialDataSourceWithArray:(NSArray *)specialData
{


    if (specialData.count) {



        _keyArr =[[NSMutableArray alloc]init];
        _cate_idArr=[NSMutableArray new];
        _nameArr =[NSMutableArray new];

        int i =0;
        for (SpecialModel *model in specialData) {

            if (i==0) {

                [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:model.img]];

                [_keyArr addObject:model.key];
                [_cate_idArr addObject:model.cate_id];
                [_nameArr addObject:model.name];

                self.imageView1.tag=1;

                /**
                 *  添加点击手势
                 */
                self.imageView1.userInteractionEnabled=YES;
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageView:)];

                [self.imageView1 addGestureRecognizer:tap];




            }else if(i==1){

                [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:model.img]];

                [_keyArr addObject:model.key];
                [_cate_idArr addObject:model.cate_id];
                [_nameArr addObject:model.name];


                self.imageView2.tag=2;
                self.imageView2.userInteractionEnabled=YES;
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageView:)];


                [self.imageView2 addGestureRecognizer:tap];


            }else if (i==2){


                [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:model.img]];

                [_keyArr addObject:model.key];
                [_cate_idArr addObject:model.cate_id];
                [_nameArr addObject:model.name];


                self.imageView3.tag=3;
                self.imageView3.userInteractionEnabled=YES;
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageView:)];


                [self.imageView3 addGestureRecognizer:tap];



            }else{

                [self.imageView4 sd_setImageWithURL:[NSURL URLWithString:model.img]];

                [_keyArr addObject:model.key];
                [_cate_idArr addObject:model.cate_id];
                [_nameArr addObject:model.name];


                self.imageView4.tag=4;
                self.imageView4.userInteractionEnabled=YES;
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageView:)];

                [self.imageView4 addGestureRecognizer:tap];
            }

            i++;

        }
    }

}


#pragma mark-传值跳转相关
/**
 *  手势回调方法
 */

- (void)clickImageView:(UIGestureRecognizer*)tap
{

    //    获取storyboard

    UIStoryboard *main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WGBSpecialViewController *svc=[main instantiateViewControllerWithIdentifier:@"WGBSpecialViewController"];

    /**
     *  传值
     */

    NSInteger index=tap.view.tag-1;//取下标
    
    svc.key=self.keyArr[index];
    svc.cate_id =self.cate_idArr[index];
    svc.name=self.nameArr[index];


    [[[self viewController] navigationController] pushViewController:svc animated:YES];
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


@end
