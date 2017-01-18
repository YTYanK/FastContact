//
//  ButtonBlockView.h
//  FastContact
//
//  Created by YTYanK on 17/1/17.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ButtonBlockDelage <NSObject>

@end

@interface ButtonBlockView : UIView

@property (weak, nonatomic) NSString *text;
@property (assign, nonatomic) CGRect buttonBlockFrame;


@end
