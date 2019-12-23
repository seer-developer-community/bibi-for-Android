//
//  ChangePasswordViewController.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/2.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "InventorViewController.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *accountLine;
@property (nonatomic, strong) UIView *passwordLine;

//账号
@property(nonatomic,strong)UILabel *oldLabel;
//密码
@property(nonatomic,strong)UILabel *ferLabel;
//再次密码
@property(nonatomic,strong)UILabel *passaginLable;

//跳转导入
@property(nonatomic,strong)UILabel *danqianyuer;

//显示文字
@property(nonatomic,strong)UILabel *forgetLabel;

//导入助记词
@property(nonatomic,strong)UILabel *importLabel;



//错误提示
@property(nonatomic,strong)UILabel *errorLabel;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopView];
    
    [self setupUI];
}



-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    self.navigationController.navigationBarHidden = YES;
    
    self.navView.title = NSLocalizedStringFromTable(@"Change Password",@"Internation", nil);
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
}


-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)setupUI{
    
    /** 设置内容视图 */
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.layer.cornerRadius = 6.7;
    [self.view addSubview:self.containerView];
    
    
    //初始化手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
//    "Current Password" = "当前密码";
//    "New Password" ="新密码";
//    "Repeat New Password" ="重复新密码";
    //用户名
    UILabel * oldLabel = [[UILabel alloc]init];
    oldLabel.text = NSLocalizedStringFromTable(@"Current Password",@"Internation", nil);
    
    oldLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7];
    oldLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    self.oldLabel = oldLabel;
    [self.containerView addSubview:oldLabel];
    
    /** 设置账号输入 */
    self.oldPasswordTF.placeholder = NSLocalizedStringFromTable(@"Please enter old password",@"Internation", nil);;
    
    self.oldPasswordTF.tintColor = UIColorFromHexValue(0x444444);
    self.oldPasswordTF.textColor = UIColorFromHexValue(0x444444);
    self.oldPasswordTF.font = [UIFont systemFontOfSize:13.f];
    //    self.accountTF.leftViewMode = UITextFieldViewModeAlways;
    //    self.accountTF.backgroundColor =[UIColor redColor];
    self.oldPasswordTF.delegate = self;
    self.oldPasswordTF.keyboardType=UIKeyboardTypeDefault;
    self.oldPasswordTF.keyboardType = UIKeyboardTypeASCIICapable;
    self.oldPasswordTF.secureTextEntry = YES;
    self.oldPasswordTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.oldPasswordTF setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    //    UIImageView *accountImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kTFLeftW, kTFLeftH)];
    //    accountImageV.contentMode = UIViewContentModeLeft;
    //    accountImageV.image = [UIImage imageNamed:@"login_account"];
    //    self.accountTF.leftView = accountImageV;
    [self.containerView addSubview:self.oldPasswordTF];
    
    //    //账号的下划线
    UIView *accountLine = [[UIView alloc] init];
    accountLine.backgroundColor = UIColorFromHexValue(0xC2C2C2);
    self.accountLine = accountLine;
    [self.containerView addSubview:accountLine];
    
    //密码
    
    UILabel *ferLabel = [[UILabel alloc]init];
    ferLabel.text = NSLocalizedStringFromTable(@"New Password",@"Internation", nil);
    ferLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7];
    ferLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    self.ferLabel = ferLabel;
    [self.containerView addSubview:ferLabel];
//    "Please enter old password" ="请输入旧密码";
//    "Please enter new password" ="请输入新密码";
//    "Please enter your new password again" ="请再次输入新密码";
    //密码
    self.passwordTF.placeholder = NSLocalizedStringFromTable(@"Please enter new password",@"Internation", nil);
    self.passwordTF.tintColor = UIColorFromHexValue(0x444444);
    self.passwordTF.textColor = UIColorFromHexValue(0x444444);
    self.passwordTF.font = [UIFont systemFontOfSize:13.f];
    //    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    //    self.passwordTF.leftView = passwordImageV;
    self.passwordTF.keyboardType=UIKeyboardTypeDefault;
    self.passwordTF.keyboardType = UIKeyboardTypeASCIICapable;
    self.passwordTF.secureTextEntry = YES;
    self.passwordTF.delegate = self;
    [self.passwordTF setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.containerView addSubview:self.passwordTF];
    
    
    
    
    
    //    //密码下划线
    UIView *passwordLine = [[UIView alloc] init];
    passwordLine.backgroundColor = UIColorFromHexValue(0xC2C2C2);
    self.passwordLine = passwordLine;
    [self.containerView addSubview:passwordLine];
    
    
    //再次密码
    UILabel *passaginLable = [[UILabel alloc]init];
    passaginLable.text =  NSLocalizedStringFromTable(@"Repeat New Password",@"Internation", nil);
    passaginLable.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7];
    passaginLable.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    self.passaginLable = passaginLable;
    [self.containerView addSubview:passaginLable];
    
    
    
    //密码
    self.unpasswordTF.placeholder = NSLocalizedStringFromTable(@"Please enter your new password again",@"Internation", nil);
    self.unpasswordTF.tintColor = UIColorFromHexValue(0x444444);
    self.unpasswordTF.textColor = UIColorFromHexValue(0x444444);
    self.unpasswordTF.font = [UIFont systemFontOfSize:13.f];
    self.unpasswordTF.secureTextEntry = YES;
    //    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    //    self.passwordTF.leftView = passwordImageV;
    self.unpasswordTF.delegate = self;
    self.unpasswordTF.keyboardType=UIKeyboardTypeDefault;
    self.unpasswordTF.keyboardType = UIKeyboardTypeASCIICapable;
    [self.unpasswordTF setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.containerView addSubview:self.unpasswordTF];
