//
//  ContentView.h
//  FastContact
//
//  Created by YTYanK on 17/1/11.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContentViewDelegate <NSObject>
- (void)buttonListClickWithView:(UIView *)view forButton:(UIButton *)sender;
@end

@interface ContentView : UIView
@property (weak, nonatomic) id <ContentViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *mailList;

@end
