//
//  NetRequestClss.m
//  DataStatistics
//
//  Created by Kang on 15/12/9.
//  Copyright © 2015年 YTYangK. All rights reserved.
//
//  请求格式
//


#import "NetRequestClss.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "UtilToolsClss.h"


@interface NetRequestClss ()
@end

@implementation NetRequestClss

static NetRequestClss  *instance = nil;
static dispatch_once_t onceToken;

/** 网络状态
 AFNetworkReachabilityStatusUnknown          = -1,  // 未知
 AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
 AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
 AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
 */
//static int netWorkState;

+ (NetRequestClss *)sharedNetRequestClss {
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[super allocWithZone:NULL] init];
        }
    });
    return instance;
}
// 统一的一个请求管理者对象
- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        return _sessionManager = [AFHTTPSessionManager manager];
    }
    return _sessionManager;
}


- (AFHTTPResponseSerializer *)rSerializer {
    if (_rSerializer == nil) {
       return _rSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _rSerializer;
}



/// 内调-监控网络
+ (BOOL)beforeExecute:(AFHTTPSessionManager *)manager {
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];  //开启请求
                break;
            case AFNetworkReachabilityStatusNotReachable:
             default:
                [operationQueue setSuspended:YES]; //暂停请求
                break;
        }
    }];
    [manager.reachabilityManager startMonitoring];
    return true;
}


/// 监控提示
+ (NSString *)afterExecute:(NSError *)error addViewC:(UIViewController *)vc {
//    if (error == nil) {
//        return @"---";//true;
//    }
    
    if ([error code] == NSURLErrorNotConnectedToInternet) {
        //@"网络不给力"
        return NSLocalizedString(@"NetRClss3701", nil);//false;
    }else if([error code] == NSURLErrorTimedOut) {
        // @"请求超时,请你稍后尝试。"
        return NSLocalizedString(@"NetRClss3705", nil);
    }else if([error code] == NSURLErrorBadServerResponse) {
        // @"服务器异常,该网页不存在"
        return NSLocalizedString(@"NetRClss3704", nil);
    }//else if([error code] == NSURLErrorCannotConnectToHost) {
        return NSLocalizedString(@"NetRClss3703", @"服务器维护，请稍后再试");
   // }
    
    // 服务器故障，请稍后再试
    //return true;
}

#pragma mark - 使用这个请求方法，其他不使用。
+ (void)requestWithUrl:(NSString *)url requestWithParameters:(NSDictionary *)par uploadFile:(NSDictionary *)fileDic method:(NetMethod)met returnSuccess:(void(^)(id objs, int status, NSString *mag))success returnError:(void(^)(NSString *err))err {

    
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
                NSError *errer = nil ;
                [NetRequestClss requestWithReturnError:errer errorBlock:err];

        }else{
            
            NSString *metStr = (met > 0) ? @"POST" : @"GET";
            
            NSString *requestUrl = [NSString stringWithFormat:@"%@%@",IP,url];
            // AF 管理者
            AFHTTPSessionManager *manager = [NetRequestClss sharedNetRequestClss].sessionManager;
            
            if (![NetRequestClss beforeExecute:manager]) {
                return;
            }
            
            manager.responseSerializer = [NetRequestClss sharedNetRequestClss].rSerializer;
            [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            manager.requestSerializer.timeoutInterval = 5.f;//3
            [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
            
            NSComparisonResult getComparison = [metStr caseInsensitiveCompare:@"GET"];
            if (getComparison == NSOrderedSame) {
                //requestUrl.URL.absoluteString
                [manager GET:[NSString stringWithFormat:@"%@",requestUrl] parameters:par progress:^(NSProgress * _Nonnull downloadProgress) {
                    //不做操作
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [NetRequestClss requestWithRetrunSuccess:responseObject successBlock:success];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [NetRequestClss requestWithReturnError:error errorBlock:err];
                    
                }];
                
            }
            
            
            NSComparisonResult postComparison = [metStr caseInsensitiveCompare:@"POST"];
            if (postComparison == NSOrderedSame) {
            
                if (fileDic == nil) {
                    [manager POST:[NSString stringWithFormat:@"%@",requestUrl] parameters:par progress:^(NSProgress * _Nonnull uploadProgress) {
                        //不做操作
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        [NetRequestClss requestWithRetrunSuccess:responseObject successBlock:success];
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [NetRequestClss requestWithReturnError:error errorBlock:err];
                        
                    }];
                }else {
                    // 文件上传
                    [manager POST:[NSString stringWithFormat:@"%@",requestUrl] parameters:par constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                        
                        // NSURL *url=[NSURL fileURLWithPath:@"/Users/hq/Desktop/2.jpg"];
                        // URL 上传
                        //[formData appendPartWithFileURL:url name:@"file" fileName:@"2.jpg" mimeType:@"image/jpeg" error:nil];
                        
                        NSArray *idVlueAry  = [fileDic objectForKey:@"IdAry"];
                        NSArray<UIImage *> * imgVlueAry = [fileDic objectForKey:@"ImageAry"];
                        
                        if ([imgVlueAry[0] isKindOfClass:[UIImage class]]) {
                            if (imgVlueAry.count == 1) {
                               
                                    NSData *imgData  = UIImageJPEGRepresentation(imgVlueAry[0], 0.5);
                                
                                [formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"%@",idVlueAry[0]]  fileName:[NSString stringWithFormat:@"%@.jpg",idVlueAry[0]] mimeType:@"image/jpeg"];
                            }else {
                                for (int i = 0; i < imgVlueAry.count; i++) {
                                        NSData *imgData  = UIImageJPEGRepresentation(imgVlueAry[i], 0.5);
                                        
                                        [formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"%@%ld",idVlueAry[i],(long)i+1]  fileName:[NSString stringWithFormat:@"%@%ld.jpg",idVlueAry[i],(long)i+1] mimeType:@"image/jpeg"];
                                }
                            }
                        }else if([imgVlueAry[0] isKindOfClass:[NSURL class]]) {
                            //
                        }else {
                           // break;
                        }
                        
                       
                        
                    } progress:^(NSProgress * _Nonnull uploadProgress) {
                        NSLog(@"---->%f",uploadProgress.fractionCompleted);
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        [NetRequestClss requestWithRetrunSuccess:responseObject successBlock:success];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [NetRequestClss requestWithReturnError:error errorBlock:err];
                    }];
  
                }
            }

        
        
        
        }
    }];
}


