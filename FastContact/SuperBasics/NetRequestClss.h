//
//  NetRequestClss.h
//  DataStatistics
//
//  Created by Kang on 15/12/9.
//  Copyright © 2015年 YTYangK. All rights reserved.
//

#import <Foundation/Foundation.h>


/** 获取到数据的情况 */
typedef NS_ENUM(NSInteger, NetObtainDataStatus) {
    NetObtainDataStatusUnknownAlsoFail      = -2,  //  -失败
    NetObtainDataStatusFail                 = -1,  // 失败
    NetObtainDataStatusError                = 0,   // error
    NetObtainDataStatusSuccess              = 1,   // 成功
    NetObtainDataStatusSuccessAlsoNotData   = 2,   // 成功 -无数据
};

typedef NS_ENUM(NSInteger, NetMethod){
      NetMethodGET  =  -1,
      NetMethodPOST =  1,
};


/** 请求类 - 负责 Get请求\ POST 请求\ 监测网络连接情况  */
@interface NetRequestClss : NSObject

@property  (assign, nonatomic) NetObtainDataStatus obtainStatus;
@property  (assign, nonatomic) NetMethod obtainMethod;
@property  (strong, nonatomic) ErrorCodeBlock  NetRequestErrorBlock;
@property  (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property  (strong, nonatomic) AFHTTPResponseSerializer *rSerializer;


// 自构建共享对象
+ (NetRequestClss *)sharedNetRequestClss;




//+ (void)netReachabilityForReturnBlock:(ReturnValueBlock)block;
#pragma mark - <(￣︶￣)↗[GO!]


+ (void)requestWithUrl:(NSString *)url requestWithParameters:(NSDictionary *)par method:(NetMethod)met returnSuccess:(void(^)(id objs, int status, NSString *mag))success returnError:(void(^)(NSString *err))err;



@end
