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
/// 记录的标题标签
static NSString *const Nav_Title = @"variableInletNabTitle";
/// 记录点击都方块编号标签
static NSString *const Block_Tag = @"variableInletBlockTag";
/// 状态
static NSString *const Inlet_State = @"状态";
/// 类型
static NSString *const Inlet_Type = @"类型";
/// 筛选
static NSString *const Inlet_Screen = @"筛选";



@interface VariableInletVC : UIViewController
/**
 *  首页入口标记
 */
@property (strong, nonatomic) NSString *inletSign;

/// 导航条标题
@property (strong, nonatomic) NSString *navTitle;
/// 块集数据
@property (strong, nonatomic) NSArray <BaseListModel*> *baseList;
/// 按钮块集
@property (strong, nonatomic) NSMutableArray *buttonBlockViewAry;


/*
 初始化数据
 */
- (void)initVariableInletViewForBtnData:(NSArray *)data;

@end
