//
//  AddressBookModel.h
//  FastContact
//
//  Created by YTYanK on 17/1/14.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookModel : NSObject
@property (assign, nonatomic) NSNumber *peta_rn;
/**
 * 姓名
 */
@property (copy, nonatomic) NSString *name;
/**
 * 移动电话
 */
@property (assign, nonatomic) NSNumber *mobilenumber;
/**
 *  系统ID
 */
@property (copy, nonatomic) NSString *systemuserid;
@end


