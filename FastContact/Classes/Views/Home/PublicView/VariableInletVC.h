//
//  VariableInletVC.h
//  FastContact
//
//  Created by YTYanK on 17/1/16.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseListModel;
@class SecCategoryListModel;

@interface VariableInletVC : UIViewController
/*
 标记
 */
@property (strong, nonatomic) NSString *inletSign;

@property (strong, nonatomic) NSArray <BaseListModel*> *baseList;
/// 按钮块集
@property (strong, nonatomic) NSMutableArray *buttonBlockViewAry;
/*
 初始化数据
 */

- (void)initVariableInletViewForBtnData:(NSArray *)data;

@end
