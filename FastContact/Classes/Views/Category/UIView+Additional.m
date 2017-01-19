//
//  UIView+Additional.m
//  FastContact
//
//  Created by YTYanK on 17/1/19.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "UIView+Additional.h"

@implementation UIView (Additional)
@dynamic borderWhich;

- (void)setBorderWhich:(ViewBorderType)borderWhich {
    CGFloat bh = self.layer.borderWidth;
    
    if (borderWhich & ViewBorderBottom) {
        [self addBottomBorder:self borderHeight:bh];
    }
    if (borderWhich & ViewBorderLeft) {
        [self addLeftBorder:self borderHeight:bh];
    }
    if (borderWhich & ViewBorderRight) {
        [self addRightBorder:self borderHeight:bh];
    }
    if (borderWhich & ViewBorderTop) {
        [self addTopBorder:self borderHeight:bh];
    }
    self.layer.borderWidth = 0;
}
- (void)addTopBorder:(UIView *)vi borderHeight:(CGFloat)bh {
    CGColorRef col = vi.layer.borderColor;
    if (vi.layer.borderWidth > 1000 || vi.layer.borderWidth == 0) {
        bh = 1;
    }
    else
        bh = vi.layer.borderWidth;
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(0, 0, vi.frame.size.width, bh);
    border.backgroundColor = col;
    [vi.layer addSublayer:border];
}
- (void)addLeftBorder:(UIView *)vi borderHeight:(CGFloat)bh{
    CGColorRef col = vi.layer.borderColor;
    if (vi.layer.borderWidth > 1000 || vi.layer.borderWidth == 0) {
        bh = 1;
    }
    else
        bh = vi.layer.borderWidth;
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(0, 0, bh, vi.frame.size.height);
    border.backgroundColor = col;
    [vi.layer addSublayer:border];
}
- (void)addBottomBorder:(UIView *)vi borderHeight:(CGFloat)bh{
    CGColorRef col = vi.layer.borderColor;
    if (vi.layer.borderWidth > 1000 || vi.layer.borderWidth == 0) {
        bh = 1;
    }
    else
        bh = vi.layer.borderWidth;
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(0, CGRectGetHeight(vi.frame), vi.frame.size.width, bh);
    border.backgroundColor = col;
    [vi.layer addSublayer:border];
}
- (void)addRightBorder:(UIView *)vi borderHeight:(CGFloat)bh{
    CGColorRef col = vi.layer.borderColor;
    if (vi.layer.borderWidth > 1000 || vi.layer.borderWidth == 0) {
        bh = 1;
    }
    else
        bh = vi.layer.borderWidth;
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(vi.frame.size.width-bh, 0, bh, vi.frame.size.height);
    border.backgroundColor = col;
    [vi.layer addSublayer:border];
}

// perhaps
+ (void)addViewBorder:(UIView *)v borderType:(ViewBorderType)type perhapsLayoutConstraints:(NSArray<__kindof NSLayoutConstraint *> *)Ary {

    
    CGColorRef color = v.layer.borderColor;
    CGFloat borderH;
    if (v.layer.borderWidth > 1000 || v.layer.borderWidth == 0) {
        borderH = 1;
    }
    else
        borderH = v.layer.borderWidth;
    
    if (Ary == nil) {
        if (type == ViewBorderTop || type == ViewBorderBottom || type == ViewBorderTopAndBottom ) {
            
            if (type == ViewBorderTop || type == ViewBorderTopAndBottom) {
                CALayer *topB = [CALayer layer];
                topB.frame = CGRectMake(0, 0, v.frame.size.width, borderH);
                topB.backgroundColor = color;
                [v.layer addSublayer:topB];
            }
            
            if (type == ViewBorderBottom || type == ViewBorderTopAndBottom) {
                CALayer *bottomB = [CALayer layer];
                bottomB.frame = CGRectMake(0, CGRectGetHeight(v.frame), v.frame.size.width, borderH);
                bottomB.backgroundColor = color;
                [v.layer addSublayer:bottomB];
            }
        }
        
        if (type == ViewBorderLeft || type == ViewBorderRight || type == ViewBorderLeftAndRight) {
            if (type == ViewBorderLeft || type == ViewBorderLeftAndRight) {
                CALayer *leftB = [CALayer layer];
                leftB.frame = CGRectMake(0, 0, borderH, v.frame.size.height);
                leftB.backgroundColor = color;
                [v.layer addSublayer:leftB];
            }
            
            if (type == ViewBorderRight || type == ViewBorderLeftAndRight) {
                CALayer *rightB = [CALayer layer];
                rightB.frame = CGRectMake(v.frame.size.width-borderH, 0, borderH, v.frame.size.height);
                rightB.backgroundColor = color;
                [v.layer addSublayer:rightB];
            }
            
        }
    }else {
        NSLayoutConstraint * layout = Ary[0];
        NSLog(@"--->%f",layout.constant);
        
        if (type == ViewBorderTop || type == ViewBorderBottom || type == ViewBorderTopAndBottom ) {
            
            if (type == ViewBorderTop || type == ViewBorderTopAndBottom) {
                CALayer *topB = [CALayer layer];
                topB.frame = CGRectMake(0, 0, v.frame.size.width, borderH);
                topB.backgroundColor = color;
                [v.layer addSublayer:topB];
            }
            
            if (type == ViewBorderBottom || type == ViewBorderTopAndBottom) {
                CALayer *bottomB = [CALayer layer];
                bottomB.frame = CGRectMake(0, layout.constant, v.frame.size.width, borderH);
                bottomB.backgroundColor = color;
                [v.layer addSublayer:bottomB];
            }
        }
    }

    
 
    
    
}
@end
