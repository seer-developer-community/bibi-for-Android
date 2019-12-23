//
//  LoginViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/23.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "LoginViewController.h"
#import "NoteViewController.h"
#import "BitsharesWalletObject.h"
#import "BaseConfig.h"
#import "BrainKey.h"
#import "TestMineViewController.h"
#import "ProtocalViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *accountLine;
@property (nonatomic, strong) UIView *passwordLine;

//账号
@property(nonatomic,strong)UILabel *accountLabel;
//密码
@property(nonatomic,strong)UILabel *ferLabel;
//再次密码
@property(nonatomic,strong)UILabel *passaginLable;


//手续费
@property(nonatomic,strong)UILabel *fertwoLabel;

//余额
@property(nonatomic,strong)UILabel *danqianyuer;


//错误提示
@property(nonatomic,strong)UILabel *errorLabel;

//@property (nonatomic,strong) BitsharesWalletObject *wallet;

@property (nonatomic,assign) BOOL connected;


//记住的图标
@property(nonatomic,strong)UIImageView *jinIconImage;

//文字
@property(nonatomic,strong)UILabel * remmberlabel;

//同意
@property(nonatomic,strong)UIButton *agreementBnt;

//服务文字
@property(nonatomic,strong)UILabel *btnlabel;

//点击服务
@property(nonatomic,strong)UILabel *severBnt;

@end

@implementation LoginViewController



- (void)viewDidLoad {
    [super viewDidLoad];
     [BaseConfig setPrefix:@"SEER"];
    [self setTopView];
    
//    [self setupURL];

}




//
//-(void)setupURL{
//    _wallet = [[BitsharesWalletObject alloc]initWithChainId:@"cea4fdf4f5c2278f139b22e782b308928f04008b0fc2c79970a58974a2a28f91" prefix:@"SEER"];
//
//    [self needConnect];
//
//    __weak typeof(self) weakSelf = self;
//
//    _wallet.connectStatusChange = ^(WebsocketConnectStatus status) {
//        weakSelf.connected = status == WebsocketConnectStatusConnected;
//        NSLog(@"status change");
//    };
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // 阻塞当前方法，使方法进入等待
//        while (!self.connected) {}
//        // 当连接成功后发送消息
////        [self clicked];
//    });
//
//
////    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
//
//
//}
//
//
//- (void)needConnect {
//    [_wallet connectUrl:@"ws://39.105.189.224/ws" timeOut:10 connectedError:^(NSError *error) {
//        NSLog(@"%@",error.description);
//
//        [self needConnect];
//    }];
//}



-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    
    self.navigationController.navigationBarHidden = YES;
    self.navView.title = NSLocalizedStringFromTable(@"Create Wallet",@"Internation", nil);
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick)
                         forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
    
    [self setupUI];
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
    
    //    //创建钱包
    //    "Usernameing" = "用户名";
    //    "no less than 6" = "字母和数字组合不少于6位";
    //    "no less than 8 " = "不少于8位字符";
    //    "Repeat password" = "请再次输入密码";
    //    "Please remember" = "请牢记钱包密码,币比不储存密码,也无法帮您找回";

    //用户名
    UILabel * accountLabel = [[UILabel alloc]init];
    accountLabel.text = NSLocalizedStringFromTable(@"Usernameing",@"Internation", nil);
   
    accountLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7];
    accountLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    self.accountLabel = accountLabel;
    [self.containerView addSubview:accountLabel];
    
    /** 设置账号输入 */
    self.accountTF.placeholder = NSLocalizedStringFromTable(@"no less than 6",@"Internation", nil);
    self.accountTF.tintColor = UIColorFromHexValue(0x444444);
    self.accountTF.textColor = UIColorFromHexValue(0x444444);
    self.accountTF.font = [UIFont systemFontOfSize:13.f];
    //    self.accountTF.leftViewMode = UITextFieldViewModeAlways;
//    self.accountTF.backgroundColor =[UIColor redColor];
    self.accountTF.delegate = self;
    self.accountTF.keyboardType=UIKeyboardTypeDefault;
    self.accountTF.keyboardType = UIKeyboardTypeASCIICapable;
    self.accountTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.accountTF setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    //    UIImageView *accountImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kTFLeftW, kTFLeftH)];
    //    accountImageV.contentMode = UIViewContentModeLeft;
    //    accountImageV.image = [UIImage imageNamed:@"login_account"];
    //    self.accountTF.leftView = accountImageV;
    [self.containerView addSubview:self.accountTF];
    
    //    //账号的下划线
    UIView *accountLine = [[UIView alloc] init];
    accountLine.backgroundColor = UIColorFromHexValue(0xC2C2C2);
    self.accountLine = accountLine;
    [self.containerView addSubview:accountLine];
    
    //密码
    
    UILabel *ferLabel = [[UILabel alloc]init];
    ferLabel.text = NSLocalizedStringFromTable(@"Password",@"Internation", nil);
    ferLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7];
    ferLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    self.ferLabel = ferLabel;
    [self.containerView addSubview:ferLabel];
    
    //密码
    self.passwordTF.placeholder = NSLocalizedStringFromTable(@"no less than 8",@"Internation", nil);
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
    passaginLable.text = NSLocalizedStringFromTable(@"Buttonsure1",@"Internation", nil);
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
    
