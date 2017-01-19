//
//  UIView+Additional.h
//  FastContact
//
//  Created by YTYanK on 17/1/19.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ViewBorderType) {
    ViewBorderTop = 1<<1,
    ViewBorderLeft = 1<<2,
    ViewBorderBottom = 1<<3,
    ViewBorderRight = 1<<4,
    ViewBorderTopAndBottom = 1<<5,
    ViewBorderLeftAndRight = 1<<6
};


@interface UIView (Additional)
@property (nonatomic, assign) ViewBorderType borderWhich;

+ (void)addViewBorder:(UIView *)v borderType:(ViewBorderType)type perhapsLayoutConstraints:(NSArray<__kindof NSLayoutConstraint *> *)Ary;
@end
