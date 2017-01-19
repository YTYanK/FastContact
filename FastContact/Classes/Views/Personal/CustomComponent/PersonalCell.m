//
//  PersonalCell.m
//  FastContact
//
//  Created by YTYanK on 17/1/18.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "PersonalCell.h"



static CGFloat const cell_H = 44;
static CGFloat const label_W = 80; //MAX = 80
static CGFloat const fixed_left_spacing = 8;
static CGFloat const vlue_left_spacing = 20;


@interface PersonalCell()
@property (strong, nonatomic) UILabel *fixedTitle;
@property (strong, nonatomic) UILabel *contentVlue;

@end

@implementation PersonalCell

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, CGRectGetWidth(frame), CGRectGetHeight(frame));
        self.backgroundColor = [UIColor whiteColor];
        
        self.fixedTitle = [[UILabel alloc] initWithFrame:CGRectMake(fixed_left_spacing, 0, label_W, cell_H)];
    
        self.fixedTitle.textAlignment = NSTextAlignmentLeft;
        self.contentVlue =  [[UILabel alloc] init];
        self.contentVlue.textColor = RGB(161, 162, 163, 1);
        [self addSubview:self.fixedTitle];
        [self addSubview:self.contentVlue];
        
       
    }
    return self;
}

#pragma mark - set
- (void)setFixedVlue:(NSString *)fixedVlue {
    _fixedVlue = fixedVlue;
    _fixedTitle.text = fixedVlue;
}

- (void)setConVlue:(NSString *)conVlue {
    _conVlue = conVlue;
    _contentVlue.text = conVlue;
}

- (void)setCellType:(CellType)cellType {
    _cellType = cellType;
    
    CGFloat imageH = 23;
    CGFloat imageW = 18;
    CGFloat imageH_C = (self.height - 23)/2;
    CGFloat image2H_C = (self.height - 24)/2;
    
    if (_cellType == CellTypeRightContent || _cellType == CellTypeRightOneBtn) {
        
        _contentVlue.frame = CGRectMake(SCREEN_WIDTH - fixed_left_spacing -(SCREEN_WIDTH/1.5), 0, SCREEN_WIDTH/1.5, cell_H);
        _contentVlue.textAlignment = NSTextAlignmentRight;
        
        if(_cellType == CellTypeRightOneBtn) {
            
            _contentVlue.x = SCREEN_WIDTH - (fixed_left_spacing*2) - (SCREEN_WIDTH/1.5) -imageW;
            
            UIButton *icon1 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_contentVlue.frame) + fixed_left_spacing, imageH_C, imageW, imageH)];
            [icon1 setImage:[UIImage imageNamed:@"ic_my_location.png"] forState:UIControlStateNormal];
            [self addSubview:icon1];
        }
        
    }else if (_cellType == CellTypeLeftContent || _cellType == CellTypeLeftDoubleBtn) {
        _contentVlue.textAlignment = NSTextAlignmentLeft;
        _contentVlue.frame = CGRectMake(CGRectGetMaxX(_fixedTitle.frame) + vlue_left_spacing, 0, SCREEN_WIDTH - (CGRectGetMaxX(_fixedTitle.frame) + vlue_left_spacing), cell_H);
        
        if (_cellType == CellTypeLeftDoubleBtn) {
            
            _contentVlue.width = SCREEN_WIDTH/3.f;
            
            UIButton *icon1 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_contentVlue.frame) + vlue_left_spacing, image2H_C, imageH+1, imageH+1)];
            [icon1 setImage:[UIImage imageNamed:@"ic_call.png"] forState:UIControlStateNormal];
            UIButton *icon2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon1.frame) + vlue_left_spacing, image2H_C, imageH+1, imageH+1)];
            [icon2 setImage:[UIImage imageNamed:@"ic_sms.png"] forState:UIControlStateNormal];
            
            [self addSubview:icon1];
            [self addSubview:icon2];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(personalCellForAddCustomViewWithView:)]) {
             self.contentVlue = nil;
            [self.contentVlue removeFromSuperview];
             self.fixedTitle = nil;
            [self.fixedTitle removeFromSuperview];
            UIView * sub = [self.delegate personalCellForAddCustomViewWithView:self];
            sub.tag = self.customViewInteger;
            [self addSubview:sub];
        }
    }
}

- (void)setCustomViewInteger:(NSInteger)customViewInteger {
    _customViewInteger = customViewInteger;
    self.tag = customViewInteger;
}


@end
