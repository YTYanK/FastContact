//
//  LoginModel.h
//  FastContact
//
//  Created by YTYanK on 17/1/10.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LoginModel : NSObject <NSCoding>
singleton_for_interface(LoginModel)
/**
 *  用户ID
 */
@property (copy, nonatomic) NSString *UserId;
/**
 *  会话ID
 */
@property (copy, nonatomic) NSString *SessionId;
/**
 *  API 版本号
 */
//@property (copy, nonatomic) NSString *Version;
/**
 *  设备类型
 */
//@property (copy, nonatomic) NSString *DeviceType;
/**
 *  App 类型
 */
//@property (copy, nonatomic) NSString *AppType;
/**
 * 在线状态
 */
@property (assign, nonatomic) int  IsOnline;
/**
 * 移动电话
 */
@property (assign, nonatomic) NSNumber *MobileNumber;
/**
 * 业务单元ID
 */
@property (copy, nonatomic) NSString *BusinessUnitId;
/**
 * 名字
 */
@property (copy, nonatomic) NSString *Name;
/**
 * 真名
 */
@property (copy, nonatomic) NSString *RealName;
/**
 * 登录名字
 */
@property (weak, nonatomic) NSString *loginName;

//+ (NSDictionary *)returnLoginModelRequestGroup;
@end
