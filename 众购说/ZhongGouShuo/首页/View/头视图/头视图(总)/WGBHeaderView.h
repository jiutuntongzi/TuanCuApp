//
//  WGBHeaderView.h
//  666Tuangou
//
//  Created by jifeng on 16/1/11.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {

    WGBSCrollAdsType,
    WGBBrandsType,
    WGBSpecialType,
    WGBAdsType,

} DataSourceType;


@interface WGBHeaderView : UICollectionReusableView

//获取头部视图的数据源

-(void)getArrayWithDataSource:(NSArray*)data Type:(DataSourceType)type;



@end
