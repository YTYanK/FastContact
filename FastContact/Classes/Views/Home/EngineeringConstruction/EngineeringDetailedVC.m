//
//  EngineeringDetailedVC.m
//  FastContact
//
//  Created by YTYanK on 17/1/11.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "EngineeringDetailedVC.h"

@interface EngineeringDetailedVC ()
@property (weak, nonatomic) IBOutlet UILabel *entryName;
@property (weak, nonatomic) IBOutlet UILabel *entryProgress;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *planDate;
@property (weak, nonatomic) IBOutlet UILabel *completeDate;
@property (weak, nonatomic) IBOutlet UILabel *comleted;
@property (weak, nonatomic) IBOutlet UILabel *settlement;

@property (weak, nonatomic) IBOutlet UILabel *entryNameVlue;
@property (weak, nonatomic) IBOutlet UILabel *startDateVlue;
@property (weak, nonatomic) IBOutlet UILabel *planDateVlue;
@property (weak, nonatomic) IBOutlet UILabel *completeDateVlue;
@property (weak, nonatomic) IBOutlet UILabel *comletedVlue;
@property (weak, nonatomic) IBOutlet UILabel *settlementVlue;
@property (weak, nonatomic) IBOutlet UIStackView *xxx;

@end

@implementation EngineeringDetailedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateEngineeringView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateEngineeringView {

    const int  t = 5;
    int  f = 44;
    int  j = 0;
    int  k = 0;
    int  sovlue = 0;
    int  ta = 0;
    
    
    //画线条 8
    for (int i = 1; i < 10; i++) {
        UIBezierPath *line = [UIBezierPath bezierPath];
        CAShapeLayer *shapelayer = [CAShapeLayer layer];
        if (i%2 == 0) {
            k++;
           //偶数
            if (i < 4) {
                ta = t*j + f*k;
                shapelayer.strokeColor = [UIColor greenColor].CGColor;
            }else if(i == 4) {
            
                ta = sovlue = t*(j-2) + f*(k+2);
                shapelayer.strokeColor = [UIColor redColor].CGColor;
              
            }else {
                ta = t*j + f*(k-2.1) + sovlue;
                shapelayer.strokeColor = [UIColor blueColor].CGColor;
            }
        }else {
            j++;
            //奇数
            if (i < 5) {
                ta = t*j + f*k;
                shapelayer.strokeColor = [UIColor greenColor].CGColor;
            }else if(i == 5) {
                
                ta = sovlue = t*(j-2) + f*(k+2);
                shapelayer.strokeColor = [UIColor redColor].CGColor;
                
            }else {
                ta = t*j + f*(k-2.1) + sovlue;
                shapelayer.strokeColor = [UIColor blueColor].CGColor;
            }
            
        }
        
        [line moveToPoint:CGPointMake(self.entryName.x, ta)];
        [line addLineToPoint:CGPointMake(SCREEN_WIDTH,  ta)];
    
   
    shapelayer.frame = self.view.bounds;
    shapelayer.path = line.CGPath;
    shapelayer.lineWidth = 1.f;
    
    [self.view.layer addSublayer:shapelayer];
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
