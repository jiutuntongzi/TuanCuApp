//
//  WGBHotsSalesCell.m
//  666Tuangou
//
//  Created by jifeng on 16/1/11.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBHotsSalesCell.h"


@interface WGBHotsSalesCell ()

/**
 *  展示图
 */
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
/**
 *  描述
 */
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

/**
 *  原价
 */
@property (weak, nonatomic) IBOutlet UILabel *marketPriceLabel;
/**
 *  划线的宽度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineWidthConstraint;

@end

@implementation WGBHotsSalesCell

#pragma mark-限时热卖

/**
 *  限时热卖 商品的展示数据设置
 */
- (void)setModel:(FlashSaleModel *)model
{

    _model =model;

    /**
     *  设置展示图
     */
    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];

    /**
     *  设置标题
     */
    self.desLabel.text=model.title;

    /**
     *  价格
     */
    self.priceLabel.text=[NSString stringWithFormat:@"￥%@",model.price];

    /**
     *  原价
     */
    self.marketPriceLabel.text=[NSString stringWithFormat:@"￥%@",model.mprice];

    /**
     *  划线的长度
     */
    self.lineWidthConstraint.constant=model.mSize.width+14.0f;


    [self.marketPriceLabel bringSubviewToFront:self];
}

#pragma mark-品牌馆
/**
 *  品牌馆 商品的展示数据设置
 */

-(void)setItemModel:(BrandsItemModel *)itemModel
{

    _itemModel =itemModel;


    /**
     *  设置展示图
     */
    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.img]];

    /**
     *  设置标题
     */
    self.desLabel.text=itemModel.title;

    /**
     *  价格
     */
    self.priceLabel.text=[NSString stringWithFormat:@"￥%@",itemModel.price];

    /**
     *  原价
     */
    self.marketPriceLabel.text=[NSString stringWithFormat:@"￥%@",itemModel.mprice];

    /**
     *  划线的长度
     */
    self.lineWidthConstraint.constant=itemModel.mSize.width+14.0f;


    [self.marketPriceLabel bringSubviewToFront:self];
    
}

#pragma mark-专场

-(void)setItemListModel:(ItemListModel *)itemListModel
{

    _itemListModel =itemListModel;

    /**
     *  设置展示图
     */
    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:itemListModel.img]];

    /**
     *  设置标题
     */
    self.desLabel.text=itemListModel.title;

    /**
     *  价格
     */
    self.priceLabel.text=[NSString stringWithFormat:@"￥%@",itemListModel.price];

    /**
     *  原价
     */
    self.marketPriceLabel.text=[NSString stringWithFormat:@"￥%@",itemListModel.mprice];

    /**
     *  划线的长度
     */
    self.lineWidthConstraint.constant=itemListModel.mSize.width+14.0f;

    [self.marketPriceLabel bringSubviewToFront:self];

}



@end
