//
//  WGBLoginStatusCell.m
//  666Tuangou
//
//  Created by jifeng on 16/1/10.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBLoginStatusCell.h"



@interface WGBLoginStatusCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *loginStatusLabel;



@end

@implementation WGBLoginStatusCell



- (void)awakeFromNib
{


    self.headerImageView.layer.cornerRadius=40.0f;
    

}


@end
