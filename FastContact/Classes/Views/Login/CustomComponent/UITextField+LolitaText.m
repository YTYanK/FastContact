//
//  UITextField+LolitaText.m
//  DataStatistics
//
//  Created by Kang on 16/3/21.
//  Copyright © 2016年 YTYangK. All rights reserved.
//

#import "UITextField+LolitaText.h"
#import "NSString+EmojiExtension.h"
#import <objc/runtime.h>

@implementation UITextField (LolitaText)


@dynamic  lolitaDelegate;
@dynamic textFieldBlock;

// 键盘监控
- (void)addObserverForWillKeyBoard:(id)obj {
    
    //增加监听，当键盘出现或改变时接收出消息
    [[NSNotificationCenter defaultCenter] addObserver:obj selector:@selector(LTkeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键盘退出时接收出消息
    [[NSNotificationCenter defaultCenter] addObserver:obj selector:@selector(LTkeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)removeObserverForKeyBoard:(id)obj {
    [[NSNotificationCenter defaultCenter] removeObserver:obj name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:obj name:UIKeyboardWillShowNotification object:nil];
}
/** 子类重写 -当键盘出现或改变时调用 */
- (void)LTkeyboardWillShow:(NSNotification *)not {}
/** 子类重写 -当键盘退出时调用 */
- (void)LTkeyboardWillHide:(NSNotification *)not {}






// text输入监控
- (void)addTextFiledNotDidFortext {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledDidBeginEditingNot:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditingNot:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeNot:) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)removeTextFiledNotDidFortext {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

/** 子类重写 -失去焦点时调用 */
- (void)textFieldDidEndEditingNot:(NSNotification *)not {
//    if (_lolitadelegate != nil && [_lolitadelegate respondsToSelector:@selector(textFieldDidEndEditingNotification:)]) {
//        [self.lolitadelegate textFieldDidEndEditingNotification:not];
//    }
}
/** 子类重写 -持续获取焦点时调用 */
- (void)textFieldDidChangeNot:(NSNotification *)not {
//    if (_lolitadelegate != nil && [_lolitadelegate respondsToSelector:@selector(textFieldDidChangeNotification:)]) {
//        [self.lolitadelegate textFieldDidChangeNotification:not];
//    }
}
/** 子类重写 -获取焦点时调用 */
- (void)textFiledDidBeginEditingNot:(NSNotification *)not {
//    if (_lolitadelegate != nil && [_lolitadelegate respondsToSelector:@selector(textFiledDidBeginEditingNotification:)]) {
//        [self.lolitadelegate textFiledDidBeginEditingNotification:not];
//    }
}

// 样式 1
+ (void)addYTYanKTextFielStyle1:(UITextField *)text withString:(nullable NSString *)str{
//    if (SCREEN_WIDTH == 320) {
//        [self setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.f]];
//    }else {
//        [self setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.f]];
//    }


    [text setClearButtonMode:UITextFieldViewModeWhileEditing]; // 清楚按钮

    //[text setTintColor:[UIColor whiteColor]];//光标
    [text setBorderStyle:UITextBorderStyleNone];// 边框样式
    [text setAutocorrectionType:UITextAutocorrectionTypeNo]; // 自动校正型
    [text setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    //[text setTextColor:[UIColor whiteColor]]; //字体颜色
    [text setClearsOnBeginEditing:NO];
   // UIImage *imageBack = [UIImage imageNamed:@"textFieldBack"]; //需要换成一条颜色
  //  [self setBackground:imageBack];
    //[self setValue:placeholerLabelFont forKeyPath:@"_placeholderLabel.font"];
    //[self setValue:placeholderLabelColor forKeyPath:@"_placeholderLabel.textColor"];
    
    NSMutableParagraphStyle *style = [text.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    
    if (SCREEN_WIDTH == 320) {
       style.minimumLineHeight = text.font.lineHeight - (text.font.lineHeight - [UIFont systemFontOfSize:15.f].lineHeight) / 2.0;  // 判断大小选择字体
    }else {
        style.minimumLineHeight =  text.font.lineHeight - (text.font.lineHeight - [UIFont systemFontOfSize:18.f].lineHeight) /2.0;
    }
     UIColor *color = [UIColor colorWithWhite:144/255.0f alpha:1.0f];
    
    text.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:[UIFont systemFontOfSize:15.f],NSParagraphStyleAttributeName:style}];
    
    [text setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];  // 垂直对齐
    [text setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];// 水平对齐
    
   // [text addTarget:target action:action forControlEvents:UIControlEventEditingChanged];
    
    //[self addTextFiledNotDidFortext];
    UIButton* clearButton = [text valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:@"关闭按钮"] forState:UIControlStateNormal];
    [clearButton setImage:[UIImage imageNamed:@"关闭按钮-on"] forState:UIControlStateHighlighted];
}



// 样式 2
- (void)addYTYanKTextFielStyle2:(UITextField *)text withString:(NSString *)str {
    
    text.clearButtonMode       = UITextFieldViewModeUnlessEditing;
    NSMutableParagraphStyle *style = [text.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = text.font.lineHeight - (text.font.lineHeight - [UIFont systemFontOfSize:15.f].lineHeight) / 2.0;
    text.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:15.f],NSParagraphStyleAttributeName:style}];
    
    UIButton* clearButton = [text valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:@"关闭按钮"] forState:UIControlStateNormal];
    [clearButton setImage:[UIImage imageNamed:@"关闭按钮-on"] forState:UIControlStateHighlighted];

}

