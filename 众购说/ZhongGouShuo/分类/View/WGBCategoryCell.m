//
//  WGBCategoryCell.m
//  666Tuangou
//
//  Created by jifeng on 16/1/18.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBCategoryCell.h"

@interface WGBCategoryCell ()



@end


@implementation WGBCategoryCell



- (void)awakeFromNib
{

    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.bounds];

    imageView.image=[UIImage imageNamed:@"biankuang"];

    self.backgroundView =imageView;

}


@end
