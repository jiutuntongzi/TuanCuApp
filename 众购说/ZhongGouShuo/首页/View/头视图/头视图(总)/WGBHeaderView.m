//
//  WGBHeaderView.m
//  666Tuangou
//
//  Created by jifeng on 16/1/11.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBHeaderView.h"
#import "WGBAdsView.h"
#import "WGBBrandsView.h"
#import "WGBSpecialView.h"
#import "WGBLoopAdsView.h"

@interface WGBHeaderView ()

@property (nonatomic,strong) WGBLoopAdsView *loopView;

@property (nonatomic,strong) WGBBrandsView *brandView;

@property (nonatomic,strong) WGBSpecialView *specialView;

@property (nonatomic,strong) WGBAdsView *adView;
@end


@implementation WGBHeaderView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor=[UIColor colorWithRed:0.868 green:0.845 blue:0.960 alpha:1.000];


        /**
         *  无限滚动视图
         */
        _loopView=[[NSBundle mainBundle] loadNibNamed:@"WGBLoopAdsView" owner:self options:0][0];

        _loopView.frame =CGRectMake(0, 0, KWidth, KHight/4);

        [self addSubview:_loopView];


        /**
         *  品牌馆视图
         */
        _brandView=[[NSBundle mainBundle] loadNibNamed:@"WGBBrandsView" owner:self options:nil][0];

        _brandView.frame=CGRectMake(0, CGRectGetMaxY(_loopView.frame)+5, KWidth, KHight/6);

        [self addSubview:_brandView];


        /**
         *  专场视图
         */
        _specialView =[[NSBundle mainBundle] loadNibNamed:@"WGBSpecialView" owner:self options:nil][0];

        _specialView.frame=CGRectMake(0, CGRectGetMaxY(_brandView.frame)+10, KWidth, KHight/4);


        [self addSubview:_specialView];

        /**
         *  广告位的View
         */
        _adView=[[NSBundle mainBundle] loadNibNamed:@"WGBAdsView" owner:self options:nil][0];

        _adView.frame=CGRectMake(0, CGRectGetMaxY(_specialView.frame)+5, KWidth, KHight/4);
        
        [self addSubview:_adView];


        /**
         *  加一个标签
         */


        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_adView.frame)+5, KWidth, 15)];
        label.text=@"hot限时热卖🔥";
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:15];
        [self addSubview:label];


    }
    return self;
}



//获取头部视图的数据源
-(void)getArrayWithDataSource:(NSArray *)data Type:(DataSourceType)type
{

    if (!data.count) {

        return;
    }else{

        /**滚动视图的数据*/
        if (type==WGBSCrollAdsType) {

            [self.loopView setLoopImagesWithArray:data];

        }else if (type==WGBBrandsType){
            /**品牌视图的数据*/
            [self.brandView setImageWithArray:data];

        }else if (type==WGBSpecialType){
            /**专场视图的数据*/
            [self.specialView getSpecialDataSourceWithArray:data];

        }else if(type==WGBAdsType){
            /**每日上新视图的数据*/
            [self.adView getAdsDataSourceWithArray:data];

        }


    }


}

@end
