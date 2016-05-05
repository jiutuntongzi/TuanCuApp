//
//  WGBBrandsView.m
//  666Tuangou
//
//  Created by jifeng on 16/1/11.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBBrandsView.h"
#import "BrandsModel.h"
#import "WGBBrandViewController.h"

@interface WGBBrandsView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollWidth;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong)NSMutableArray *brandIDArr;

@end

@implementation WGBBrandsView

- (NSMutableArray *)brandIDArr
{
    if (!_brandIDArr) {
        _brandIDArr=[NSMutableArray new];
    }
    return _brandIDArr;
}



-(void)setImageWithArray:(NSArray *)BrandsArr
{
    
    if (BrandsArr.count) {


        int i =0;
        //设置scrollView的内容大小

        CGFloat w = (KWidth-20)/3 ; //一张图片的宽度

        self.scrollWidth.constant=w*BrandsArr.count+5*(BrandsArr.count+1);


        //遍历模型数组
        for (BrandsModel*model in BrandsArr) {

            //循环创建图片
            UIImageView *imageView=[[UIImageView alloc]init];
            imageView.frame=CGRectMake(w*i+(i+1)*5, 0, w, self.scrollView.frame.size.height);

            //设置tag
            imageView.tag =i+1;

            [self.brandIDArr addObject:model.brands_id];


            imageView.userInteractionEnabled=YES;

            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];

            [imageView addGestureRecognizer:tap];

            //设置图片
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.img]];

            [self.scrollView addSubview:imageView];
            
            i++;
            
        }
        
        
    }

}

- (void)click:(UIGestureRecognizer*)tap
{
    /**
     *  从Storyboard中获取并创建WGBBrandViewController这个控制器
     */
    UIStoryboard *main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];

    WGBBrandViewController *wvc=[main instantiateViewControllerWithIdentifier:@"WGBBrandViewController"];
    /**
     *  传值
     */
    wvc.brand_id =self.brandIDArr[tap.view.tag-1];

    /**
     *  跳转
     */
    [[[self viewcotroller] navigationController] pushViewController:wvc animated:YES];

}


/**
 *  获取控制器
 *
 */

-(UIViewController *)viewcotroller{

    for (UIView *next=[self superview]; next; next=next.superview) {
        UIResponder* respomder=[next nextResponder];
        if ([respomder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)respomder;
        }
    }
    return nil;


}

@end
