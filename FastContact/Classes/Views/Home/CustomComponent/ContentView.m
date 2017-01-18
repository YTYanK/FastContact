//
//  ContentView.m
//  FastContact
//
//  Created by YTYanK on 17/1/11.
//  Copyright © 2017年 YTYanK. All rights reserved.
//
          
#import "ContentView.h"

@implementation ContentView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
//    [self.mailList addTarget:self action:@selector() forControlEvents:UIControlEventTouchDown];
}
- (IBAction)mailListClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(buttonListClickWithView:forButton:)]) {
       [self.delegate buttonListClickWithView:self forButton:sender];
    }
   
}

@end
