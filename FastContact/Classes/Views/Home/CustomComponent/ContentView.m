//
//  ContentView.m
//  FastContact
//
//  Created by YTYanK on 17/1/11.
//  Copyright © 2017年 YTYanK. All rights reserved.
//
          
#import "ContentView.h"



@interface ContentView()
@property (weak, nonatomic) IBOutlet UIButton *operationMaintenanceBtn;
@property (weak, nonatomic) IBOutlet UIButton *taskManagement;
@property (weak, nonatomic) IBOutlet UIButton *attendanceManagement;

@property (weak, nonatomic) IBOutlet UIButton *engineeringConstruction;
@property (weak, nonatomic) IBOutlet UIButton *examineApprove;

@property (weak, nonatomic) IBOutlet UIButton *notice;
@property (weak, nonatomic) IBOutlet UIButton *mailListBtn;
@property (weak, nonatomic) IBOutlet UIButton *knowledgeBaseBtn;
@end


@implementation ContentView

- (void)drawRect:(CGRect)rect {
    _operationMaintenanceBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 50, 13);
    _operationMaintenanceBtn.titleEdgeInsets = UIEdgeInsetsMake(90, -30, 0, 20);
    
    _taskManagement.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    _attendanceManagement.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    _engineeringConstruction.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    _examineApprove.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    _notice.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    
    if (SCREEN_WIDTH == 320.f) {
        _operationMaintenanceBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 45, 50, 13);
        
        _mailListBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 24, 40, 15);
        _mailListBtn.titleEdgeInsets = UIEdgeInsetsMake(20,-20, -20, 10);
        _knowledgeBaseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 24, 40, 15);
        _knowledgeBaseBtn.titleEdgeInsets = UIEdgeInsetsMake(20, -20, -20, 10);
    
    }else {
    
    _mailListBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 40, 10);
    _mailListBtn.titleEdgeInsets = UIEdgeInsetsMake(20,-18, -20, 18);
    _knowledgeBaseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 40, 10);
    _knowledgeBaseBtn.titleEdgeInsets = UIEdgeInsetsMake(20, -18, -20, 18);
    }
    
}

- (IBAction)mailListClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(buttonListClickWithView:forButton:)]) {
       [self.delegate buttonListClickWithView:self forButton:sender];
    }
   
}

@end
