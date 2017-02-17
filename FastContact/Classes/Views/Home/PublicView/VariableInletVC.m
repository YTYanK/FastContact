//
//  VariableInletVC.m
//  FastContact
//
//  Created by YTYanK on 17/1/16.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "VariableInletVC.h"
#import "ButtonBlockView.h"
#import "WorkOrderVC.h"

#import "BaseListModel.h"
#import "SecCategoryListModel.h"
#import "WorkCategoryListModel.h"

@interface VariableInletVC ()<ButtonBlockDelage>
/**
 * 用来装数据
 */
@property (strong, nonatomic) NSMutableArray *dataAry;
/**
 * 更新标题
 */
@property (strong, nonatomic) NSString *updateNavTitle;
/**
 * 方块编号
 */
@property (nonatomic) NSNumber *blockTag;
/** 
 * 装列表值字典
 */
@property (strong, nonatomic) NSDictionary *dataDic;
/**
 * 按钮事件类型
 */
@property (strong, nonatomic) NSArray *btnStyleAry;
/**
 * 方块ID
 */
@property (strong, nonatomic) NSString *blockID;

@end

@implementation VariableInletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if ([self.baseList count] == 0) {
//        [MBProgressHUD yty_showErrorWithTitle:nil detailsText:@"没有更多数据了" toView:self.view];
//        return;
//    }
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
    if (data.count != 0) { //self.baseList.count
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
            view.tag = tally2;
            view.delage = self;
            if (data.count != 0) {
               // view.text = [[self.baseList objectAtIndex:tally2] name];
                view.text = [data objectAtIndex:tally2];
            }
            [self.buttonBlockViewAry addObject:view];
            [self.view addSubview:view];
            
            if (hNum == i+1) {
                if (tally%2>0) {
                    break;
                }
            }
        }
    }
    
}


