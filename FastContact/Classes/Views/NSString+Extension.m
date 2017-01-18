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

// 字符日期计算两个时间的差
+ (NSString *)intervalFromLastDate: (NSString *)beginDateStr  toTheDate:(NSString *)endDateStr
{
    NSArray *beginTimeAry=[beginDateStr componentsSeparatedByString:@"."];
    NSString *beginStr=[beginTimeAry objectAtIndex:0];
    
    
    NSArray *endTimeAry=[endDateStr componentsSeparatedByString:@"."];
    NSString *endStr =[endTimeAry objectAtIndex:0];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    
    
    NSDate *beginD=[date dateFromString:beginStr];
    NSTimeInterval beginLate=[beginD timeIntervalSince1970]*1;
    
    
    
    NSDate *endD=[date dateFromString:endStr];
    NSTimeInterval endLate=[endD timeIntervalSince1970]*1;
    
    
    
    NSTimeInterval cha = endLate-beginLate;
    NSString *timeString=@"";
    NSString *house=@"";
    NSString *min=@"";
    NSString *sen=@"";
    
    //    秒
    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
    if (sen.intValue < 10) {
        sen = [NSString stringWithFormat:@"0%@", sen];
    }else {
        sen = [NSString stringWithFormat:@"%@", sen];
    }
    
    //    分
    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
    if (min.intValue < 10) {
        min =[NSString stringWithFormat:@"0%@", min];
    }else {
        min =[NSString stringWithFormat:@"%@", min];
    }
    //    小时
    house = [NSString stringWithFormat:@"%d", (int)cha/3600];
    if (house.intValue < 10) {
         house=[NSString stringWithFormat:@"0%@", house];
    }else {
     house=[NSString stringWithFormat:@"%@", house];
    }
    
    
    timeString=[NSString stringWithFormat:@"%@:%@:%@",house,min,sen];
    return timeString;
}

@end
