//
//  WGBDaylyCell.m
//  666Tuangou
//
//  Created by jifeng on 16/1/15.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBDaylyCell.h"


@interface WGBDaylyCell ()

/**
 *  展示图
 */
@property (weak, nonatomic) IBOutlet UIImageView *showView;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *descripLabel;

/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/**
 *  原价
 */
@property (weak, nonatomic) IBOutlet UILabel *mPriceLabel;
/**
 *  折扣与包邮
 */
@property (weak, nonatomic) IBOutlet UILabel *ratesLabel;

/**
 *  logo
 */
@property (weak, nonatomic) IBOutlet UILabel *logoTypeLabel;

/**
 *  划线
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineWidth;

@end

@implementation WGBDaylyCell





- (void)awakeFromNib
{

    /*自定义颜色和背景设置
     改变UITableViewCell选中时背景色*/

    self.selectedBackgroundView=[[UIView alloc]initWithFrame:self.frame];

    self.selectedBackgroundView.backgroundColor=[UIColor colorWithRed:0 green:0.47 blue:1 alpha:0.7];


}


/**
 *  设置cell数据
 *
 *  @param model 数据模型
 */
- (void)setModel:(ItemListModel *)model
{

    _model =model;


    //展示图
    [_showView sd_setImageWithURL:[NSURL URLWithString:model.img]];


    //标题
    _descripLabel.text=model.title;


    //价格
    _priceLabel.text=[NSString stringWithFormat:@"￥%@",model.price];

    //原价
    _mPriceLabel.text=[NSString stringWithFormat:@"￥%@",model.mprice];
    /**
     *  折扣和邮递类型
     */
    _ratesLabel.text=model.rates;

    //设置logo
    if ([model.type integerValue]==1) {

        _logoTypeLabel.text=@"淘宝";
        _logoTypeLabel.backgroundColor=[UIColor orangeColor];
    }else{

        _logoTypeLabel.text=@"天猫";
        _logoTypeLabel.backgroundColor=[UIColor redColor];
    }

    /**
     *  划线的长度
     */
    self.lineWidth.constant=model.mSize.width+17.0f;

    /**
     *  把划线放到前面
     */
    [self.mPriceLabel bringSubviewToFront:self];



}



@end
