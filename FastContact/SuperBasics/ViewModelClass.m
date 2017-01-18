
//
//  ViewModelClass.m
//  DataStatistics
//
//  Created by Kang on 15/12/9.
//  Copyright © 2015年 YTYangK. All rights reserved.
//

#import "ViewModelClass.h"
#import "UtilToolsClss.h"


NSString * const kFC_Code = @"Code";
NSString * const kFC_Data = @"Data";
NSString * const kFC_Msg  = @"Msg";


@implementation ViewModelClass

static ViewModelClass *viewModelC = nil;
static dispatch_once_t viewModelToken;

+ (ViewModelClass *)sharedViewModelClss {
    dispatch_once(&viewModelToken, ^{
        if (viewModelC == nil) {
            viewModelC = [[super allocWithZone:NULL] init];
        }
    });
    return viewModelC;
}


#pragma mark 成功返回
 - (void)obtainDataWithValueSuccess:(NSDictionary *)returnValue withViewController:(UIViewController *)vc judgeApiStrOrApiId:(id)api {}

#pragma mark - block
- (void)setBlockWithApiBlock:(ApiBlock)apiBlock WithReceiveVlueBlock:(ReceiveVlueBlock)receive {
    _receivevlueblock = receive;
    _apiblock  = apiBlock;
}


// 强制退出
 + (NSString *)forceJumpViewStatus:(int)status forController:(UIViewController *)vcont {
        if (status == -2 || status == -1) {
            //[MoreViewController logout:vcont];
            //[MBProgressHUD yty_showErrorWithTitle:nil detailsText:NSLocalizedString(@"aborted", nil) toView:nil];
        }
        return NSLocalizedString(@"aborted", nil);
}
 
 
// 公共请求方法
+ (void)initRequestWithUrlObj:(id)obj parametersDic:(NSDictionary *)dic Interface:(NSDictionary *)inter success:(void(^)(id obj,id model))success failure:(void(^)(id obj, NSString *err))failure {
    
                BOOL  isLoad = [[inter objectForKey:@"islist"] isEqualToString:@"true"] ? true : false;
                [ViewModelClass addDoLoading:isLoad];
    
                [NetRequestClss requestWithUrl:[inter objectForKey:@"mdc_Url"] requestWithParameters:dic method:(NetMethod)[inter objectForKey:@"isMethod"] returnSuccess:^(id objs, int status, NSString *mag) {
                    
                     [ViewModelClass removeDoLoading:isLoad];
                    
                    if ([[objs objectForKey:@"body"] objectForKey:@"warning"] != nil) {
                        failure(obj,[NSString stringWithFormat:@"%@",[[objs objectForKey:@"body"] objectForKey:@"warning"]]);
                    }else {
                        if(status != 1){
                            [[NetRequestClss sharedNetRequestClss].sessionManager.operationQueue cancelAllOperations];
                            NSString *tilasStr =  [ViewModelClass forceJumpViewStatus:status forController:obj]; //强退
                            failure(obj,tilasStr);
                            return;
                        }
                        success(obj,objs);
                    }
                } returnError:^(NSString *err) {
                        [[NetRequestClss sharedNetRequestClss].sessionManager.operationQueue cancelAllOperations];
                        [ViewModelClass removeDoLoading:isLoad];
                        if ([err rangeOfString:@"网页不存在"].location != NSNotFound) {
                            err  =  [ViewModelClass forceJumpViewStatus:-1 forController:obj]; //强退
                        }
                           failure(obj,err);
                }];
}

+ (void)addDoLoading:(BOOL)lodad {
    if (lodad) {
        [[UtilToolsClss getUtilTools] addDoLoading];
    }else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}

+ (void)removeDoLoading:(BOOL)lodad {
    if (lodad) {
        [[UtilToolsClss getUtilTools] removeDoLoading];
    }else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}


@end