- (void)removeInletView {
     [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

#pragma mark - set

- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    self.title = navTitle;
}

- (void)setBaseList:(NSArray<BaseListModel *> *)baseList{
    _baseList = baseList;
   

    NSMutableArray * ary = [NSMutableArray array];
    for (BaseListModel *model in baseList) {
        [ary addObject:[model name]];
    }
    
    [self initVariableInletViewForBtnData:ary];
    
    for (int i = 0; i<_buttonBlockViewAry.count; i++) {
        BaseListModel  *model    = _baseList[i];
        ButtonBlockView * view   =  _buttonBlockViewAry[i];
        view.tag = [[model value] integerValue];
    }
    
}

- (void)setInletSign:(NSString *)inletSign {
    _inletSign = inletSign;
    if (![inletSign isEqualToString:@"OperationMaintenance"]) {
        
        if ([inletSign isEqualToString:@"TaskManagement"]) {
            [self removeInletView];
            [self initVariableInletViewForBtnData:@[@"超时工单提醒",@"抢单池",@"临时任务"]];
        }else if([inletSign isEqualToString:@"LeaveExaminationAndApproval"]) {
            [self removeInletView];
            [self initVariableInletViewForBtnData:@[@"我的申请",@"我的审批"]];
        }else {
            
        }
    }
        
}

#pragma mark - ButtonBlockDelage

- (void)clickBlockButton:(ButtonBlockView *)block {
     NSLog(@"牌号与标题--->%ld--->%@",(long)block.tag,block.text);

    self.blockTag = [NSNumber numberWithInteger:block.tag];
    if ([self.inletSign isEqualToString:@"SubordinateOperationMaintenance"]) {
        
        
        self.updateNavTitle = [NSString stringWithFormat:@"%@-%@",[NSUD objectForKey:Nav_Title],block.text];
      
        NSDictionary  *param = FC_DIC([NSNumber numberWithInt:1],@"Page",[NSNumber numberWithInt:200],@"PageSize",self.blockTag,@"Seccategory",[NSUD objectForKey:Block_Tag],@"WorkIndex",nil);
         [InterfaceViewModel sharedInterfaceViewModel].loading = true;
   
              NSDictionary  *inter = FC_DIC(@"Task/WorkCategoryList",kFC_URL,[NSNumber numberWithInt:-1],kFC_NetMethod,[NSNumber numberWithInt:2],kFC_Trans,nil);
            
            [InterfaceViewModel requestWithObj:self Interface:inter andParam:param success:^(id model) {
                self.dataAry = nil;
                for (WorkCategoryListModel *list in model) {
                    //TODO: 如果list 长度 大于 0 会被覆盖
                    self.blockID = list.workcategory1id;
                    [self.dataAry addObject:list.name];
                }
                [self.dataAry insertObject:@"全部" atIndex:0];
                
                
                if ([block.text isEqualToString:@"发电"]) {
                    self.dataDic = @{Inlet_Screen:@[],Inlet_State:@[@"全部",@"发电中",@"发电完成"]};
                    self.btnStyleAry = @[@"MenuStyleTable",@"MenuStyleButton"];
                }else if ([block.text isEqualToString:@"巡检"]) {
                    self.dataDic = @{Inlet_Screen:@[],Inlet_Type:self.dataAry,Inlet_State:@[@"全部",@"待巡检",@"巡检中",@"已完成"]};
                }else if ([block.text isEqualToString:@"隐患"]) {
                    self.dataDic = @{Inlet_Screen:@[]};
                    self.btnStyleAry = @[@"MenuStyleButton"];
                }else {
                    self.dataDic = @{Inlet_Screen:@[],Inlet_Type:self.dataAry,Inlet_State:@[@"全部",@"未接单",@"已完工",@"未完工",@"退单"]};
                    self.btnStyleAry = @[@"MenuStyleTable",@"MenuStyleTable",@"MenuStyleButton"];
                }
                
                [self performSegueWithIdentifier:@"goToWorkOrder" sender:self];
                
                
            } failure:^(NSString *mag) {
                [MBProgressHUD yty_showErrorWithTitle:nil detailsText:mag toView:self.view];
            }];
            

    }else {
  
        // 第二层分类
        NSDictionary  *inter = FC_DIC(@"Task/SecCategoryList",kFC_URL,[NSNumber numberWithInt:-1],kFC_NetMethod,[NSNumber numberWithInt:2],kFC_Trans,nil);
        NSDictionary  *param = FC_DIC([NSNumber numberWithInt:1],@"Page",[NSNumber numberWithInt:100],@"PageSize",self.blockTag,@"WorkIndex",nil);
        [InterfaceViewModel sharedInterfaceViewModel].loading = true;
        [InterfaceViewModel requestWithObj:self Interface:inter andParam:param success:^(id model) {
    
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Public" bundle:nil];
        VariableInletVC *inlet = [story instantiateViewControllerWithIdentifier:@"variableInletVC"];
        inlet.inletSign = @"SubordinateOperationMaintenance";
            
            NSMutableArray *ary = [NSMutableArray array];
            for (SecCategoryListModel *se in model) {
                [ary addObject:[se seccategoryname]];
            }
            [inlet initVariableInletViewForBtnData:ary];
            
            for (int i = 0; i<inlet.buttonBlockViewAry.count; i++) {
                SecCategoryListModel  *list    = model[i];
                ButtonBlockView * view   = inlet.buttonBlockViewAry[i];
                view.tag = [[list seccategory] integerValue];
            }
            [self.navigationController pushViewController:inlet animated:YES];
            inlet.title = block.text;
            [NSUD setValue:block.text forKey:Nav_Title];
            [NSUD setInteger:block.tag forKey:Block_Tag];
            
        } failure:^(NSString *mag) {
            [MBProgressHUD yty_showErrorWithTitle:nil detailsText:mag toView:self.view];
        }];
        
        
        
    }
}


#pragma mark - get 
- (NSMutableArray *)buttonBlockViewAry {
    if (_buttonBlockViewAry == nil) {
        _buttonBlockViewAry = [NSMutableArray array];
    }
    return _buttonBlockViewAry;
}

- (NSMutableArray *)dataAry {
    if (_dataAry == nil) {
        _dataAry = [NSMutableArray array];
    }
    return _dataAry;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier compare:@"goToWorkOrder"] == NO) {
        id vc = segue.destinationViewController;
        [vc setValue:self.blockID forKey:@"btnAdditionalStr"];
        [vc setValue:self.updateNavTitle forKey:@"navTitle"];
        [vc setValue:self.btnStyleAry forKey:@"menuStyleAry"];
        [vc setValue:self.dataDic forKey:@"menuDic"];
        [vc setValue:self.blockTag forKey:@"workBlockTag"];
    }
}

@end