/**
 *  请求成功
 */
+ (void)requestWithRetrunSuccess:(id _Nonnull)responseObject successBlock:(void(^)(id,int,NSString *))block{
    // 请求返回的信息
    __block NSString *requestStr = @"";
    NSError *jsonError = nil;
    NSData *jsonData = nil;

    // 转成Json字符串
    NSString  *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
   // BOOL bol = [NSJSONSerialization isValidJSONObject:jsonStr];
//    if ([jsonStr rangeOfString:@"<"].location != NSNotFound) {
//        NSRange range = [jsonStr rangeOfString:@"<"];
//        jsonStr = [jsonStr substringToIndex:range.location];
//        jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
//    }else {
        jsonData = responseObject;
 //   }

         // kNilOptions -- 不操作
         NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&jsonError];
    
         NSLog(@"获取json字符串：原型---->%@  Dic---%@",jsonStr,jsonDic);

        if (jsonStr != nil) {
            if (jsonError) {
                requestStr = @"转换字典失败，请查看数据";
                block(nil,NetObtainDataStatusFail,requestStr); // -1;
            }else {
                requestStr = @"请求成功!";
                block(jsonDic,NetObtainDataStatusSuccess,requestStr); // 1
            }
        }else {
            requestStr = @"获取不到任何数据";
            block(nil,NetObtainDataStatusSuccessAlsoNotData,requestStr); //2
        }
}
/**
 *  请求失败
 */
+ (void)requestWithReturnError:(NSError *_Nonnull)error errorBlock:(void(^)(NSString *err))block {
    NSString *requestStr = @"";
    [UIApplication sharedApplication].networkActivityIndicatorVisible  = NO;
     NSLog(@"\n获取到错误，API错误，或服务器连接失败-->error is %@",error);
    requestStr = [NetRequestClss afterExecute:error addViewC:nil];
     //@"api异常！请检查您的服务器！";
      block(requestStr);
}



#pragma mark - Url拼接 - 添加请求头部内容 -单件
+ (NSMutableURLRequest *)ANetRequestWithURLString:(NSString *)requestUrlString WithHeader:(NSDictionary *)header WithParameter:(NSDictionary *)parameter WithHTTPMethod:(NSString *)httpMethod {
    NSLog(@"---->%@",IP);
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",IP,requestUrlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:25]; //请求时间10s
    
    //添加请求头
    if (header != nil) {
        for (NSString *key in header.allKeys) {
            [request addValue:header[key] forHTTPHeaderField:key];
            // [request setValue:header[key] forHTTPHeaderField:key];
        }
    }
    
    // get 请求
    NSComparisonResult GETComparison = [httpMethod caseInsensitiveCompare:@"GET"];
    if (GETComparison == NSOrderedSame) {
        [request setHTTPMethod:@"GET"];
        
        if (parameter != nil) {
            //添加参数，将参数拼接在url后面
            NSMutableString *paramsStr = [NSMutableString string];
            NSArray *allKeyAry = [parameter allKeys];
            for(NSString *key in allKeyAry) {
                NSString *vale = [parameter objectForKey:key];
                [paramsStr appendFormat:@"&%@=%@",key,vale];
            }
            
            
            if (paramsStr.length > 0) {
                [paramsStr replaceCharactersInRange:NSMakeRange(0, 1) withString:@"?"];
                //重新设置url
                NSLog(@"\n请求路径:GET-->requestUrl is %@",request);
                NSString *newStrUrl = [strUrl stringByAppendingString:paramsStr];
                [request setURL:[NSURL URLWithString:newStrUrl]];
                
                NSLog(@"\n请求路径:GET-->requestUrl is %@",request);
                
            }
        }
    }
    
    // post 请求
    NSComparisonResult POSTComparison = [httpMethod caseInsensitiveCompare:@"POST"];
    if (POSTComparison == NSOrderedSame) {
        [request setHTTPMethod:@"POST"];
        
        // 暂时不处理
//        for (NSString *key in parameter) {
//            [request setHTTPBody:parameter[key]];
//        }
        NSLog(@"\n请求路径:POST-->requestUrl is %@",request);
        
    }
    return request;
}


- (void)dealloc {
    NSLog(@"----->%@",self);
}

@end
