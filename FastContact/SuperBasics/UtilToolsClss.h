//
//  UtilToolsClss.h
//  DataStatistics
//
//  Created by Kang on 16/2/4.
//  Copyright © 2016年 YTYangK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD.h"
//#import "YLZHoledView.h"//引导页

@interface UtilToolsClss : NSObject

//@property (strong, nonatomic,nonnull) UIButton *noDataBtn;
/** 提示框*/
@property (strong, nonatomic,nullable) UIAlertController *alert;

// 样式按钮
+ (UIButton *_Nonnull )noDataBtn:(NSString * _Nullable )str;
/**
 *  遮罩View
 */
//+ (UIView * _Nonnull )returnMaskKeyBoardvViewForObj:(id _Nullable)obj orMethod:(SEL _Nullable)method;
//
//+ (YLZHoledView *_Nonnull)returnMaskViewForObj:(_Null_unspecified id)obj maskLayerRect:(CGRect)aMask andFingerRect:(CGPoint)finger :(NSInteger)tag;
//
//+ (YLZHoledView * _Nonnull)returnMaskViewForObj:(id _Nonnull)obj maskLayerRect:(CGRect)aMask fingerPoint:(CGPoint)point setTag:(NSInteger)tag andImage:(UIImage *_Nullable)image imageAry:(NSArray <UIImage *> * _Nullable)ary;
//
//+ (YLZHoledView * _Nonnull)teturnMaskViewForObj:(id _Nonnull)obj maskLayerRect:(CGRect)aMask fingerPoint:(CGPoint)point setTag:(NSInteger)tag layerRadius:(CGFloat)radius andImage:(UIImage *_Nullable)image imageAry:(NSArray <UIImage *> * _Nullable)ary;

/**
 *   转换 UTF-8  字符
 *
 *  @param urlStr - 传入字符串
 *
 *  @return 返回 UTF-8 字符串 url
 */
+ ( NSString* _Nullable )addingPercentEscapesUsingEncodingWithurlStr:(NSString* _Nonnull )urlStr ;


/**
 *     获取一个手势对象
 *
 *  @param action 方法
 *  @param target 对象
 *
 *  @return UITapGestureRecognizer
 */
+ (UITapGestureRecognizer* _Nonnull )obtainTapGestureRecognizerObjectWithAction:(nullable SEL)action withTarget:(nullable id)target;


/**
 *  保留2位小数
 *
 *  @param vlue float 类型
 *
 *  @return 保留2位小数的字符串
 */
+ (NSString* _Nullable)aryFloatValue:(float)vlue;


/**
 *  清除（null）
 *
 *  @param vlue 需要判断的值 - id
 *
 *  @return 返回 0 或者 @“---”
 */
+ (_Nonnull id)handleWithNullVlue:(_Nullable id)vlue;

/**
 *  判断机型语言版本
 *
 *  @return 语言代码  1 -中文   2 -英文
 */
+ (int)judgeLocalLanguage;

/**
 *  共享 UtilToolsClss 类的对象
 *
 *  @return UtilToolsClss 实例对象
 */
+ ( UtilToolsClss * _Nonnull )getUtilTools;

/**
 *  添加等待加载
 */
- (void)addDoLoading;

/**
 *  移除等待加载
 */
- (void)removeDoLoading;

/**
 *  自动消失的白色提示框
 *
 *  @param cont 需要添加提示框的controller 对象
 *  @param str   标题
 *  @param mess 内容
 */
+ (void)addViewController:(UIViewController * _Nonnull )cont withTitleStr:(NSString * _Nullable)str withMessage:(NSString * _Nullable)mess;

/**
 *  自定义事件的提示框
 *
 *  @param vc       需要添加提示框的controller 对象
 *  @param str      标题
 *  @param mess     内容
 *  @param action   取消方法 - 默认是没有事件
 *  @param okAction 确定方法 - 默认是没有事件
 *  @param style    提示框类型
 *
 *  @return 返回一个UIAlertController 实例对象
 */
+ ( UIAlertController * _Nonnull )addViewController:( UIViewController * _Nullable )vc withTitleStr:( NSString * _Nullable )str withMessage:(NSString * _Nullable)mess withAction:( UIAlertAction * _Nullable )action withOKAction:( UIAlertAction * _Nullable )okAction withStyle:(UIAlertControllerStyle)style;



//+ (void)addTapGestureRecognizerForTarget:(nullable id)targert toView:(nullable UIView *)view toaction:(nullable SEL)action;


//权限警示框
+ ( nonnull UIAlertController *)addAlertControllerForAuthorizationStatus:( nonnull NSString *)alertControllerMessages;
//NSDate转NSString
+ (nonnull NSString *)stringFromDate:(nonnull NSDate *)date withDateFormat:( nonnull NSString *)format;
//NSString转NSDate
+ ( nonnull NSDate *)dateFromString:( nonnull NSString *)string  withDateFormat:( nonnull NSString *)format;
/**
 *  返回 其他地区的时差 （以国际时间为标准）
 *
 *  @param string 请输入如： yyyy-MM-dd HH:mm:ss 或 dd/MM/yyyy HH:mm:ss 的字符串时间样式
 *
 *  @return  系统时区时差 （秒数）
 */
+ (NSTimeInterval)Extends_dateFromString:(NSString * _Nullable)string withDateFormat:(NSString * _Nonnull)format;

//时间戳字符串转时间
+ (nonnull NSDate *)timestampStringTransformTimeCurrentPhoneTimeZooe:(nonnull NSString *)timestampString;
// 时间戳字符串转时间字符串
+ (nonnull NSString *)timestampStringTransformDateString:(nonnull NSString *)timestampString;

//字符串时间转成离现在的状态表示字符 ，比如 1小时前 1分钟前的表示方法
+ (nonnull NSString *)timeAgeWithChinaTimeTransformCurrentPhoneTimeZooe:(nonnull NSString *)timeString;
//今日0点后显示不同的时间格式
+ (nonnull NSString *)timeTransFormStringFormatForLess24h:(nonnull NSDate *)time;
@end
