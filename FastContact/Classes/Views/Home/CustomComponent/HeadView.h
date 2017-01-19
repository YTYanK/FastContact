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
@end
