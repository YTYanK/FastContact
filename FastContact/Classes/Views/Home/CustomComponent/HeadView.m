//
//  HeadView.m
//  FastContact
//
//  Created by YTYanK on 17/1/11.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "HeadView.h"
#import "AppDelegate.h"

@interface HeadView()
@property (weak, nonatomic) IBOutlet UIImageView *headPortrait;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *ascription;
@property (weak, nonatomic) IBOutlet UILabel *stagnationPoint;

@property (strong, nonatomic) NSMutableDictionary *param;

@property (copy, nonatomic) AMapLocatingCompletionBlock completionBlock;
@end

@implementation HeadView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self updateUI];
    [self initCompleteBlock];
}



- (void)updateUI {
    CGFloat headPortraitH = self.headPortrait.height;
    self.headPortrait.layer.cornerRadius = headPortraitH/2;
    self.headPortrait.layer.borderColor = RGB(66, 66, 66, 1).CGColor;
    self.headPortrait.layer.borderWidth = 1.f;
    self.headPortrait.layer.masksToBounds = YES;
    self.headPortrait.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headPortraitClick:)];
    [self.headPortrait addGestureRecognizer:gesture];
    
    CGFloat checkinH = self.checkin.height;
    self.checkin.layer.borderWidth = 1.f;
    self.checkin.layer.borderColor = [UIColor orangeColor].CGColor;
    self.checkin.layer.cornerRadius = checkinH/2;
    
}

- (void)headPortraitClick:(UIImageView *)view {
    if ([self.delegate respondsToSelector:@selector(headViewPortraitForImageView:)]) {
         [self.delegate headViewPortraitForImageView:view];
    }
}

- (IBAction)checkinClick:(id)sender {
    [[UtilToolsClss getUtilTools] addDoLoading];
    [self location];
}

- (void)location {
    [[[self appDelegate] locationManager] requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}
- (void)initCompleteBlock {
    __weak HeadView *weakSelf = self;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            //如果为定位失败的error，则不进行后续操作
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        //得到定位信息
        if (location)
        {
            // 手机上才可以获得准确信息
            if (regeocode)
            {
                NSString *endpostion = regeocode.formattedAddress;
                
               // [NSString stringWithFormat:@"%@ \n %@-%@-%.2fm", regeocode.formattedAddress,regeocode.citycode, regeocode.adcode, location.horizontalAccuracy];
                
                [weakSelf.param setObject:[NSString stringWithFormat:@"%f",location.coordinate.longitude] forKey:@"x"];
                [weakSelf.param setObject:[NSString stringWithFormat:@"%f",location.coordinate.latitude] forKey:@"y"];
                [weakSelf.param setObject:endpostion forKey:@"location"];
                
                 NSString *urlStr = @" ";
                if (weakSelf.isonline == 0) {
                    urlStr = @"User/CheckIn";
                }else {
                    urlStr = @"User/CheckOut";
                }
                
                NSDictionary  *inter = FC_DIC(urlStr,kFC_URL,[NSNumber numberWithInt:-1],kFC_NetMethod,[NSNumber numberWithInt:2],kFC_Trans,nil);
                [InterfaceViewModel sharedInterfaceViewModel].loading = false;
                [InterfaceViewModel requestWithObj:weakSelf Interface:inter andParam:weakSelf.param success:^(id model) {
                     [[UtilToolsClss getUtilTools] removeDoLoading];
                        if (weakSelf.isonline == 1) {
                            weakSelf.isonline = 0;
                            [MBProgressHUD yty_showErrorWithTitle:nil detailsText:@"签出成功" toView:weakSelf.vc.view];
                          //  [MBProgressHUD showMessage:@"签出成功" toView:weakSelf.vc.view];
                        }else {
                            weakSelf.isonline = 1;
                            [MBProgressHUD yty_showErrorWithTitle:nil detailsText:@"签入成功" toView:weakSelf.vc.view];
                           // [MBProgressHUD showMessage:@"签入成功" toView:weakSelf.vc.view];
                        }
                } failure:^(NSString *mag) {
                    [[UtilToolsClss getUtilTools] removeDoLoading];
                    [MBProgressHUD yty_showErrorWithTitle:nil detailsText:mag toView:weakSelf.vc.view];
                }];

                
            }
            else
            {
                //  [weakSelf.displayLabel setText:[NSString stringWithFormat:@"lat:%f;lon:%f \n accuracy:%.2fm", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy]];
            }
        }
    };
}



#pragma mark - get
- (NSMutableDictionary *)param {
    if (_param == nil) {
        _param = [NSMutableDictionary dictionary];
    }
    return _param;
}

- (AppDelegate*)appDelegate {
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}



- (void)setIsonline:(int)isonline {
    _isonline = isonline;
    
    // islogin":true = 1
    if (isonline == 1) {
        // 签入了
        [_checkin setTitle:@"签出" forState:UIControlStateNormal];
        _checkin.layer.borderColor = [UIColor blackColor].CGColor;
        [_checkin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_checkin setBackgroundColor:[UIColor whiteColor]];
        
    }else {
        [_checkin setTitle:@"签入" forState:UIControlStateNormal];
        _checkin.layer.borderColor = [UIColor orangeColor].CGColor;
        [_checkin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_checkin setBackgroundColor:[UIColor orangeColor]];
    }
}

@end