//    //隐私协议跳转
//    UILabel *agreeBnt = [[UILabel alloc]init];
//    agreeBnt.text =@"服务及隐私条约";
//    agreeBnt.textColor = UIColorFromHexValue(0x2C86E3);
//    agreeBnt.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
//    self.severBnt = agreeBnt;
//
//    agreeBnt.userInteractionEnabled=YES;
//    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
//    
//    [agreeBnt addGestureRecognizer:labelTapGestureRecognizer];
//    
//   
//    [self.view addSubview:self.severBnt];
//    
//    //文字
//    UILabel * btnlabel = [[UILabel alloc]init];
//    btnlabel.text = @"我已阅读并同意";
//    btnlabel.textColor =UIColorFromHexValue(0x444444);
//    btnlabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
//    self.btnlabel = btnlabel;
//    [self.view addSubview:self.btnlabel];
//    
//    //同意按钮
    UIButton *agreementBnt = [[UIButton alloc]init];
    [agreementBnt setImage:[UIImage imageNamed:@"servier_iconNormar"] forState:UIControlStateNormal];
    [agreementBnt setImage:[UIImage imageNamed:@"servier_iconHiglet"] forState:UIControlStateSelected];
    agreementBnt.selected =YES;
    self.agreementBnt = agreementBnt;
//
//    [self.agreementBnt addTarget:self action:@selector(agreeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreementBnt];
//
    
    //错误提示
    self.errorLabel =[[UILabel alloc]init];
    _errorLabel.numberOfLines = 0;
    _errorLabel.textColor = [UIColor redColor];
    _errorLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    _errorLabel.text =@"";
    [self.view addSubview:_errorLabel];
    
    
    
    
    
    //创建钱包
    [self.loginBtn setTitle:NSLocalizedStringFromTable(@"Create Wallet",@"Internation", nil) forState:UIControlStateNormal];
    [self.loginBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    InQusetion.backgroundColor =  UIColorFromHexValue(0x81d8cf);
//    self.loginBtn.layer.backgroundColor = [[UIColor colorWithRed:
//                                            104.0f/255.0f green:184.0f/255.0f blue:247.0f/255.0f alpha:1.0f]
//                                           CGColor];
//    
    [self.loginBtn setGradientBackgroundWithColors:@[UIColorFromHexValue(0x2A7DDF),UIColorFromHexValue(0x38AFF4)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    self.loginBtn .layer.cornerRadius = 20;
    self.loginBtn .layer.masksToBounds = NO;
    [self.loginBtn  addTarget:self action:@selector(loginGo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn ];
    
    
    UILabel *remmberlabel = [[UILabel alloc]init];
    remmberlabel.text = NSLocalizedStringFromTable(@"Please remember",@"Internation", nil);
    remmberlabel.textColor = UIColorFromHexValue(0x444444);
    remmberlabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    remmberlabel.numberOfLines = 0;
    self.remmberlabel = remmberlabel;
    [self.view addSubview:remmberlabel];
  
    
    UIImageView *iconImgeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_tragter_icon"]];
    self.jinIconImage = iconImgeView;
    [self.view addSubview:iconImgeView];

    [self uplayout];
}


-(void)uplayout{
    
    //背景
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom).offset(90*kHeightScale);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(340*kWidthScale, 160*kHeightScale));
        
    }];
    
    //用户名
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.mas_equalTo(20*kWidthScale);
        make.top.mas_equalTo(20*kHeightScale);
        
    }];
    
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(self.containerView.mas_top).offset(15*kHeightScale);
        make.left.mas_equalTo(self.accountLabel.mas_right).offset(15*kWidthScale);
        make.size.mas_equalTo(CGSizeMake(250*kWidthScale, 50*kHeightScale));
        make.centerY.mas_equalTo(self.accountLabel.mas_centerY);
    }];
    
    [self.accountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-1.f);
        make.top.mas_equalTo(self.accountTF.mas_bottom);
        make.height.mas_equalTo(.8f);
    }];
    
    // 密码：
    
    [self.ferLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.accountLabel.mas_left);
        make.top.mas_equalTo(self.accountLine.mas_bottom).offset(20*kHeightScale);
        
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(self.containerView.mas_top).offset(15*kHeightScale);
        make.left.mas_equalTo(self.accountLabel.mas_right).offset(15*kWidthScale);
        make.size.mas_equalTo(CGSizeMake(250*kWidthScale, 50*kHeightScale));
        make.centerY.mas_equalTo(self.ferLabel.mas_centerY);
    }];
    
    
    [self.passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-1.f);
        make.top.mas_equalTo(self.passwordTF.mas_bottom);
        make.height.mas_equalTo(.8f);
    }];
    
    //再次输入密码
    
    [self.passaginLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.accountLabel.mas_left);
        make.top.mas_equalTo(self.passwordLine.mas_bottom).offset(20*kHeightScale);
        
    }];
    
    
    [self.unpasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(self.containerView.mas_top).offset(15*kHeightScale);
        make.left.mas_equalTo(self.self.accountLabel.mas_right).offset(15*kWidthScale);
        make.size.mas_equalTo(CGSizeMake(250*kWidthScale, 50*kHeightScale));
        make.centerY.mas_equalTo(self.passaginLable.mas_centerY);
    }];
    
    
    //服务隐私
    [self.severBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.containerView.mas_right);
        make.top.mas_equalTo(self.containerView.mas_bottom).offset(15);
        
    }];
    
    // 同意阅读
    [self.btnlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.severBnt.mas_left);
        make.centerY.mas_equalTo(self.severBnt.mas_centerY);
    }];
    
