//
//  HomeHeader.h
//  FastContact
//
//  Created by YTYanK on 17/1/18.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#ifndef HomeHeader_h
#define HomeHeader_h

// 标签 常量
/**
 *  运行维护标签
 */
static NSString * const kFC_OM_Sign = @"OperationMaintenance";
/**
 *  任务管理标签
 */
static NSString * const kFC_TM_Sign = @"TaskManagement";
/**
 *  请假审批标签
 */
static NSString * const kFC_LEA_Sign = @"LeaveExaminationAndApproval";
/**
 * 运行维护下级标签
 */
static NSString * const kFC_SOM_Sign = @"SubordinateOperationMaintenance";


// 跳转 标记

#import "HeadView.h"
#import "ContentView.h"
#import "MailListVC.h"
#import "NoticeVC.h"
#import "PersonalVC.h"

// 数据模型
#import "AddressBookModel.h"
#import "BaseListModel.h"

#endif /* HomeHeader_h */
