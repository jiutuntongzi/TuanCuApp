//
//  WGBHotsSalesCell.h
//  666Tuangou
//
//  Created by jifeng on 16/1/11.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashSaleModel.h"
#import "BrandsItemModel.h"
#import "ItemListModel.h"


@interface WGBHotsSalesCell : UICollectionViewCell

@property (nonatomic,strong) FlashSaleModel *model;

@property (nonatomic,strong) BrandsItemModel*itemModel;

@property (nonatomic,strong)ItemListModel *itemListModel;

@end
