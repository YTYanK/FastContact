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


// 设置大小及位置
- (void)updateFrame {
    
    CGFloat totalH = self.frame.size.height;

    
    CGFloat SW_2 = SCREEN_WIDTH/2;
    CGFloat SH_2 = totalH/2;
    CGFloat iconW_C = SW_2 - _imageSize.width/4;
    CGFloat iconH_C = SH_2 - _imageSize.height/4;
    
    self.icon.frame = CGRectMake(iconW_C, iconH_C, _imageSize.width/2, _imageSize.height/2);
    self.theme.size = CGSizeMake(55, 20);
    if (SCREEN_WIDTH == 320) {
        self.inputBox.size = CGSizeMake(150, totalH);
    }else if(SCREEN_WIDTH == 414){
        self.inputBox.size = CGSizeMake(200, totalH);
    }else {
        self.inputBox.size = CGSizeMake(150, totalH);
    }
    
    
    self.icon.frame = CGRectMake(_icon.frame.origin.x - _theme.frame.size.width - 55, _icon.frame.origin.y, _icon.frame.size.width, _icon.frame.size.height);
    self.theme.frame = CGRectMake(CGRectGetMaxX(self.icon.frame)+10, iconH_C + 4,_theme.size.width,_theme.size.height);
    self.inputBox.frame = CGRectMake(CGRectGetMaxX(_theme.frame), CGRectGetMaxY(self.theme.frame) - totalH + 10, _inputBox.width, totalH);
    
    
    //画一条线
    
    CGFloat lf = 0;
    if (SCREEN_WIDTH == 320) {
        lf = 280;
    }else if(SCREEN_WIDTH == 414) {
        lf = 330;
    }else {
        lf = 300;
    }
    
    UIBezierPath *line = [UIBezierPath bezierPath];
    [line moveToPoint:CGPointMake(CGRectGetMaxX(self.theme.frame), CGRectGetMaxY(self.theme.frame))];
    [line addLineToPoint:CGPointMake(lf, CGRectGetMaxY(self.theme.frame))];
    
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
