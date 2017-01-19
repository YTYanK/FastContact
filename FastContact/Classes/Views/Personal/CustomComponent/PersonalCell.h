//
//  PersonalCell.h
//  FastContact
//
//  Created by YTYanK on 17/1/18.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CellType){
    CellTypeLeftContent = 1,
    CellTypeRightContent = 2,
    CellTypeLeftDoubleBtn = 3,
    CellTypeRightOneBtn = 4,
    CellTypeCustom = 5
};


@protocol PersonalCellDelegate <NSObject>

@optional
- (UIView *)personalCellForAddCustomViewWithView:(UIView *)view;

@end




@interface PersonalCell : UIView
@property (weak, nonatomic) id <PersonalCellDelegate>delegate;
/**
 * 必须选择类型，如果没有。。那就没有咯
 */
@property (nonatomic) CellType cellType;
@property (nonatomic) NSInteger customViewInteger;

@property (copy, nonatomic) NSString *fixedVlue;
@property (copy, nonatomic) NSString *conVlue;


@end
