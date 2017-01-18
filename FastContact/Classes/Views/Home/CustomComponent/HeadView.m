//
//  HeadView.m
//  FastContact
//
//  Created by YTYanK on 17/1/11.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "HeadView.h"

@interface HeadView()
@property (weak, nonatomic) IBOutlet UIImageView *headPortrait;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *ascription;
@property (weak, nonatomic) IBOutlet UILabel *stagnationPoint;

@property (weak, nonatomic) IBOutlet UILabel *nameVlue;
@property (weak, nonatomic) IBOutlet UILabel *numberVlue;
@property (weak, nonatomic) IBOutlet UILabel *ascriptionVlue;
@property (weak, nonatomic) IBOutlet UILabel *stagnationPointVlue;
@property (weak, nonatomic) IBOutlet UIButton *checkin;
@end

@implementation HeadView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self updateUI];
}

- (void)updateUI {
    
    
    CGFloat headPortraitH = self.headPortrait.height;
    self.headPortrait.layer.cornerRadius = headPortraitH/2;
    self.headPortrait.layer.borderColor = RGB(66, 66, 66, 1).CGColor;
    self.headPortrait.layer.borderWidth = 1.f;
    self.headPortrait.layer.masksToBounds = YES;
    self.headPortrait.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headPortraitClick:)];
    [self.headPortrait addGestureRecognizer:gesture];
    
    CGFloat checkinH = self.checkin.height;
    self.checkin.layer.cornerRadius = checkinH/2;
    
}

- (void)headPortraitClick:(UIImageView *)view {
    NSLog(@"－－－>头像");
}

- (IBAction)checkinClick:(id)sender {
    NSLog(@"－－－>签入");
}


@end
