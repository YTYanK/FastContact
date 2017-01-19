//
//  AboutXunLianVC.m
//  FastContact
//
//  Created by YTYanK on 17/1/19.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "AboutXunLianVC.h"
#import "UIView+Additional.h"
@interface AboutXunLianVC ()
@property (weak, nonatomic) IBOutlet UIView *RQ_View;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rq_ViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rq_imageW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rq_imageH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *content_ViewH;

@end

@implementation AboutXunLianVC




- (void)viewDidLoad {
    [super viewDidLoad];
    self.RQ_View.layer.borderColor = [UIColor orangeColor].CGColor;
    [UIView addViewBorder:self.RQ_View borderType:ViewBorderTopAndBottom perhapsLayoutConstraints:self.RQ_View.constraints];
    [UIView addViewBorder:self.contentView borderType:ViewBorderTopAndBottom perhapsLayoutConstraints:self.contentView.constraints];
    // Do any additional setup after loading the view from its nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
