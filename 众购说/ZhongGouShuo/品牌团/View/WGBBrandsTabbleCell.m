//
//  WGBBrandsTabbleCell.m
//  666Tuangou
//
//  Created by wanggguibin on 16/1/18.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBBrandsTabbleCell.h"


@interface WGBBrandsTabbleCell ()


@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end



@implementation WGBBrandsTabbleCell




- (void)setModel:(BrandsListTeamModel *)model
{
    _model = model;

    [_showImageView sd_setImageWithURL:[NSURL URLWithString:model.bimg]];


    _nameLabel.text=[NSString stringWithFormat:@"%@专场",model.title];


    _priceLabel.text =[NSString stringWithFormat:@"￥%@元起",model.lprice];

}



@end
