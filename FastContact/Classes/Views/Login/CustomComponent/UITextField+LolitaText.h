//
//  UITextField+LolitaText.h
//  DataStatistics
//
//  Created by Kang on 16/3/21.
//  Copyright © 2016年 YTYangK. All rights reserved.
//

/// 定义 一个可以相互传值block 类型
typedef void (^textFieldVlueBlock)(_Nullable id vlue,   NSString * _Nullable  stampStr);

#import <UIKit/UIKit.h>

@protocol UITextFieldLolitaDelegate <NSObject>
@optional
- (void)addYTYanKTextFielLengthMethod:(nonnull UITextField *)field;

@end



@interface UITextField (LolitaText)


@property (assign, nonatomic) _Nullable id <UITextFieldLolitaDelegate> lolitaDelegate;



- (void)addObserverForWillKeyBoard:(nullable id)obj;
- (void)removeObserverForKeyBoard:(nonnull id)obj;

/**
 *  未完善的ToolBar 对象
 */
//- (void)addYTYanKToolBarView:(nonnull UIToolbar *)toolView withItem:(nullable UIButton *)itemBtn;
/**
 *  返回一个toolBar 对象
 */
+  (nullable UIToolbar *)topView;
/**
 *  返回一个barItem， 主要配合toolBar 对象使用
 */
+ (nullable UIButton *)barItem;

/**
 *  输入框样式 - 透明 - 带删除按钮
 */
+ (void)addYTYanKTextFielStyle1:(nonnull UITextField *)text withString:(nullable NSString *)str ;


/**
 *  定义的block
 */
@property (nonnull, strong, nonatomic) textFieldVlueBlock textFieldBlock;
/**
 *  监控过程，返回block 参数 - textField、键盘标识
 */
- (void)YTYanKTextFiledEditChangedObj:(nullable UITextField *)field;

@end
