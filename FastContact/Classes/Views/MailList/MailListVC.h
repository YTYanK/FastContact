//
//  MailListVC.h
//  FastContact
//
//  Created by YTYanK on 17/1/16.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MailListVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *mailTableView;
//@property (weak, nonatomic) IBOutlet UISearchBar *mailSearchBar;
@property (retain, nonatomic) IBOutlet UIView *headView;
@property (assign, nonatomic) BOOL isSearching;
/// 传过来的数据
@property (strong, nonatomic) id modelData;
@end
