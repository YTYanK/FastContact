//
//  FastContact-Header.h
//  FastContact
//
//  Created by YTYanK on 17/1/10.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#ifndef FastContact_Header_h
#define FastContact_Header_h

#import <Foundation/Foundation.h>

/// 定义返回请求成功数据的block类型
typedef void(^ReturnValueBlock)(id returnValue);
/// 定义返回错误数据的block类型
typedef void(^ErrorCodeBlock)(id errorCode);
/// 定义 失败数据的block类型
typedef void(^FailureBlock)();
/// 定义 需要返回的失败数据的block类型
typedef void(^FailureCodeBlock)(id failureCode);
/// 定义 返回状态成功数据的block类型
typedef void(^NetWorkBlock)(BOOL netConnetState);
/// 定义 一个可以相互传值block 类型
typedef id (^ReceiveVlueBlock)(id receiveValue);
/// 定义 返回多个参数 api block类型
typedef void(^ApiBlock)(id returnValue ,UIViewController *vc,NSString *msg,id api);

/// 设备ID
static NSString * const kFC_DeviceID = @"DeviceId";
/// 设备类型
static NSString * const kFC_DeviceType = @"DeviceType";
/// API版本号
static NSString * const kFC_Version = @"Version";
/// URL
static NSString * const kFC_URL     = @"fc_url";
/// trans
static NSString * const kFC_Trans   = @"fc_trans";
/// 请求方式
static NSString * const kFC_NetMethod = @"fc_netMethod";
/// 上传文件
static NSString * const kFC_File = @"fc_file";

/// 会话ID
static NSString * const kFC_SessionID  = @"SessionId";
static NSString * const kFC_UserId     = @"UserId";
static NSString * const kFC_LoginName  = @"loginName";
/// API版本号值
static NSString * const kFC_VersionVlue = @"1";

//账号密码
static  NSString * const kFC_LoginAccount = @"loin_account";
static  NSString * const kFC_LoginPass  = @"loin_pass";

typedef enum : NSUInteger {
    TransformationModel = 1,  //字典 -> 模型
    TransformationArrayModel = 2, //字典数组 -> 模型数组
    TransformationKeyValuesArray = 3, //模型数组 -> 字典数组
    TransformationNot = 4, // 不转直接返回字典
} Transformation;




// --------------------

#import "AFNetworking.h"  // AFN
#import "NetRequestClss.h"
#import "ViewModelClass.h"
#import "InterfaceViewModel.h"
#import "MBProgressHUD.h"


#import "UIView+Additional.h"
#import "UIImage+Extension.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"
#import "NSString+Extension.h"
#import "MJExtension.h"
#import "MJRefresh.h"


#import <MapKit/MapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#endif /* FastContact_Header_h */
