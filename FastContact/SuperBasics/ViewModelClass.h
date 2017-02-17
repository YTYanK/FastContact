//
//  ViewModelClass.h
//  DataStatistics
//
//  Created by Kang on 15/12/9.
//  Copyright © 2015年 YTYangK. All rights reserved.
//


// 定义常量

extern NSString * const kFC_Code;
extern NSString * const kFC_Data;
extern NSString * const kFC_Msg;


#import <Foundation/Foundation.h>
@interface ViewModelClass : NSObject

@property (strong, nonatomic) ReturnValueBlock returnblock;
@property (strong, nonatomic) ErrorCodeBlock errorblock;
@property (strong, nonatomic) FailureBlock failureblock;
//新加
@property (strong, nonatomic) ReceiveVlueBlock receivevlueblock;
@property (strong, nonatomic) ApiBlock apiblock;

@property (copy, nonatomic) NSString  *returnVlueStr;
@property (copy, nonatomic) NSString  *errorVlueStr;
@property (copy, nonatomic) NSString  *failureVlueStr;

/// 请求时返回的 的结果 ，yes - 有值 ，no - 没有
@property (assign, nonatomic ,getter=isReturnBlockVlue) __block BOOL returnBlockVlue;


+ (ViewModelClass *)sharedViewModelClss;


/*** 父类VMC-成功获取到数据 子类需要重写*/
- (void)obtainDataWithValueSuccess:(NSDictionary *)returnValue withViewController:(UIViewController *)vc judgeApiStrOrApiId:(id)api ;


/** 父 － 回调*/
- (void)setBlockWithApiBlock:(ApiBlock)apiBlock WithReceiveVlueBlock:(ReceiveVlueBlock)receive;


// 登陆强制退出 二
+ (NSString *)forceJumpViewStatus:(int)status forController:(UIViewController *)vcont;

// 公共请求方法
+ (void)initRequestWithUrlObj:(id)obj parametersDic:(NSDictionary *)dic Interface:(NSDictionary *)inter uploadFile:(NSDictionary *)file success:(void(^)(id obj,id model))success failure:(void(^)(id obj, NSString *err))failure;

@end
