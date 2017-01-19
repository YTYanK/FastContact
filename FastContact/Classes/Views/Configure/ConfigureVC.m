//
//  ConfigureVC.m
//  FastContact
//
//  Created by YTYanK on 17/1/19.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "ConfigureVC.h"
#import "PersonalCell.h"
#import "AboutXunLianVC.h"
#import "ModifyPasswordVC.h"

@interface ConfigureVC () <PersonalCellDelegate>

@end

@implementation ConfigureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initConfigureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initConfigureView {
    
    self.view.backgroundColor = RGB(244, 245, 246, 1);
    
    for (int i = 0; i < 2; i++) {
        CGFloat h = (i*44) +(i==0?8:8);
        
        PersonalCell *cell = [[PersonalCell alloc] initWithFrame:CGRectMake(0, h, SCREEN_WIDTH, 44)];
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.delegate = self;
        cell.customViewInteger = i+1;
        cell.cellType = CellTypeCustom;
        [self.view addSubview:cell];
        
    }
    
    for (int j = 0; j < 2 + 1; j++) {
        CGFloat h = (j*44) +(j==0?8:9);
        
        UIBezierPath *line = [UIBezierPath bezierPath];
        CAShapeLayer *shapelayer = [CAShapeLayer layer];
        [line moveToPoint:CGPointMake(0, h)];
        [line addLineToPoint:CGPointMake(SCREEN_WIDTH, h)];
        shapelayer.strokeColor = RGB(199, 200, 201, 1).CGColor;
        shapelayer.frame = self.view.bounds;
        shapelayer.path = line.CGPath;
        shapelayer.lineWidth = 1.f;
        
        [self.view.layer addSublayer:shapelayer];
        
    }
    
    UIButton * but  = [[UIButton alloc] initWithFrame:CGRectMake(16, 120, SCREEN_WIDTH - 16*2, 44)];
    [but setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [but setTintColor:[UIColor whiteColor]];
    [but setBackgroundColor:[UIColor orangeColor]];
    but.layer.cornerRadius = 5.f;
    [self.view addSubview:but];
}

#pragma mark - PersonalCellDelegate
- (UIView *)personalCellForAddCustomViewWithView:(UIView *)view {
    
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 44)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, -2, 48, 48)];
    
    if (view.tag == 1) {
        labe.text = @"修改密码";
        
        
    }else {
        labe.text = @"关于讯联";
    }
    
    imageView.image = [UIImage imageNamed:@"ic_setting.png"];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(subViewClick:)];
    
    [subview addSubview:imageView];
    [subview addSubview:labe];
    [subview addGestureRecognizer:gesture];
    
    return subview;
}


- (void)subViewClick:(UITapGestureRecognizer *)tap {
    if (tap.view.tag == 1) {
        ModifyPasswordVC *pass = [[ModifyPasswordVC alloc] init];
        [self.navigationController pushViewController:pass animated:YES];
    }else {
        AboutXunLianVC *xunlian = [[AboutXunLianVC alloc] init];
        [self.navigationController pushViewController:xunlian animated:YES];
    }
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
