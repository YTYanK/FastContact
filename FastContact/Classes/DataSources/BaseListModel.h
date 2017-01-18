//
//  BaseListModel.h
//  FastContact
//
//  Created by YTYanK on 17/1/17.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseListModel : NSObject

@property (copy, nonatomic) NSString *optionsetdetailid;
@property (copy, nonatomic) NSString *optionsetid;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSNumber *value;
@property (assign, nonatomic) BOOL isselected;
@property (assign, nonatomic) NSNumber *displayorder;
@property (copy, nonatomic) NSString *versionnumber;

@end
