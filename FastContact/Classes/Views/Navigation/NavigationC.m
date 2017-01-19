//
//  NavigationC.m
//  DataStatistics
//
//  Created by Kang on 15/10/9.
//  Copyright © 2015年 YTYangK. All rights reserved.
//

#import "NavigationC.h"

@interface NavigationC ()

@end

@implementation NavigationC

- (void)viewDidLoad {
    [super viewDidLoad];
 // Do any additional setup after loading the view.



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 一个类只会调用一次
+ (void)initialize {

    [self setupNavigationBarTheme];
//    [self setupBarButtonItemTheme];
    
}

/// 设置Bar样式
+ (void)setupNavigationBarTheme {
    
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:[NavigationC class], nil];//针对NavigationC  修改
    
    // 设置文字属性
#ifdef __IPHONE_7_0
    // 字体颜色 , 字体大小
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:16]}];
#else
    // 字体颜色 ,阴影
    [navBar  setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor whiteColor], NSShadowAttributeName : [[NSShadow alloc] init]}];
#endif
    // 设置navigationbar的半透明效果
    [navBar setTranslucent:NO];
    
    // 设置导航栏背景
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        //navBarBg = @"NavBar64";
    //    navBarBg = @"navBar-bg";
        navBar.tintColor = [UIColor whiteColor];
    }
    navBar.barTintColor = [UIColor orangeColor];
    
}

/// 设置Itemi样式
//+ (void)setupBarButtonItemTheme {
//    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
//    UIBarButtonItem *barBtn = [UIBarButtonItem appearance]; //所有
//    
////    /** 文字属性 */
////    [barBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(255, 0, 0, 1),NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateNormal];
////    
//    // 设置高亮状态的文字属性
//    //    [barBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(255,255,0,1), NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName,nil] forState:UIControlStateHighlighted];
//    
//    // 设置不可用状态(disable)的文字属性
//    [barBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateDisabled];
//    
//    /** 按钮背景 */
////    [barBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//}

/// 控制器创建View 完成调用


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置导航栏
    //    UINavigationItem *vcBtnItem = [viewController navigationItem];
        
   // vcBtnItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithImageName:@"navigationbar_back_withtext" highImageName:@"navigationbar_back_withtext_highlighted" title:[[self.childViewControllers lastObject] title] target:self action:@selector(back)];
    
   //  vcBtnItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithImageName:@"返回" highImageName:@"返回" title:@"" target:self action:@selector(back)];//navigationbar_back_withtext_highlighted  -navigationbar_back_withtext
        
    }
    [super pushViewController:viewController animated:YES];
}


- (void)back {
    // 返回
    [self popViewControllerAnimated:YES];
}

- (void)more {
     //[self popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
