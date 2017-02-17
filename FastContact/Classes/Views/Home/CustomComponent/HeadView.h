//
//  HeadView.h
//  FastContact
//
//  Created by YTYanK on 17/1/11.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadViewDelegate <NSObject>
- (void)headViewPortraitForImageView:(UIImageView *)view;
@end

@interface HeadView : UIView
@property (weak, nonatomic) id <HeadViewDelegate>delegate;
@property (weak, nonatomic) UIViewController *vc;
@property (weak, nonatomic) IBOutlet UILabel *nameVlue;
@property (weak, nonatomic) IBOutlet UILabel *numberVlue;
@property (weak, nonatomic) IBOutlet UILabel *ascriptionVlue;
@property (weak, nonatomic) IBOutlet UILabel *stagnationPointVlue;
@property (weak, nonatomic) IBOutlet UIButton *checkin;
@property (nonatomic) int isonline;
@end