//    "Forgot Password" = "Forgot Password? Import mnemonic words to reset password,";
//    "import right now" ="import right now";
    //导入助记词
    self.forgetLabel = [[UILabel alloc]init];
    self.forgetLabel.text =  NSLocalizedStringFromTable(@"Forgot Password",@"Internation", nil);
    self.forgetLabel.textColor = UIColorFromHexValue(0x444444);
    self.forgetLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    [self.view addSubview:self.forgetLabel];
    
    // 导入助记词
    self.importLabel = [[UILabel alloc]init];
    self.importLabel.text = NSLocalizedStringFromTable(@"import right now",@"Internation", nil);
    self.importLabel.textColor = UIColorFromHexValue(0x2c86e3);
    self.importLabel.userInteractionEnabled=YES;
    self.importLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    UITapGestureRecognizer *tap1= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction1)];
    [  self.importLabel addGestureRecognizer:tap1];
    [self.view addSubview:self.importLabel];
    
    
    //错误提示
    self.errorLabel =[[UILabel alloc]init];
    _errorLabel.numberOfLines = 0;
    _errorLabel.textColor = [UIColor redColor];
    _errorLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    _errorLabel.text =@"";
    [self.view addSubview:_errorLabel];
    
    
    
    
    
    //创建钱包
    [self.loginBtn setTitle:NSLocalizedStringFromTable(@"Buttonsure",@"Internation", nil) forState:UIControlStateNormal];
    [self.loginBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    InQusetion.backgroundColor =  UIColorFromHexValue(0x81d8cf);
    [self.loginBtn setGradientBackgroundWithColors:@[UIColorFromHexValue(0x2A7DDF),UIColorFromHexValue(0x38AFF4)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    self.loginBtn .layer.cornerRadius = 20;
    self.loginBtn .layer.masksToBounds = NO;
    [self.loginBtn  addTarget:self action:@selector(loginGo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn ];
    
   
    

    [self uplayout];
    
}

-(void)uplayout{
    
    
    //背景
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom).offset(30*kHeightScale);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(340*kWidthScale, 156*kHeightScale));
        
    }];
    
    //用户名
    [self.oldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15*kWidthScale);
        make.top.mas_equalTo(20*kHeightScale);
        
    }];
    
    
    [self.oldPasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(self.containerView.mas_top).offset(15*kHeightScale);
        make.left.mas_equalTo(self.oldLabel.mas_right).offset(15*kWidthScale);
        make.size.mas_equalTo(CGSizeMake(250*kWidthScale, 40*kHeightScale));
        make.centerY.mas_equalTo(self.oldLabel.mas_centerY);
    }];
//
    [self.accountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-1.f);
        make.top.mas_equalTo(self.oldPasswordTF.mas_bottom);
        make.height.mas_equalTo(.4f);
    }];

    // 密码：

    [self.ferLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(self.oldLabel.mas_left);
        make.top.mas_equalTo(self.accountLine.mas_bottom).offset(20*kHeightScale);

    }];

    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(self.containerView.mas_top).offset(15*kHeightScale);
        make.left.mas_equalTo(self.oldLabel.mas_right).offset(15*kWidthScale);
        make.size.mas_equalTo(CGSizeMake(250*kWidthScale, 40*kHeightScale));
        make.centerY.mas_equalTo(self.ferLabel.mas_centerY);
    }];
//

    [self.passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-1.f);
        make.top.mas_equalTo(self.passwordTF.mas_bottom);
        make.height.mas_equalTo(.8f);
    }];

    //再次输入密码

    [self.passaginLable mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(self.oldLabel.mas_left);
        make.top.mas_equalTo(self.passwordLine.mas_bottom).offset(20*kHeightScale);
    }];


    [self.unpasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(self.containerView.mas_top).offset(15*kHeightScale);
        make.left.mas_equalTo(self.oldLabel.mas_right).offset(15*kWidthScale);
        make.size.mas_equalTo(CGSizeMake(250*kWidthScale, 40*kHeightScale));
        make.centerY.mas_equalTo(self.passaginLable.mas_centerY);
    }];
    
    [self.importLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.containerView.mas_right).offset(-5);
        make.top.mas_equalTo(self.containerView.mas_bottom).offset(25);
    }];
    
    [self.forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.importLabel.mas_left).offset(-1);
        make.centerY.mas_equalTo(self.importLabel.mas_centerY);
    }];
    


    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.unpasswordTF.mas_bottom).offset(8);
        make.left.mas_equalTo(self.passaginLable.mas_left);
        make.height.mas_equalTo(25);


    }];


    //创建账户按钮
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.containerView.mas_bottom).offset(77*kHeightScale);

        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(360*kWidthScale, 44*kHeightScale));

    }];
