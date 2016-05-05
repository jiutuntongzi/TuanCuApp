
//  WGBCateViewCell.m
//  666Tuangou
//
//  Created by jifeng on 16/1/18.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBCateViewCell.h"


@interface WGBCateViewCell ()


@property (weak, nonatomic) IBOutlet UIImageView *showView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end


@implementation WGBCateViewCell



- (void)setModel:(Cate_listModel *)model

{

    _model = model;

    [_showView sd_setImageWithURL:[NSURL URLWithString:model.img]];

    _nameLabel.text=model.name;

}



@end