//    //同意的按钮
//    [self.agreementBnt mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.btnlabel.mas_left).offset(-5);
//        make.centerY.mas_equalTo(self.btnlabel.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(13, 13));
//    }];
    
    
    
    //错误
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.unpasswordTF.mas_bottom).offset(15);
        make.left.mas_equalTo(self.passaginLable.mas_left);
        make.height.mas_equalTo(25);
        
    }];
    
    
    //创建账户按钮
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.containerView.mas_bottom).offset(60*kHeightScale);
        
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(360*kWidthScale, 44*kHeightScale));
        
    }];
    
    
    [self.remmberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(23);
        make.left.mas_equalTo(30);
    }];
    
    [self.jinIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.remmberlabel.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.remmberlabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];

}



-(void)agreeClick:(UIButton *)sender{
    if (sender.selected) {
        sender.selected =NO;
    }else{
        
        sender.selected = YES;
    }
    
    
    
}

//"The account cannot contain Chinese" ="账号不能包含中文";
//"Accounts cannot contain uppercase characters" = "账号不能含大写字符";
//"The account already exists" = "账号已经存在";
//"The passwords do not match" ="两次密码不一致";
//"Accounts must be alphanumeric" ="账号必须是字母数字组合";
//"The user name must start with a lowercase letter" = "用户名首位必须是小写字母";

