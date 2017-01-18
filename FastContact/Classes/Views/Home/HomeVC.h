//
//  HomeVC.h
//  FastContact
//
//  Created by YTYanK on 17/1/10.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeadView;
@class ContentView;

@interface HomeVC : UIViewController

@property (weak, nonatomic) IBOutlet HeadView *headView;
@property (strong, nonatomic) IBOutlet ContentView *contentView;

@end