// 添加toolBar ---未完成
+ (UIToolbar *)addYTYanKToolBarViewBg:(UIColor *)color barItemStr:(NSString *)str setAction:(SEL)action {
    UIToolbar * topView = [UITextField topView];
    // _topview.backgroundColor =  RGB(26, 32, 40, 1);//RGB(28, 28, 28, 1);
    // _topview.barTintColor = RGB(26, 32, 40, 1);
    // [_topview setBarStyle:UIBarStyleBlackOpaque];
    [topView setBackgroundImage:[UIImage imageNamed:@"bottom-bg"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    UIButton *barItem = [UITextField barItem];
    [topView addSubview:barItem];
  return topView;
}



+  (nullable UIToolbar *)topView {
    
   /* if (SYSTEM_VERSION_EQUAL_TO_W_orH(SCREEN_HEIGHT, @"568.0")) {
        UIToolbar * topview   = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
        topview.backgroundColor = RGB(28, 28, 28, 1);
        [topview setBarStyle:UIBarStyleBlack];
        [topview setBackgroundImage:[UIImage imageNamed:@"bottom-bg"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        return topview;
        
    }else if (SYSTEM_VERSION_EQUAL_TO_W_orH(SCREEN_HEIGHT,@"667.0")) {
        UIToolbar * topview   = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        topview.backgroundColor = RGB(28, 28, 28, 1);
        [topview setBarStyle:UIBarStyleBlack];
        [topview setBackgroundImage:[UIImage imageNamed:@"bottom-bg"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        return topview;
        
        
    }else if (SYSTEM_VERSION_EQUAL_TO_W_orH(SCREEN_HEIGHT,@"736.0")) {
        
        UIToolbar * topview   = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        topview.backgroundColor = RGB(28, 28, 28, 1);
        [topview setBarStyle:UIBarStyleBlack];
        [topview setBackgroundImage:[UIImage imageNamed:@"bottom-bg"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        return topview;
        
    }*/
    return nil;

    
    
    
}
+  (nullable UIButton *)barItem {
    
  
   /* if (SYSTEM_VERSION_EQUAL_TO_W_orH(SCREEN_HEIGHT, @"568.0")) {
        UIButton *baritem = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 38 - 29, 0, 50, 35)];
        [baritem setTitle:NSLocalizedString(@"next", nil) forState:UIControlStateNormal];
        baritem.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
        baritem.userInteractionEnabled = NO;
        [baritem setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal
         ];
        return baritem;

    }else if (SYSTEM_VERSION_EQUAL_TO_W_orH(SCREEN_HEIGHT,@"667.0")) {
        UIButton *baritem = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 38 - 30, 0, 50, 40)];
        [baritem setTitle:NSLocalizedString(@"next", nil) forState:UIControlStateNormal];
        baritem.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];

        baritem.userInteractionEnabled = NO;
        [baritem setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal
         ];
        return baritem;

        
    }else if (SYSTEM_VERSION_EQUAL_TO_W_orH(SCREEN_HEIGHT,@"736.0")) {
        
        UIButton *baritem = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 38 - 31, 0, 50, 44)];
        [baritem setTitle:NSLocalizedString(@"next", nil) forState:UIControlStateNormal];
        baritem.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];

        baritem.userInteractionEnabled = NO;
        [baritem setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal
         ];
        return baritem;

    }*/
    return nil;
}




// TODO: 添加输入框监控
//UIKIT_EXTERN NSString * const YTYanKAttributeName NS_AVAILABLE(10_0, 6_0);     // UIColor, default
// 监控NickName中文输入方法(限制长度)
- (void)YTYanKTextFiledEditChangedObj:(UITextField *)field  {
   // __weak typeof(self)  weakSelf  = self;
    NSString* toBeString = field.text;
    //NSString* lang = [[UITextInputMode currentInputMode] primaryLanguage];
    
    NSArray *ary = [UITextInputMode activeInputModes];
    UITextInputMode *current = [ary firstObject];
    
    
    // 简体中文输入，包括简体拼音，健体五笔，简体手写
    if ([current.primaryLanguage isEqualToString:@"zh-Hans"] || [current.primaryLanguage isEqualToString:@"zh-Hant"]) {
        UITextRange* selectedRange = [field markedTextRange];        //获取高亮部分
        UITextPosition* position = [field positionFromPosition:selectedRange.start offset:0];
        
        if (!position) { // 等于 nil 时才确定没有高亮部分
             self.textFieldBlock(field, current.primaryLanguage);
        }
    }else if ([current.primaryLanguage isEqualToString:@"emoji"])  {
        field.text = [toBeString removeEmoji];
            self.textFieldBlock(field, current.primaryLanguage);
    }else if ([current.primaryLanguage isEqualToString:@"en-US"]) {
            self.textFieldBlock(field, current.primaryLanguage);
    }
}


#pragma  mark - set/get
- (textFieldVlueBlock)textFieldBlock {
    return objc_getAssociatedObject(self, @selector(textFieldBlock));
}

- (void)setTextFieldBlock:(textFieldVlueBlock)textFieldBlock {
    objc_setAssociatedObject(self, @selector(textFieldBlock), textFieldBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



@end
