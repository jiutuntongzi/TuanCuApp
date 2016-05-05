//
//  WGBAdsView.m
//  666Tuangou
//
//  Created by jifeng on 16/1/11.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBAdsView.h"
#import "AdsModel.h"
#import "WGBDaylyNewController.h"


@interface WGBAdsView ()

@property (weak, nonatomic) IBOutlet UIImageView *adImageView1;

@property (weak, nonatomic) IBOutlet UIImageView *adImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *adImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *adImageView4;

@property (nonatomic,strong)NSMutableArray *keyArr;

@property (nonatomic,strong)NSMutableArray *cate_idArr;

@property (nonatomic,strong)NSMutableArray *nameArr;


@end


@implementation WGBAdsView


-(void)getAdsDataSourceWithArray:(NSArray *)adsData
{

    if (adsData.count) {

        _keyArr =[NSMutableArray new];
        _cate_idArr=[NSMutableArray new];
        _nameArr =[NSMutableArray new];


        int i =0;
        for (AdsModel *model in adsData) {

            if (i==0) {

                [self.adImageView1 sd_setImageWithURL:[NSURL URLWithString:model.img]];

                [_keyArr addObject:model.key];
                [_cate_idArr addObject:model.cate_id];
                [_nameArr addObject:model.name];

                self.adImageView1.tag=1;

                /**
                 *  添加点击手势
                 */
                self.adImageView1.userInteractionEnabled=YES;
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageView:)];

                [self.adImageView1 addGestureRecognizer:tap];



            }else if(i==1){

                [self.adImageView2 sd_setImageWithURL:[NSURL URLWithString:model.img]];

                [_keyArr addObject:model.key];
                [_cate_idArr addObject:model.cate_id];
                [_nameArr addObject:model.name];

                self.adImageView2.tag=2;

                /**
                 *  添加点击手势
                 */
                self.adImageView2.userInteractionEnabled=YES;
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageView:)];

                [self.adImageView2 addGestureRecognizer:tap];
            }else if (i==2){

                [self.adImageView3 sd_setImageWithURL:[NSURL URLWithString:model.img]];

                [_keyArr addObject:model.key];
                [_cate_idArr addObject:model.cate_id];
                [_nameArr addObject:model.name];

                self.adImageView3.tag=3;

                /**
                 *  添加点击手势
                 */
                self.adImageView3.userInteractionEnabled=YES;
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageView:)];

                [self.adImageView3 addGestureRecognizer:tap];

            }else{
                

                [self.adImageView4 sd_setImageWithURL:[NSURL URLWithString:model.img]];

                [_keyArr addObject:model.key];
                [_cate_idArr addObject:model.cate_id];
                [_nameArr addObject:model.name];


                self.adImageView4.tag=4;

                /**
                 *  添加点击手势
                 */
                self.adImageView4.userInteractionEnabled=YES;
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageView:)];

                [self.adImageView4 addGestureRecognizer:tap];



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

    /**
     *  取出storyboard
     */
     UIStoryboard *main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];

    /**
     *  取下标
     */

    NSInteger index=tap.view.tag-1;


    /**
     *  判断 { is 每日上新 ?  WGBDaylyNewController : WGBSpecialViewController }
     */

    if ([_keyArr[index] isEqualToString:@"is_new"]) {


        WGBDaylyNewController *wvc=[main instantiateViewControllerWithIdentifier:@"WGBDaylyNewController"];

        wvc.key=@"is_new";
        wvc.cate_id =self.cate_idArr[index];
        wvc.name=self.nameArr[index];

        [[[self viewController] navigationController] pushViewController:wvc animated:YES];
    }else{


        WGBSpecialViewController *svc=[main instantiateViewControllerWithIdentifier:@"WGBSpecialViewController"];

        svc.key=self.keyArr[index];
        svc.cate_id =self.cate_idArr[index];
        svc.name=self.nameArr[index];


        [[[self viewController] navigationController] pushViewController:svc animated:YES];

    }

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
