//
//  UtilToolsClss.m
//  DataStatistics
//
//  Created by Kang on 16/2/4.
//  Copyright © 2016年 YTYangK. All rights reserved.
//

#import "UtilToolsClss.h"

@interface UtilToolsClss ()<MBProgressHUDDelegate>
{
    UIView *BGwinodwView;
    MBProgressHUD *progressHUD;
    
}

@end

@implementation UtilToolsClss
static UtilToolsClss  *utilTool = nil;
+ (UtilToolsClss *)getUtilTools {
    if (!utilTool) {
        utilTool = [[super allocWithZone:NULL] init];
    }
    return utilTool;
}

+ (UITapGestureRecognizer *)obtainTapGestureRecognizerObjectWithAction:(nullable SEL)action withTarget:(nullable id)target {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tapGestureRecognizer.delegate = target;
    tapGestureRecognizer.cancelsTouchesInView = YES;
    return tapGestureRecognizer;
}


+ (NSString *)aryFloatValue:(float)vlue {
    NSString  *newStr  = @"";
    NSString  *srt  =[NSString stringWithFormat:@"%f",vlue];
    NSRange range = [srt rangeOfString:@"."];
    newStr =  [NSString stringWithFormat:@"%@",[srt substringToIndex:range.location + 3]];
    
    return newStr;
}


+ (UIButton *)noDataBtn:(NSString *)str {
   
       UIButton *noDataBtn   = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4 , SCREEN_HEIGHT/2 - (SCREEN_WIDTH/2), SCREEN_WIDTH/2, SCREEN_WIDTH/2)];
        noDataBtn.userInteractionEnabled = NO;
        [noDataBtn setTitle:str forState:UIControlStateNormal];
        [noDataBtn setTitleColor:RGB(140, 140, 140, 1) forState:UIControlStateNormal];
        noDataBtn.layer.cornerRadius  = SCREEN_WIDTH/4;
        noDataBtn.layer.masksToBounds   = YES;
        [noDataBtn setBackgroundColor:RGB(125, 125, 125, 0.1)];
    return noDataBtn;
}
/*
// 遮罩View
+ (UIView * _Nonnull )returnMaskKeyBoardvViewForObj:(id )obj orMethod:(SEL)method {
    UIView *mask = [[UIView alloc] initWithFrame:SCREEN_FRAME];
    mask.backgroundColor = [UIColor clearColor];
    mask.alpha = 0;
    mask.tag = 501;
    [mask addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:obj action:method]];
    return mask;
}

+ (YLZHoledView *_Nonnull)returnMaskViewForObj:(id)obj maskLayerRect:(CGRect)aMask andFingerRect:(CGPoint)finger :(NSInteger)tag {
    YLZHoledView *holedView = [[YLZHoledView alloc] initWithFrame:SCREEN_FRAME];
    holedView.holeViewDelegate = obj;
    [holedView initWithMaskLayerWithObj:aMask layerRadius:30 fingerRect:finger holdViewTag:tag];
    return holedView;
}

+ (YLZHoledView * _Nonnull)returnMaskViewForObj:(id _Nonnull)obj maskLayerRect:(CGRect)aMask fingerPoint:(CGPoint)point setTag:(NSInteger)tag andImage:(UIImage *_Nullable)image imageAry:(NSArray <UIImage *> * _Nullable)ary {
   
    YLZHoledView *holedView = [[YLZHoledView alloc] initWithFrame:SCREEN_FRAME];
    holedView.holeViewDelegate = obj;
    [holedView initWithMaskLayerWithObj:aMask layerRadius:30 fingerRect:point holdViewTag:tag initImage:image setAnimationImages:ary];
    return holedView;

}

+ (YLZHoledView * _Nonnull)teturnMaskViewForObj:(id _Nonnull)obj maskLayerRect:(CGRect)aMask fingerPoint:(CGPoint)point setTag:(NSInteger)tag layerRadius:(CGFloat)radius andImage:(UIImage *_Nullable)image imageAry:(NSArray <UIImage *> * _Nullable)ary {
    
    YLZHoledView *holedView = [[YLZHoledView alloc] initWithFrame:SCREEN_FRAME];
    holedView.holeViewDelegate = obj;
    [holedView initWithMaskLayerWithObj:aMask layerRadius:radius fingerRect:point holdViewTag:tag initImage:image setAnimationImages:ary];
    return holedView;
}
*/


