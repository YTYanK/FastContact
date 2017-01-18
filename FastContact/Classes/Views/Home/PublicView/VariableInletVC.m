//
//  VariableInletVC.m
//  FastContact
//
//  Created by YTYanK on 17/1/16.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "VariableInletVC.h"
#import "ButtonBlockView.h"
#import "BaseListModel.h"

@interface VariableInletVC ()

@end

@implementation VariableInletVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 ceil(x)返回不小于x的最小整数值（然后转换为double型）。
 floor(x)返回不大于x的最大整数值。
 round(x)返回x的四舍五入整数值。
 */
- (void)initVariableInletViewForBtnData:(NSArray *)data {
    CGFloat fs = 8;  // fixedSpacing － 固定间距
    CGFloat w = SCREEN_WIDTH/2;
    CGFloat h = 75;
    CGFloat spacingH = fs*2; // 可以变的行间距
    CGFloat spacingW = 8;   // 控制左右两端间距
    CGFloat spacingC = 5;   // 控制中间间距
    
    int tally = 0;
    if (self.baseList.count != 0) {
       tally = (int)self.baseList.count;
    }else {
        tally = (int)data.count;
    }
    NSUInteger tally2 = 0;
    int  hNum =  round(tally/2.0);
    for (int i = 0; i < hNum; i++) { //行 ＊3
        
 
        for (int j = 0; j < 2; ++j) {  //列 ＊2
            
            tally2 = i + i + j;
            ButtonBlockView *view = [[ButtonBlockView alloc] initWithFrame:CGRectMake((j*w)+( j==1 ? spacingW*j - spacingC : spacingW*(j+1) ),
                                                                                      (i==0 ? spacingH*(i +1) : fs*i+spacingH) + h*i,
                                                                                      w - spacingW*2 + spacingC,
                                                                                      h)];
            if (self.baseList.count != 0) {
                view.text = [[self.baseList objectAtIndex:tally2] name];
            }else {
                view.text = [data objectAtIndex:tally2];
            }
            
            [self.view addSubview:view];
            
            if (hNum == i+1) {
                if (tally%2>0) {
                    break;
                }
            }
        }
    }
    
    
}

- (void)setBaseList:(NSArray<BaseListModel *> *)baseList{
    _baseList = baseList;
    [self initVariableInletViewForBtnData:nil];
}

- (void)setInletSign:(NSString *)inletSign {
    _inletSign = inletSign;
    if (![inletSign isEqualToString:@"OperationMaintenance"]) {
        
        if ([inletSign isEqualToString:@"TaskManagement"]) {
            [self initVariableInletViewForBtnData:@[@"超时工单提醒",@"抢单池",@"临时任务"]];
        }else {
            [self initVariableInletViewForBtnData:@[@"我的申请",@"我的审批"]];
        }
        
        
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
