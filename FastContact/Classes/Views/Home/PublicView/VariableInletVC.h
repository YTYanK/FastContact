//
//  VariableInletVC.h
//  FastContact
//
//  Created by YTYanK on 17/1/16.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseListModel;

@interface VariableInletVC : UIViewController
/*
 标记
 */
@property (strong, nonatomic) NSString *inletSign;
@property (strong, nonatomic) NSArray <BaseListModel*> *baseList;

@end
