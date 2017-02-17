//
//  NSString+Extension.m
//  新浪微博
//
//  Created by xc on 15/3/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
#pragma mark 计算字符串大小
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

// 获取当前时间
+ (NSString *)getCurrentTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    return [formatter stringFromDate:date];
}

// 字符日期计算两个时间的差
+ (NSString *)intervalFromLastDate: (NSString *)beginDateStr  toTheDate:(NSString *)endDateStr
{
    NSString *timeString = @"";
    
    NSDateFormatter *date =[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *beginDate = [date dateFromString:beginDateStr];
    NSDate *endDate = [date dateFromString:endDateStr];
    
    
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *d = [cal components:unitFlags fromDate:beginDate toDate:endDate options:0];
        
    timeString = [NSString stringWithFormat:@"%ld天%ld时%ld分",(long)[d day],[d hour],[d minute]];

    return timeString;
}

@end