+ (NSString*)addingPercentEscapesUsingEncodingWithurlStr:(NSString*)urlStr {
    NSString* newUrlStr = @"";
     if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
         newUrlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
       }
    else {
        newUrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    return newUrlStr;
}


+ (id)handleWithNullVlue:(id)vlue {
    __typeof__ (vlue) _vlue = vlue;
    //if ([_vlue isEqual:[NSString class]]) {
    if([_vlue isEqualToString:@"(null)"] || [_vlue isEqualToString:@""]) {
          _vlue = [NSString stringWithFormat:@"---"];
    }
   
    if ( [_vlue isEqual:[NSNull null]]) {
        if ( [_vlue isEqual: [NSNumber class]]) {
            _vlue = @0;
        }else {
            _vlue = [NSString stringWithFormat:@"---"];
        }
    }
   
    return _vlue;

}

/// 增加加载
- (void)addDoLoading {
    [self removeDoLoading];
    UIWindow *temp = [[UIApplication sharedApplication] keyWindow];
    BGwinodwView = [[UIView alloc] init];
    BGwinodwView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    BGwinodwView.backgroundColor =[UIColor grayColor];
    BGwinodwView.alpha = 0.1;
    
    if (temp == nil) {
        UIWindow *tem= [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        tem.backgroundColor = RGB(0, 0, 0, 1);
        [tem addSubview:BGwinodwView];
        progressHUD = [MBProgressHUD showHUDAddedTo:tem animated:YES];
    }else {
        [temp addSubview:BGwinodwView];
        progressHUD = [MBProgressHUD showHUDAddedTo:temp animated:YES];
    }
    progressHUD.delegate = self;
    progressHUD.removeFromSuperViewOnHide = YES;
    progressHUD.detailsLabelText = NSLocalizedString(@"watiting...", nil);
    progressHUD.dimBackground =YES;
    [progressHUD hide:YES afterDelay:30];//计时3s
    [progressHUD show:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

/// 移除加载
- (void)removeDoLoading {
    [BGwinodwView removeFromSuperview];
    [progressHUD removeFromSuperview];
    progressHUD  = nil;
    BGwinodwView = nil;
     [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



+ (int)judgeLocalLanguage {                                               
    int i = 0;
    NSString *nsLang = (NSString *)[[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    NSLog(@"%@",[[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode]);
    if ([nsLang isEqualToString:@"cn"] || [nsLang isEqualToString:@"zh"]) {
        i = 1;
    }else {
        i = 2;
    }
    return i;
}



// 提示弹出框
+ (void)addViewController:(UIViewController *)cont withTitleStr:(NSString *)str withMessage:(NSString *)mess  {
    
    UIAlertController *alert =[UIAlertController  alertControllerWithTitle:str  message:mess preferredStyle:UIAlertControllerStyleAlert];
    
    if (objc_getClass("UIAlertController") !=nil && cont != nil)
    {
        [cont presentViewController:alert animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:^{
                //do something?
            }];
        });
        
    }else{
        UIAlertView  *alert2=[[UIAlertView alloc]initWithTitle:str message:mess delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil, nil];
        [alert2 show];
    }
    
}

+(UIAlertController *)addViewController:(UIViewController *)vc
                           withTitleStr:(NSString *)str
                            withMessage:(NSString *)mess
                             withAction:(UIAlertAction *)action
                           withOKAction:(UIAlertAction *)okAction
                              withStyle:(UIAlertControllerStyle)style {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message:mess preferredStyle:style];
    
    UIAlertAction *cancelAction;
    UIAlertAction *ok;
    if (action != nil) {
     cancelAction = action;
     
    }else {
      cancelAction =  [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    }
    
    if (okAction != nil) {
      ok =  okAction;
        
    }else {
      ok =  [UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleDefault handler:nil];
    }
    

    [alert addAction:cancelAction];
    [alert addAction:ok];
    //[vc presentViewController:alert animated:YES completion:nil];
    return alert;
}


// 添加手势隐藏键盘 -- 自己实现方法
+ (void)addTapGestureRecognizerForTarget:(nullable id)targert toView:(UIView *)view toAction:(nullable SEL)action {
    //手势隐藏键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:targert action:action];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [view addGestureRecognizer:tapGestureRecognizer];
}
+ (void)removeTapGestureRecognizerForTarget:(nullable id)targert toView:(nullable UIView *)view toAction:(nullable SEL)action {
   // removeGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
}

+ (UIAlertController *)addAlertControllerForAuthorizationStatus:( NSString *)alertControllerMessages
{
    UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:NSLocalizedString(alertControllerMessages, nil)
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil)
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    UIAlertAction *sure   = [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", nil)
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    [alert1 addAction:cancel];
    [alert1 addAction:sure];
    return alert1;
}


+ (nonnull NSString *)stringFromDate:(nonnull NSDate *)date withDateFormat:(NSString *)format
{
    if (!date) {
        return @"---";
    }
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    NSTimeZone *timzone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timzone];
    //@"yyyy-MM-dd HH:mm:ss"
    [dateFormatter setDateFormat:format];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    return currentDateString;
}

//NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)string  withDateFormat:(NSString *)format
{
    NSString *formatStr = format;
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    if (![string isEqualToString:@""]) {
        NSString *subsStr = [string substringWithRange:NSMakeRange(0, 4)];
        if ([subsStr rangeOfString:@"/"].location !=NSNotFound) { //截取的字符串包含@“/”
            formatStr =  @"MM/dd/yyyy HH:mm:ss";
        }else {
            if ([subsStr rangeOfString:@"-"].location != NSNotFound) {  //截取的字符串包含@“-”
                formatStr =  @"MM-dd-yyyy HH:mm:ss";
            }
        }
    }
     [formatter setDateFormat:formatStr];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:string];
    
    if (!date) {
    
        return nil;
    }
    return date;

}



// 返回时差
+ (NSTimeInterval)Extends_dateFromString:(NSString *)string  withDateFormat:(NSString *)format{
    
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT/UTC
    //本地 时区- - - - 为什么不按系统时区呢。。
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]]; //上海时区
    [formatter setDateFormat:format];
    
    //NSString转NSDate
    NSDate *newdate = [formatter dateFromString:string]; //转成Date 时根据"Asia/Shanghai" 已被去了 GMT+8的时区
    
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:newdate];
    //传入的时间 与 本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:newdate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为符合该地区的时间 = 标准时间 + interval 时差(秒)
   // NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:newdate];
    
   // NSString *cusStrDate = [formatter stringFromDate:newdate];
    
    return interval;

}


+ (nonnull NSString *)timeAgeWithChinaTimeTransformCurrentPhoneTimeZooe:(nonnull NSString *)timeString
{
    NSString *dateTime = @"";
    if ([timeString isEqualToString:@""] || timeString == nil || [timeString isEqual:[NSNull null]]) {
        
        dateTime = @"---";
        
    }else {
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
    NSTimeZone *timzone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timzone];
    NSDate *date = [formatter dateFromString:timeString];
    date = [NSDate dateWithTimeIntervalSince1970:[date timeIntervalSince1970]];
       // dateTime = [date dateTimeAgo];
        return dateTime;
    }
    return dateTime;
}

