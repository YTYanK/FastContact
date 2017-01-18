//
//  ButtonBlockView.m
//  FastContact
//
//  Created by YTYanK on 17/1/17.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "ButtonBlockView.h"

@interface ButtonBlockView()
@property (strong, nonatomic) UIButton * btn;
@end

@implementation ButtonBlockView



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(frame), CGRectGetHeight(frame))];
        btn.layer.cornerRadius = 4.f;
        btn.layer.borderColor = RGB(202, 203, 204, 1).CGColor;
        btn.layer.borderWidth = 1.f;
        btn.backgroundColor = RGB(242, 243, 244, 1);
        //[btn setTintColor:[UIColor redColor]];
        [btn setTitleColor:RGB(112, 113, 114, 1) forState:UIControlStateNormal];
        self.btn = btn;
        [self addSubview:self.btn];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

#pragma mark - set
- (void)setText:(NSString *)text {
    _text = text;
    [self.btn setTitle:text forState:UIControlStateNormal];
}
- (void)setButtonBlockFrame:(CGRect)buttonBlockFrame {
    _buttonBlockFrame = buttonBlockFrame;
    self.btn.frame = buttonBlockFrame;
}


@end
