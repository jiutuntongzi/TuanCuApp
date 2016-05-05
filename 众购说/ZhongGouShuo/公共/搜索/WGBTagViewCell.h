//
//  WGBTagViewCell.h
//  ZhongGouShuo
//
//  Created by jifeng on 16/1/19.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGBTagViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *keyword;


@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

- (CGSize)sizeForCell;

@end
