//
//  InterfaceViewModel.m
//  FastContact
//
//  Created by YTYanK on 17/1/10.
//  Copyright © 2017年 YTYanK. All rights reserved.
//




#import "InterfaceViewModel.h"
#import "LoginModel.h"
#import "AddressBookModel.h"
#import "BaseListModel.h"


static InterfaceViewModel *interfaceVM = nil;
static dispatch_once_t interfaceToken;

@implementation InterfaceViewModel

+ (InterfaceViewModel *)sharedInterfaceViewModel {
    dispatch_once(&interfaceToken, ^{
        if (interfaceVM == nil) {
            interfaceVM = [[super allocWithZone:NULL] init];
        }
    });
    return interfaceVM;
}

+ (void)requestWithObj:(id)obj Interface:(NSDictionary *)interface andParam:(NSDictionary *)param success:(void(^)(id model))success failure:(void(^)(NSString *mag))failure {
    
    // 判断是否有文件需要上传
    NSDictionary *filDic  = [NSDictionary dictionary];
    if ([[interface objectForKey:kFC_File] isKindOfClass:[NSDictionary class]]) {
        filDic = [interface objectForKey:kFC_File];
    }else {
        filDic = nil;
    }

    BOOL  isLoad = [InterfaceViewModel sharedInterfaceViewModel].loading;
    __weak NSString *urlStrPart = [interface objectForKey:kFC_URL];
    NSString *classStr = [urlStrPart substringFromIndex:[urlStrPart rangeOfString:@"/"].location+1];
    __weak NSMutableDictionary *newParam = [NSMutableDictionary dictionary];
    int trans = [[interface objectForKey:kFC_Trans] intValue];
    
    
    // 自动转模型
    if (![classStr isEqualToString:@"Login"]) {
        //TODO: 什么时候把这一句转成静态的
      __weak NSString *device    = [NSUD objectForKey:kFC_DeviceID];
      __weak NSString *sessionID = [NSUD objectForKey:kFC_SessionID];
      __weak NSString *userID    = [NSUD objectForKey:kFC_UserId];
        
        NSMutableDictionary *loginParam = [NSMutableDictionary dictionaryWithObjectsAndKeys:userID,kFC_UserId,sessionID,kFC_SessionID,kFC_VersionVlue,kFC_Version,[NSNumber numberWithInt:2],kFC_DeviceType,device,kFC_DeviceID, nil];
        [loginParam addEntriesFromDictionary:param];
        
        newParam = loginParam;
    }else {
        [newParam addEntriesFromDictionary:param];
    }
    
    
    [InterfaceViewModel addLoading:isLoad];
    [NetRequestClss requestWithUrl:urlStrPart requestWithParameters:newParam uploadFile:filDic method:[[interface objectForKey:kFC_NetMethod] intValue] returnSuccess:^(id objs, int status, NSString *mag) {
        if(status != 1){
            [[NetRequestClss sharedNetRequestClss].sessionManager.operationQueue cancelAllOperations];
            NSString *tilasStr =  [ViewModelClass forceJumpViewStatus:status forController:obj]; //强退
            failure(tilasStr);
            return;
        }else {
            if ([[objs objectForKey:kFC_Code] intValue] == 200) {
                id newObjs = nil;
                if (![[[objs objectForKey:kFC_Data] class] isSubclassOfClass:[NSString class]]) {
                   newObjs = [InterfaceViewModel transformationModelConduct:[objs objectForKey:kFC_Data] witheClassStr:classStr witheTurn:trans];
                }else {
                    if (![[objs objectForKey:kFC_Msg] isEqualToString:@""]) {
                        newObjs = [objs objectForKey:kFC_Msg];
                    }
                }
                
                success(newObjs);
            }else {
                failure([objs objectForKey:kFC_Msg]);
            }
        }
        [InterfaceViewModel removeLoading:isLoad];
    } returnError:^(NSString *err) {
        [InterfaceViewModel removeLoading:isLoad];
        failure(err);
    }];
}


+ (void)addLoading:(BOOL)loading {
    if (loading) {
        [[UtilToolsClss getUtilTools] addDoLoading];
    }else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    }
}

+ (void)removeLoading:(BOOL)loading {
    if (loading) {
        [[UtilToolsClss getUtilTools] removeDoLoading];
    }else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
    }
}


//TODO:  转模型 -未完善。。有待修改
+ (id)transformationModelConduct:(NSDictionary *)objDic witheClassStr:(NSString *)classStr witheTurn:(Transformation)turn {
    
    //NSMutableArray *ary = [InterfaceViewModel sharedInterfaceViewModel].models;
    //int i = 0; // 判断生成重复个数
    Class fc_class;
    id obj;
  //  if ([objDic count] > 0) {
        NSString *modelStr = @"Model"; //固定部分
        if (turn != TransformationNot) {
          
          NSString *cl_Str  = [NSString stringWithFormat:@"%@%@",classStr,modelStr];
           fc_class = NSClassFromString(cl_Str);
   
        }
        
        
        switch (turn) {
            case TransformationModel: // 字典转模型
                obj = [fc_class mj_objectWithKeyValues:objDic];
                break;
            case TransformationArrayModel: //字典数组 转 数组模型
                obj = [fc_class mj_objectArrayWithKeyValuesArray:objDic];
                break;
            case TransformationKeyValuesArray:
                obj = nil;
                break;
            default:
                obj = objDic;
                break;
        }
//    }else {
//        obj = @"没有更多数据";
//    }

  /*
    NSString *newChar = [NSString stringWithFormat:@"%@%@",str,str2];
    const char * a = [newChar UTF8String];
    id ss = objc_getClass(a); //生成的是对象
   */
    
    // 记录注册的模型
//    if (turn != TransformationNot) {
//            [InterfaceViewModel sharedInterfaceViewModel].models = ary;
//    }
    return obj;
    
}

- (NSMutableArray *)models {
    if (_models == nil) {
        _models = [NSMutableArray array];
    }
    return _models;
}

@end
