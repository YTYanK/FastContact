//
//  PersonalVC.m
//  FastContact
//
//  Created by YTYanK on 17/1/18.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "PersonalVC.h"
#import "PersonalCell.h"
#import "ConfigureVC.h"

@interface PersonalVC ()
@property (weak, nonatomic) IBOutlet UIImageView *personImage;
@property (weak, nonatomic) IBOutlet UILabel *personName;
@property (weak, nonatomic) IBOutlet UILabel *personNo;
@end

@implementation PersonalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updatePersonalView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 更新UI
- (void)updatePersonalView {
    self.view.backgroundColor = RGB(244, 245, 246, 1);
    
    _personImage.layer.cornerRadius = 34.f;
    _personImage.layer.borderColor = RGB(66, 66, 66, 1).CGColor;
    _personImage.layer.borderWidth = 1.f;
    _personImage.layer.masksToBounds = YES;
    _personImage.userInteractionEnabled = YES;
    if (![self.personalSign isEqualToString:@"details"]) {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headPortraitClick:)];
        [_personImage addGestureRecognizer:gesture];
    }
   
   
    
    NSArray *fixedAry;
    if ([self.personalSign isEqualToString:@"details"]) {
        fixedAry = @[@"部门",@"职位",@"手机",@"座机",@"邮箱"];
    }else {
        fixedAry = @[@"部门",@"职务",@"手机",@"驻点位置"];
        
        UIBarButtonItem *rightBut = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"ic_setting" highBackgroudImageName:@"ic_setting" target:self action:@selector(rightBarButtomItemAction:)];
        
        self.navigationItem.rightBarButtonItem = rightBut;
        self.navigationItem.rightBarButtonItem.imageInsets = UIEdgeInsetsMake(0, 0, 100, 0);
        
    }
    
    for (int i = 0; i < fixedAry.count; i++) {
        PersonalCell *cell = [[PersonalCell alloc] initWithFrame:CGRectMake(0,(44*i) + 136, SCREEN_WIDTH, 44)];
        
        if ([self.personalSign isEqualToString:@"details"]) {
            if (i == 3) {
                cell.cellType = CellTypeLeftDoubleBtn;
            }else {
                cell.cellType = CellTypeLeftContent;
            }
            
        }else {
            if (i==(fixedAry.count -1)) {
                cell.cellType = CellTypeRightOneBtn;
            }else {
                cell.cellType = CellTypeRightContent;
            }
        }
        cell.fixedVlue = fixedAry[i];
        cell.conVlue = @"12345678958";//@"E:7113.557827.  N:8223.234567.";
        [self.view addSubview:cell];
    }
    
    for (int j = 0; j < fixedAry.count + 1; j++) {
        UIBezierPath *line = [UIBezierPath bezierPath];
        CAShapeLayer *shapelayer = [CAShapeLayer layer];
        if (j== 0 || j == fixedAry.count) {
            [line moveToPoint:CGPointMake(0, (44*j)+136)];
            [line addLineToPoint:CGPointMake(SCREEN_WIDTH, (44*j)+136)];
        }else {
            [line moveToPoint:CGPointMake(8, (44*j)+136)];
            [line addLineToPoint:CGPointMake(SCREEN_WIDTH -8, (44*j)+136)];
        }
        shapelayer.strokeColor = RGB(199, 200, 201, 1).CGColor;
        shapelayer.frame = self.view.bounds;
        shapelayer.path = line.CGPath;
        shapelayer.lineWidth = 1.f;
        
        [self.view.layer addSublayer:shapelayer];

    }
    

}

#pragma mark - 自定义
- (void)headPortraitClick:(UITapGestureRecognizer *)tap {
    NSLog(@"点击图片");
}

- (void)rightBarButtomItemAction:(UIBarButtonItem *)item{
    ConfigureVC * configure = [[ConfigureVC alloc] initWithNibName:@"ConfigureVC" bundle:nil];
    [self.navigationController pushViewController:configure animated:YES];
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
