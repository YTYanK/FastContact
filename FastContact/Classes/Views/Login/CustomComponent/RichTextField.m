//
//  RichTextField.m
//  FastContact
//
//  Created by YTYanK on 17/1/9.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "RichTextField.h"


@interface RichTextField()
{
    CAShapeLayer *_shapelayer;
    CGSize  _imageSize;
}
@end

@implementation RichTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //初始化大小
        // private = Pr
        UIImageView *prIcon = [[UIImageView alloc] init];
        [self addSubview:prIcon];
        self.icon = prIcon;
        
        UILabel *prTheme = [[UILabel alloc] init];
        [self addSubview:prTheme];
        self.theme = prTheme;
        
        
        UITextField *prInputBox = [[UITextField alloc] init];
        [self addSubview:prInputBox];
        self.inputBox = prInputBox;
        
    }
    return self;
}







#pragma mark - set
- (void)setRichFarme:(CGRect)richFarme {
    _richFarme = richFarme;
}

- (void)setRichData:(NSDictionary *)richData {
    _richData = richData;
    [self updataRichTextFieldData:richData];
}

- (void)setRichThemeColor:(UIColor *)richThemeColor {
    _richThemeColor = richThemeColor;
    _shapelayer.strokeColor = richThemeColor.CGColor;
    _theme.textColor = richThemeColor;
}

- (void)setRichSecureTextEntry:(BOOL)richSecureTextEntry {
    _richSecureTextEntry = richSecureTextEntry;
    self.inputBox.secureTextEntry = _richSecureTextEntry;
}

- (void)setRichNo:(int)richNo {
    _richNo = richNo;
    self.inputBox.tag = richNo;
}


//CGSize size=[UIImage imageWithContentsOfFile:path].size;
// 设置大小及位置
- (void)updateFrame {
    
    CGFloat totalH = self.frame.size.height;
    CGFloat totalY = totalH - 23;
    
    
    self.icon.frame = CGRectMake(66, totalY  -5, _imageSize.width/2, _imageSize.height/2);
    self.theme.frame = CGRectMake(CGRectGetMaxX(self.icon.frame)+10, totalY - 2, 55, 20);
    self.inputBox.frame = CGRectMake(CGRectGetMaxX(self.theme.frame), CGRectGetMaxY(self.theme.frame) - totalH + 10, 200, totalH - 0);
    
    //画一条线
    UIBezierPath *line = [UIBezierPath bezierPath];
    [line moveToPoint:CGPointMake(CGRectGetMaxX(self.theme.frame), CGRectGetMaxY(self.theme.frame))];
    [line addLineToPoint:CGPointMake(338, CGRectGetMaxY(self.theme.frame))];
    
    _shapelayer = [CAShapeLayer layer];
    _shapelayer.frame = self.bounds;
    _shapelayer.path = line.CGPath;
    _shapelayer.lineWidth = 1.0;
    _shapelayer.opacity = 0.7;
    _shapelayer.strokeColor = _richThemeColor.CGColor;
    [self.layer addSublayer:_shapelayer];
}

// 设置数据
- (void)updataRichTextFieldData:(NSDictionary *)richData {
    if (richData != nil) {
      //方便版本更新UI
        
        // 获取图片大小
        self.icon.image = [UIImage imageNamed:[richData objectForKey:RICH_ICON]];
        if (![[richData objectForKey:RICH_ICON] isEqualToString:@""]) {
            _imageSize = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@",PATH_IMAGES_LOGIN,[richData objectForKey:RICH_ICON]]].size;
        }
        self.theme.text = [richData objectForKey:RICH_THEME];
        [UITextField addYTYanKTextFielStyle1:self.inputBox withString:[richData objectForKey:RICH_PROMPT]];
        [self updateFrame];
    }
}

@end
