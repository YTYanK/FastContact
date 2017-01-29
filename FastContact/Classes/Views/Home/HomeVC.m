//
//  HomeVC.m
//  FastContact
//
//  Created by YTYanK on 17/1/10.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "HomeVC.h"
#import "HomeHeader.h"
#import "WorkOrderVC.h"

@interface HomeVC ()<ContentViewDelegate,HeadViewDelegate>
{
    id dataTransfer;
    NSString *homeInletSign;
}
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateHomeView];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (void)updateHomeView {

    [self removeBackButtonItemText];
    [self updateHeadView];
    [self updateContentView];
   
}
// 去除导航条返回的文字
- (void)removeBackButtonItemText {
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc]init];
    UIImage *backButtonImage = [[UIImage imageNamed:@"back_left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = barButtonItem;
    
    
}

- (void)updateHeadView {
    self.headView.delegate = self;
    self.headView.frame = CGRectMake(0, 20, SCREEN_WIDTH, 150);
    [self.view addSubview:self.headView];
}

- (void)updateContentView {
    self.contentView.delegate = self;
    self.contentView.frame = CGRectMake(0, CGRectGetMaxY(self.headView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.headView.frame));
    [self.view addSubview:self.contentView];
}

#pragma mark - HeadViewDelegate
- (void)headViewPortraitForImageView:(UIImageView *)view {
    PersonalVC *personal = [[PersonalVC alloc] initWithNibName:@"PersonalVC" bundle:nil];
    [self.navigationController pushViewController:personal animated:YES];
}

///TODO:需要优化第一个入口
#pragma mark - ContentViewDelegate
- (void)buttonListClickWithView:(UIView *)view forButton:(UIButton *)sender {
    if (sender.tag == 1) {
          homeInletSign = kFC_OM_Sign;
      // 判断用于缓解重复请求的压力
         // if ([NSUD objectForKey:homeInletSign] != nil) {
            
             [self performSegueWithIdentifier:@"goToPublic" sender:self];
    /*   // }else {
            NSDictionary  *inter = FC_DIC(@"Common/BaseList",kFC_URL,[NSNumber numberWithInt:-1],kFC_NetMethod,[NSNumber numberWithInt:2],kFC_Trans,nil);
            NSDictionary  *param = FC_DIC([NSNumber numberWithInt:1],@"Page",[NSNumber numberWithInt:100],@"PageSize",@"WorkCategory1",@"Entity",@"WorkIndex",@"FieldName",nil);
            [InterfaceViewModel sharedInterfaceViewModel].loading = true;
            [InterfaceViewModel requestWithObj:self Interface:inter andParam:param success:^(id model) {
                dataTransfer = model;
                [self performSegueWithIdentifier:@"goToPublic" sender:self];
                
              //  [NSUD setObject:@"goTo" forKey:homeInletSign];
            } failure:^(NSString *mag) {
                [MBProgressHUD yty_showErrorWithTitle:nil detailsText:mag toView:self.view];
            }];
   
       // }*/
    
    }
    
    if (sender.tag == 2) {
        homeInletSign = kFC_TM_Sign;
        [self performSegueWithIdentifier:@"goToPublic" sender:self];
    }
    
    if (sender.tag == 5) {
        homeInletSign = kFC_LEA_Sign;
        [self performSegueWithIdentifier:@"goToPublic" sender:self];
    }
    
    
    if (sender.tag == 7) {
        
        NSDictionary  *inter = FC_DIC(@"Account/AddressBook",kFC_URL,[NSNumber numberWithInt:-1],kFC_NetMethod,[NSNumber numberWithInt:2],kFC_Trans,nil);
        NSDictionary  *param = FC_DIC([NSNumber numberWithInt:1],@"Page",[NSNumber numberWithInt:20],@"PageSize",[NSNumber numberWithInt:1],@"IsBusinessUnit",nil);
        [InterfaceViewModel sharedInterfaceViewModel].loading = true;
        [InterfaceViewModel requestWithObj:self Interface:inter andParam:param success:^(id model) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MailList" bundle:nil];
            MailListVC * mailList = [storyboard instantiateViewControllerWithIdentifier:@"mailListVC"];
            mailList.modelData = model;
            [self.navigationController pushViewController:mailList animated:YES];
            
        } failure:^(NSString *mag) {
            [MBProgressHUD yty_showErrorWithTitle:nil detailsText:mag toView:self.view];
        }];
        
        
        
    }
    
    if (sender.tag == 6) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Notice" bundle:nil];
        NoticeVC *notice = [storyboard instantiateViewControllerWithIdentifier:@"noticeVC"];
        [self.navigationController pushViewController:notice animated:YES];
        
    }
    
  
    
}
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier compare:@"goToEngineering"] == NO) {
        // id vc = segue.destinationViewController;
        //[vc setValue:[NSString stringWithFormat:@"XXXXX"] forKey:];
    }
    
    if ([segue.identifier compare:@"goToPublic"] == NO) {
        id vc = segue.destinationViewController;
        [vc setValue:dataTransfer forKey:@"baseList"];
        [vc setValue:homeInletSign forKey:@"inletSign"];
    }
}




@end
