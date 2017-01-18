//
//  LoginVC.m
//  FastContact
//
//  Created by YTYanK on 17/1/9.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import "LoginVC.h"
#import "HomeVC.h"
#import "LoginModel.h"


@interface LoginVC ()<UITextFieldDelegate,UITextFieldLolitaDelegate>
{
    /** 判断是否点击了 */
    BOOL   isClick;
}
@property (strong, nonatomic) RichTextField *account;
@property (strong, nonatomic) RichTextField *password;
@property (strong, nonatomic) UIButton *loginBtn;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateLoginView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    if (![[NSUD objectForKey:kFC_LoginAccount] isEqualToString:@""] && [NSUD objectForKey:kFC_LoginAccount] != nil) {
        self.account.inputBox.text = [NSUD objectForKey:kFC_LoginAccount];
        if (![[NSUD objectForKey:kFC_LoginPass] isEqualToString:@""] && [NSUD objectForKey:kFC_LoginPass] != nil) {
            self.password.inputBox.text = [NSUD objectForKey:kFC_LoginPass];
            _password.inputBox.enablesReturnKeyAutomatically  = NO;
            _loginBtn.userInteractionEnabled = YES;
            [_loginBtn setBackgroundColor:[UIColor orangeColor]];
            
        }else {
           self.password.inputBox.text = @"";
        }
        
    }else {
        self.account.inputBox.text = @"";
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





#pragma mark - 自定义方法
- (void)updateLoginView{
    
    
    //TODO: 硬性编码 之后处理
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:LOIN_IC_USE,RICH_ICON,@"账号：",RICH_THEME,@"请输入用户名",RICH_PROMPT,nil];
    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjectsAndKeys:LOIN_IC_PAS,RICH_ICON,@"密码：",RICH_THEME,@"请输入密码",RICH_PROMPT,nil];
    NSMutableArray *mutAry  = [NSMutableArray arrayWithObjects:dic,dic2,nil];
    
    // 账号输入框
    self.account = [[RichTextField alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 44)];
    self.account.richThemeColor = [UIColor orangeColor];
    self.account.richData = mutAry[0];
    self.account.richSecureTextEntry = NO;
    self.account.inputBox.delegate = self;
    [self.account.inputBox addTarget:self action:@selector(textLengthJudgeMethod:) forControlEvents:UIControlEventEditingChanged];
    
    // 密码输入框
    self.password = [[RichTextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.account.frame) + 10, SCREEN_WIDTH, 44)];
    self.password.richThemeColor = [UIColor orangeColor];
    self.password.richData = mutAry[1];
    self.password.richSecureTextEntry = YES;
    self.password.inputBox.delegate = self;
    [self.password.inputBox addTarget:self action:@selector(textLengthJudgeMethod:) forControlEvents:UIControlEventEditingChanged];
    self.password.inputBox.returnKeyType = UIReturnKeyDone;
    
    
    // 登录按钮
    self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(64, CGRectGetMaxY(self.password.frame) + 40, 280, 30)];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTintColor:[UIColor whiteColor]];
    [self.loginBtn setBackgroundColor:[UIColor grayColor]];
    [self.loginBtn.layer setCornerRadius:5.f];
    [self.loginBtn addTarget:self action:@selector(loginbtnCiake:) forControlEvents:UIControlEventTouchDown];
    
    
    [self.view addSubview:self.account];
    [self.view addSubview:self.password];
    [self.view addSubview:self.loginBtn];
    
}

// 判断是否禁止使用
- (void)textLengthJudgeMethod:(UITextField *)textField {
    
    if (self.password.inputBox.text.length > 0 && self.account.inputBox.text.length > 0) {
        _account.inputBox.enablesReturnKeyAutomatically  = NO;
        _loginBtn.userInteractionEnabled   = YES;
        [_loginBtn setBackgroundColor:[UIColor orangeColor]];
        
    }else {
        _password.inputBox.enablesReturnKeyAutomatically  = YES;
        _loginBtn.userInteractionEnabled = NO;
        [_loginBtn setBackgroundColor:[UIColor grayColor]];
    }
    
        if (textField == _account.inputBox) {
            if (textField.text.length > 15) {
                textField.text = [textField.text substringToIndex:15];
            }
        }else {
        
         if (textField == _password.inputBox) {
            if (textField.text.length > 12) {
                textField.text = [textField.text substringToIndex:12];
            }
         }
        }
}

- (void)loginbtnCiake:(UIButton *)btn {
    NSDictionary  *inter = FC_DIC(@"Login/Login",kFC_URL,[NSNumber numberWithInt:1],kFC_NetMethod,[NSNumber numberWithInt:1],kFC_Trans,nil);
    NSDictionary  *param = FC_DIC(_account.inputBox.text,@"UserName",_password.inputBox.text,@"Pwd",nil);
    [InterfaceViewModel sharedInterfaceViewModel].loading = true;
    
    [InterfaceViewModel requestWithObj:self Interface:inter andParam:param success:^(id model) {
        
        LoginModel *loginModel = model;
        NSLog(@"----->%@",loginModel.loginName);
        
        // 登录成功保存账号密码
        [NSUD setObject:_password.inputBox.text forKey:kFC_LoginPass];
        [NSUD setObject:_account.inputBox.text forKey:kFC_LoginAccount];
        [NSUD setObject:loginModel.SessionId forKey:kFC_SessionID];
        [NSUD setObject:loginModel.UserId forKey:kFC_UserId];
        [NSUD setObject:loginModel.loginName forKey:kFC_LoginName];
        //[[[UIDevice currentDevice] identifierForVendor] UUIDString]
        [NSUD setObject:@"88C888E8-B688-6880-88F0-08A8888ACC88" forKey:kFC_DeviceID];
        
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
        HomeVC *hvc = [storyboard instantiateInitialViewController];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [self presentViewController:hvc animated:YES completion:^{
            window.rootViewController = hvc;
        }];
        
    } failure:^(NSString *mag) {
        [MBProgressHUD yty_showErrorWithTitle:nil detailsText:mag toView:self.view];
    }];
    
}


#pragma  mark - FieldDelegate
/** 键盘显示  */
- (void)textFieldDidBeginEditing:(UITextField *)textField {
}

/** 键盘隐藏 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_account.inputBox resignFirstResponder];
    [_password.inputBox resignFirstResponder];
}

//输入框清空后调用的方法
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    NSString *str = _password.inputBox.text;
    NSString *str1 = _account.inputBox.text;
    if (str.length > 0 && str1.length> 0) {
        _password.inputBox.enablesReturnKeyAutomatically  = YES;
        _loginBtn.userInteractionEnabled = NO;
        [_loginBtn setBackgroundColor:[UIColor grayColor]];
    }
    
    return YES;//textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _account.inputBox) {
        [_password.inputBox becomeFirstResponder];
        
    }else {
        [self loginbtnCiake:_loginBtn];
    }
    return  YES;
}


@end
