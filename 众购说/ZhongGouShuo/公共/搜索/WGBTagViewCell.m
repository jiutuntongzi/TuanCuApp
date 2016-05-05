//
//  WGBTagViewCell.m
//  ZhongGouShuo
//
//  Created by jifeng on 16/1/19.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBTagViewCell.h"

CGFloat heightForCell = 25;


@interface WGBTagViewCell ()


@end


@implementation WGBTagViewCell

- (void)awakeFromNib {

    self.clipsToBounds = YES;
    self.layer.cornerRadius = heightForCell / 2;
}

- (void)setKeyword:(NSString *)keyword
{
    _keyword = keyword;
    _titleLabel.text = _keyword;
    [self layoutIfNeeded];
    [self updateConstraintsIfNeeded];
}

- (CGSize)sizeForCell {
    //宽度加 heightForCell 为了两边圆角
    return CGSizeMake([_titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + heightForCell, heightForCell);
}


@end