+ (NSDate *)timestampStringTransformTimeCurrentPhoneTimeZooe:(NSString *)timestampString{

    if (!timestampString) {
        return nil;
    }
    NSInteger timestamp =[timestampString integerValue];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:timestamp];
    return date;
}

+ (nonnull NSString *)timestampStringTransformDateString:(nonnull NSString *)timestampString{
    NSString * timeString ;
    if (timestampString) {
        NSDate *date=[UtilToolsClss timestampStringTransformTimeCurrentPhoneTimeZooe:timestampString];
        timeString = [UtilToolsClss stringFromDate:date withDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    }else{
        timeString =@"";
    }
    return timeString;
}

+ (NSString *)timeTransFormStringFormatForLess24h:(NSDate *)time
{
    if (!time) {
        return @"  ---";
    }
    NSString *dateString;
    NSDate *currentTime = [NSDate date]; //获取当前时间，和已经清除了时区
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *temp = [formatter stringFromDate:currentTime]; //格式是 2016-06-06 00:00:00
    temp = [temp stringByAppendingString:@" 00:00:00"]; //获取年月日
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    currentTime = [formatter dateFromString:temp]; // 获取年月日时分秒 -如果再来转，会再-当地的时区
    
    double deltaSeconds = [time timeIntervalSinceDate:currentTime]; // 获取时间间隔
    if (deltaSeconds >=0) {
        
        [formatter setDateFormat:@"HH:mm"];
        dateString = [formatter stringFromDate:time];
    }else{
        
        [formatter setDateFormat:@"MM/d/yy"];
        dateString = [formatter stringFromDate:time];
    }
    return dateString;
}








@end
