//
//  LoginModel.m
//  FastContact
//
//  Created by YTYanK on 17/1/10.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
singleton_for_implementation(LoginModel)



- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.UserId forKey:@"UserId"];
    [aCoder encodeObject:self.SessionId forKey:@"SessionId"];
    [aCoder encodeObject:self.loginName forKey:@"loginName"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.UserId = [aDecoder decodeObjectForKey:@"UserId"];
        self.SessionId = [aDecoder decodeObjectForKey:@"SessionId"];
        self.loginName = [aDecoder decodeObjectForKey:@"loginName"];
    }
    return self;
}


// 暂时放弃采用自动封装获取请求包的方法
+ (NSDictionary *)returnLoginModelRequestGroup {
  /*  LoginModel *model = [LoginModel sharedLoginModel];
    
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int count, i;
    objc_property_t *properties = class_copyPropertyList([model class], &count);
    for (i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        // 获取到单个属性名
        const char *fc_char = property_getName(property);
        //转String
        NSString *propertyName = [NSString stringWithUTF8String:fc_char];
        NSLog(@"打印---->%@",propertyName);
    }
    
    */
    return nil;
    //FC_DIC(model.UserId)
}

@end
