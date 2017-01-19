//
//  PersonalVC.h
//  FastContact
//
//  Created by YTYanK on 17/1/18.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalVC : UIViewController
/*
  必须传标记
  personalSign = details（通讯详情）
  // 否则默认 个人中心
 */
@property (copy, nonatomic) NSString *personalSign;
@end
