
//
//  WGBToolsCell.m
//  666Tuangou
//
//  Created by jifeng on 16/1/10.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import "WGBToolsCell.h"


@interface WGBToolsCell ()

/**小图*/
@property (weak, nonatomic) IBOutlet UIImageView *showView;

/**标签*/
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end

@implementation WGBToolsCell


- (void)setModel:(WGBToolModel *)model
{

    _model =model;
    
    /**设置小图*/
    _showView.image = [UIImage imageNamed:model.imageName];
    
    /**设置标签*/
    _desLabel.text=model.desLabel;

}


@end
