//
//  NSString+EmojiExtension.h
//  DataStatistics
//
//  Created by oilklenze on 16/3/7.
//  Copyright © 2016年 YTYangK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EmojiExtension)

/**
 *  清除emoji字符
 *
 *  @return \d
 */
- (NSString *)removeEmoji;

/**
 *  将十六进制的编码转为emoji字符
 *
 *  @param intCode 传入需要转换的数字
 *
 *  @return emoji字符
 */
+ (NSString *)emojiWithIntCode:(int)intCode;
/**
 *  将十六进制的编码转为emoji字符
 *
 *  @param stringCode 传入需要转换的字符串
 *
 *  @return emoji字符
 */
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;
/**
 *  是否为emoji字符
 *
 *  @return BOOL
 */
- (BOOL)isEmoji;

@end
