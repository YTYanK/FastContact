//
//  InterfaceViewModel.h
//  FastContact
//
//  Created by YTYanK on 17/1/10.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "ViewModelClass.h"



@interface InterfaceViewModel : ViewModelClass
@property (assign, nonatomic, setter=isLoading:) BOOL loading;
@property (strong, nonatomic) NSMutableArray *models;

/**
 *  共享对象
 */
+ (InterfaceViewModel *)sharedInterfaceViewModel;
/**
 *  接口请求方法
 */
+ (void)requestWithObj:(id)obj Interface:(NSDictionary *)interface andParam:(NSDictionary *)param success:(void(^)(id model))success failure:(void(^)(NSString *mag))failure;

@end