-(void)loginGo{
    if (self.accountTF.text.length>0) {
        for (int i = 0; i<self.accountTF.text.length; i++) {
            char commitChar = [self.accountTF.text characterAtIndex:i];
            NSString *temp = [self.accountTF.text substringWithRange:NSMakeRange(i,1)];
            const char *u8Temp = [temp UTF8String];
            if (3==strlen(u8Temp)){
                self.errorLabel.text = NSLocalizedStringFromTable(@"The account cannot contain Chinese",@"Internation", nil);
                NSLog(@"字符串中含有中文");
                return;
            }else if((commitChar>64)&&(commitChar<91)){
                self.errorLabel.text = NSLocalizedStringFromTable(@"Accounts cannot contain uppercase characters",@"Internation", nil);
                NSLog(@"字符串中含有大写英文字母");
                return;
            }
        }
        
        if (self.accountTF.text.length>=6) {
            
            if ([self isEnglishFirst:self.accountTF.text]) {
                
                if ([self judgePassWordLegal:self.accountTF.text]) {
                    
                    if (self.passwordTF.text.length>=8) {

                        if ([self.unpasswordTF.text isEqualToString:self.passwordTF.text]) {

                            if (!self.agreementBnt.selected) {
                                //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"您没有接受了协议" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                //        [alert show];
                                self.errorLabel.text = @"请阅读并同意相关服务及隐私条约";
                                return;
                            }else{
                                
                                [[BitsharesWalletObject BitsharesWalletObjectManager] getAccount:self.accountTF.text success:^(AccountObject *result) {
                                    
                                    if (!result.name) {
                                        
                                        //                                    TestMineViewController *vc = [[TestMineViewController alloc]init];
                                        //
                                        //                                    [self.navigationController pushViewController:vc animated:YES];
                                        
                                        [MoneyPacketManager moneyAcctountManager].userName = self.accountTF.text;
                                        [MoneyPacketManager moneyAcctountManager].passWored = self.passwordTF.text;
                                        
                                        NoteViewController *vc = [[NoteViewController alloc]init];
                                        
                                        [self.navigationController pushViewController:vc animated:YES];
                                        
                                    }else{
                                        
                                        self.errorLabel.text = NSLocalizedStringFromTable(@"The account already exists",@"Internation", nil);
                                    }
                                    
                                } error:^(NSError *error) {
                                    
                                }];
                            }

                          


                        }else{


                           self.errorLabel.text = NSLocalizedStringFromTable(@"The passwords do not match",@"Internation", nil);
                        }

                    }else{


                        self.errorLabel.text = NSLocalizedStringFromTable(@"no less than 8",@"Internation", nil);
                    }
//
                 
                }else{
                    
                    
                    self.errorLabel.text = NSLocalizedStringFromTable(@"Accounts must be alphanumeric",@"Internation", nil);
                    
                }



            }else{
                 self.errorLabel.text = NSLocalizedStringFromTable(@"The user name must start with a lowercase letter",@"Internation", nil);
//                self.errorLabel.text = @"用户名首位必须是字母";
            }
            
            
          
        }else{
           
            self.errorLabel.text =@"用户名不能少于6位";
            self.errorLabel.text = NSLocalizedStringFromTable(@"no less than 6",@"Internation", nil);
        }
        
    }else{
        
//        User or Password cannot be empty
//        self.errorLabel.text = @"用户密码不能为空";
        self.errorLabel.text = NSLocalizedStringFromTable(@"User or Password cannot be empty",@"Internation", nil);
    }
    
    
    
    
    
    
    
    
    
    
    
//    if ([self judgePassWordLegal:self.accountTF.text]) {
//
//        if (self.accountTF.text.length>=6) {
//            if (self.passwordTF.text.length>=8) {
//                if ([self.passwordTF.text isEqualToString:self.unpasswordTF.text]) {
//
//                    if ([self isEnglishFirst:self.accountTF.text]) {
////                        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
////                        [accountDefaults setObject:self.accountTF.text forKey:@"NCUserDefaultNameKey"];
////                        [accountDefaults setObject:self.passwordTF.text forKey:@"NCUserDefaultPasswordKey"];
////                        [accountDefaults synchronize];

//
//                        // 查询账户
//
//                        [self.wallet getAccount: [MoneyPacketManager moneyAcctountManager].userName success:^(AccountObject *result) {
//                            if (!result.name) {
////                                TestMineViewController *vc = [[TestMineViewController alloc]init];
////
////                                [self.navigationController pushViewController:vc animated:YES];
//                                                        NoteViewController *vc = [[NoteViewController alloc]init];
//
//                                                        [self.navigationController pushViewController:vc animated:YES];
//                            }else{
//                                self.errorLabel.text = @"账户已经存在";
//                            }
//
//
//                        } error:^(NSError *error) {
//
//
//                        }];
//
//
//
////                        NoteViewController *vc = [[NoteViewController alloc]init];
////
////                        [self.navigationController pushViewController:vc animated:YES];
//                    }else{
//
//                        self.errorLabel.text =@"注册的首字母不是英文";
//                        NSLog(@"注册的首字母不是英文");
//                    }
//
//
//
//
//                }else{
//                    self.errorLabel.text = @"两次密码不一样";
//
//                    NSLog(@"两次密码不一样");
//
//                }
//
//
//            }else{
//
//                self.errorLabel.text = @"密码少于8位";
//                NSLog(@"密码少于8位");
//
//            }
//
//
//
//        }else{
//
//            self.errorLabel.text = @"账户名小于6位";
//            NSLog(@"账户名小于6位");
//        }
//
//
//    }else{
//
//        self.errorLabel.text =@"账号必须是字母数字组合";
//        NSLog(@"账号必须是字母数字组合");
//    }
////
    
    
}








//是否以英文开头
- (BOOL)isEnglishFirst:(NSString *)str {
    NSString *regular = @"^[A-Za-z].+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];

    if ([predicate evaluateWithObject:str] == YES){
        return YES;
    }else{
        return NO;
    }
    
}



//判断字符串包含数字和字母

-(BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,30}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
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


- (UITextField *)accountTF{
    if (!_accountTF) {
        _accountTF = [[UITextField alloc] init];
    }
    return _accountTF;
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




-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
//    UILabel *label=(UILabel*)recognizer.view;
    
    NSLog(@"被点击了");
    ProtocalViewController *protocalVC = [[ProtocalViewController alloc]init];
    
    [self.navigationController pushViewController:protocalVC animated:YES];
    
    
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

}

@end
