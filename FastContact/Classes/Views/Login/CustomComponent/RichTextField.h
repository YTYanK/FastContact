//
//  RichTextField.h
//  FastContact
//
//  Created by YTYanK on 17/1/9.
//  Copyright © 2017年 YTYanK. All rights reserved.
//
/*
 * // 丰富的输入框 如其名方便后期组件化
 */

#import <UIKit/UIKit.h>
#import "LoginHeader.h"


@interface RichTextField : UIView

// 数据
@property (strong, nonatomic) NSDictionary *richData;
// 大小／位置
@property (assign, nonatomic) CGRect richFarme;
// 图标
@property (strong, nonatomic) UIImageView *icon;
// 主题
@property (strong, nonatomic) UILabel *theme;
// 输入框
@property (strong, nonatomic) UITextField *inputBox;
// 主题颜色
@property (strong, nonatomic) UIColor *richThemeColor;
// 是否密码
@property (assign, nonatomic) BOOL richSecureTextEntry;
// 编号
@property (assign, nonatomic) int  richNo;


@end
