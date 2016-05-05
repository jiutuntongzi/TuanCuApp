//
//  UIView+WGBExtension.h
//  方便使用一些繁琐的视图操作
//  WGBExtension.h
//  坐标 {x,y,w,h} 位置{x,y}  尺寸{w,h}
//

#import <UIKit/UIKit.h>

@interface UIView (WGBExtension)


@property (nonatomic,assign) CGFloat x;

@property (nonatomic,assign) CGFloat y;

@property (nonatomic,assign) CGFloat w;

@property (nonatomic,assign) CGFloat h;

@property (nonatomic,assign) CGPoint origin;

@property (nonatomic,assign) CGSize size;

@end