//
//
//
    
}



-(void)tapAction1{
    
    InventorViewController *inVc = [[InventorViewController alloc]init];
    
    [self.navigationController pushViewController:inVc animated:YES];
    
    
}


-(void)loginGo{
     [self hideKeyboard];
   
    if (self.oldPasswordTF.text.length>0&&self.passwordTF.text.length>0 && self.unpasswordTF.text.length>0) {
        if ([self.oldPasswordTF.text isEqualToString:[MoneyPacketManager moneyAcctountManager].passWored]) {
            if ([self.passwordTF.text isEqualToString:self.unpasswordTF.text]) {
                
                if (![self.oldPasswordTF.text isEqualToString:self.unpasswordTF.text]) {
                    
                    if (self.unpasswordTF.text.length >=8 && self.passwordTF.text.length>=8) {
                        
                        [MoneyPacketManager moneyAcctountManager].passWored = self.unpasswordTF.text;
                        
                        UIView *view = [[UIView alloc]init];
                        view.frame = CGRectMake(0, 0, kScreenW, kScreenH);
                        
                        UIImageView *changeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:NSLocalizedStringFromTable(@"Modify",@"Internation", nil)]];
                         changeImageView.frame = CGRectMake(0, STATUS_GAP, kScreenW, kScreenH-STATUS_GAP);
                        
                        //                    view.backgroundColor = [UIColor yellowColor];
                        [view addSubview:changeImageView];
                        [self.view addSubview:view];
                        
                        //设置动画
                        CATransition * transion = [CATransition animation];
                        
                        transion.type = @"push";//设置动画方式
                        transion.subtype = @"fromRight";//设置动画从那个方向开始
                        [view.layer addAnimation:transion forKey:nil];//给Label.layer 添加动画 //设置延时效果
                        
                        //不占用主线程
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
                            [view removeFromSuperview];
                            [self.navigationController popViewControllerAnimated:YES];
                        });//这句话的意思是
                        
                        //                    [self.navigationController popViewControllerAnimated:YES];
                        
//                        "No less than 8 digits" = "密码必须大于8位";
//                        "The current password is incorrect. Please enter it again" ="当前密码错误，请重新输入";
//                        "The new password cannot match the old password"="新密码不能与旧密码一致";
//                        "The new password is inconsistent Please enter it again"="新密码不一致，请重新输入"
                        
                    }else{
                        
                        self.errorLabel.text = NSLocalizedStringFromTable(@"No less than 8 digits",@"Internation", nil);
                    }
                    
                    
                }else{
                    
                    NSLog(@"新密码不能与旧密码一致");
                    self.errorLabel.text = NSLocalizedStringFromTable(@"The new password cannot match the old password",@"Internation", nil);
                    
                }
                
                
            }else{
                 NSLog(@"新密码不一致，请重新输入");
                
                self.errorLabel.text = NSLocalizedStringFromTable(@"The new password is inconsistent Please enter it again",@"Internation", nil);
            }
            
        }else{
            
            
            NSLog(@"输入的旧密码不对");
          self.errorLabel.text = NSLocalizedStringFromTable(@"The current password is incorrect. Please enter it again",@"Internation", nil);
        }
        
    }else{
        
        
        self.errorLabel.text = NSLocalizedStringFromTable(@"Inputempty2",@"Internation", nil);
    }
    
}






-(UILabel *)yueLabel{
    if (!_yueLabel) {
        _yueLabel = [[UILabel alloc]init];
    }
    
    return _yueLabel;
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}


- (UITextField *)oldPasswordTF{
    if (!_oldPasswordTF) {
        _oldPasswordTF = [[UITextField alloc] init];
    }
    return _oldPasswordTF;
}


- (UITextField *)passwordTF{
    if (!_passwordTF) {
        _passwordTF = [[UITextField alloc] init];
    }
    return _passwordTF;
}

- (UITextField *)unpasswordTF{
    if (!_unpasswordTF) {
        _unpasswordTF = [[UITextField alloc] init];
    }
    return _unpasswordTF;
}


- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _loginBtn;
}










#pragma mark - Pravite Method
- (void)hideKeyboard{
    
    [self.view endEditing:YES];
}


#pragma mark - Event response
- (void)tapAction{
    
    [self hideKeyboard];
}




#pragma mark - Delegate methods

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    return NO;
//}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self hideKeyboard];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self hideKeyboard];
}


-(void)dealloc{
    
    NSLog(@"页面销毁");
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
