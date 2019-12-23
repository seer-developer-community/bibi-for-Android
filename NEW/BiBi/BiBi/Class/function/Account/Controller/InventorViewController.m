//
//  InventorViewController.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/2.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "InventorViewController.h"
#import "UITextView+Placeholder.h"
#import "UploadParams.h"
#import "UploadBaseModel.h"
#import "CallBackModel.h"
#import "BitsharesWalletObject.h"
#import "ProtocalViewController.h"
@interface InventorViewController ()<UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIView *accountLine;

@property (nonatomic, strong) UIView *passwordLine;
//账号
@property(nonatomic,strong)UILabel *accountLabel;
//密码
@property(nonatomic,strong)UILabel *ferLabel;
//再次密码
@property(nonatomic,strong)UILabel *passaginLable;

//错误提示
@property(nonatomic,strong)UILabel *errorLabel;

//文字
@property(nonatomic,strong)UILabel * remmberlabel;

//同意
@property(nonatomic,strong)UIButton *agreementBnt;

//服务文字
@property(nonatomic,strong)UILabel *btnlabel;

//点击服务
@property(nonatomic,strong)UILabel *severBnt;



//@property (nonatomic,strong) BitsharesWalletObject *wallet;

@property (nonatomic,assign) BOOL connected;

//全局arry
@property(nonatomic,strong)NSArray *reuslt;

@end

@implementation InventorViewController

-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    
//    [MoneyPacketManager attemptDealloc];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTopView];
    
//    [self setupURL];
}


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
//        //        [self clicked];
//    });
//
//
//    //    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
//
//
//}
//
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
    self.navView.title = NSLocalizedStringFromTable(@"Import Wallet",@"Internation", nil);
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick)
                         forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
    
    [self setupUI];
}


-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

-(void)setupUI{
    
    
    
    //初始化手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    /** 设置账号输入 */
//    self.textview.placeholder = @"输入助记词，用空格分割";
    
    self.textview.tintColor = UIColorFromHexValue(0x444444);
    self.textview.textColor = UIColorFromHexValue(0x444444);
    self.textview.font = [UIFont systemFontOfSize:13.f];
    self.textview.backgroundColor = [UIColor whiteColor];
    self.textview.placeHolder =  NSLocalizedStringFromTable(@"Enter mnemonic words, separated by spaces",@"Internation", nil);
    //    self.accountTF.leftViewMode = UITextFieldViewModeAlways;
    //    self.accountTF.backgroundColor =[UIColor redColor];
//    self.textview.delegate = self;
    self.textview.keyboardType=UIKeyboardTypeDefault;
    self.textview.keyboardType = UIKeyboardTypeASCIICapable;
    self.textview.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    self.textview.layer.cornerRadius = 10;
    [self.textview setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.textview.layer.cornerRadius = 10;
    [self.view addSubview:self.textview];
    
    
    
    
    /** 设置内容视图 */
    
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.layer.cornerRadius = 6.7;
    [self.view addSubview:self.containerView];
    
    
    
    //密码
    
    UILabel *ferLabel = [[UILabel alloc]init];
    ferLabel.text =  NSLocalizedStringFromTable(@"Password",@"Internation", nil);
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
    self.unpasswordTF.placeholder = NSLocalizedStringFromTable(@"Repeat password",@"Internation", nil);
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
    
    //错误提示
    self.errorLabel =[[UILabel alloc]init];
    _errorLabel.numberOfLines = 0;
    _errorLabel.textColor = [UIColor redColor];
    _errorLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    _errorLabel.text =@"";
    [self.view addSubview:_errorLabel];
    
    
    //创建钱包
    [self.loginBtn setTitle:NSLocalizedStringFromTable(@"Import Wallet",@"Internation", nil) forState:UIControlStateNormal];
    [self.loginBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    InQusetion.backgroundColor =  UIColorFromHexValue(0x81d8cf);
    [self.loginBtn setGradientBackgroundWithColors:@[UIColorFromHexValue(0x2A7DDF),UIColorFromHexValue(0x38AFF4)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    self.loginBtn .layer.cornerRadius = 20;
    self.loginBtn .layer.masksToBounds = NO;
    [self.loginBtn  addTarget:self action:@selector(loginGo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
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
//    UIButton *agreementBnt = [[UIButton alloc]init];
//    [agreementBnt setImage:[UIImage imageNamed:@"servier_iconNormar"] forState:UIControlStateNormal];
//    [agreementBnt setImage:[UIImage imageNamed:@"servier_iconHiglet"] forState:UIControlStateSelected];
//    agreementBnt.selected =YES;
//    self.agreementBnt = agreementBnt;
//    
//    [self.agreementBnt addTarget:self action:@selector(agreeClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:agreementBnt];
//    
    
    
    
    [self uplayout];
}


//隐私同意
-(void)agreeClick:(UIButton *)sender{
    if (sender.selected) {
        sender.selected =NO;
    }else{
        
        sender.selected = YES;
    }
    
    
    
}

//跳转

-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
    //    UILabel *label=(UILabel*)recognizer.view;
    
    NSLog(@"被点击了");
    ProtocalViewController *protocalVC = [[ProtocalViewController alloc]init];
    
    [self.navigationController pushViewController:protocalVC animated:YES];
    
    
}



//布局
-(void)uplayout{
    
    [self.textview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom).offset(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(175);
    }];
    
    //视图初始化
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textview.mas_bottom).offset(20);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(110);
        
    }];
    
    // 密码：
    
    [self.ferLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(20*kHeightScale);
        
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.ferLabel.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(250, 50));
        make.centerY.mas_equalTo(self.ferLabel.mas_centerY);
    }];
    
    
    [self.passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-1.f);
        make.top.mas_equalTo(self.passwordTF.mas_bottom);
        make.height.mas_equalTo(.3f);
    }];
    
    //再次输入密码
    
    [self.passaginLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.ferLabel.mas_left);
        make.top.mas_equalTo(self.passwordLine.mas_bottom).offset(20);
        
    }];
    
    
    [self.unpasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(self.containerView.mas_top).offset(15*kHeightScale);
        make.left.mas_equalTo(self.ferLabel.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(250, 50));
        make.centerY.mas_equalTo(self.passaginLable.mas_centerY);
    }];
    
    
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.unpasswordTF.mas_bottom).offset(15);
        make.left.mas_equalTo(self.passaginLable.mas_left);
        make.height.mas_equalTo(25);
        
        
    }];
    
    
    //创建账户按钮
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.containerView.mas_bottom).offset(77*kHeightScale);
        
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(360*kWidthScale, 44*kHeightScale));
        
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
    
    //同意的按钮
    [self.agreementBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.btnlabel.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.btnlabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
//     -------DURIAN SIRREE VIREMIC FLUTING WORDED NICHE AW TORCH SAGATHY PHOCA SCABBY TOGUE JUDO FINNED CADDOW WAGGLE------
//     -------DURIAN SIRREE VIREMIC FLUTING WORDED NICHE AW TORCH SAGATHY PHOCA SCABBY TOGUE JUDO FINNED CADDOW WAGGLE------
}

//
//    if (!self.agreementBnt.selected) {
//        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"您没有接受了协议" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        //        [alert show];
//        self.errorLabel.text = @"请阅读并同意相关服务及隐私条约";
//        return;
//    }

-(void)loginGo{
    
    NSLog(@"-------%@------",self.textview.text);

    if (self.textview.text.length<=0) {
        self.errorLabel.text = NSLocalizedStringFromTable(@"Mnemonic words cannot be empty",@"Internation", nil);
        return;
    }
    if (![self.passwordTF.text isEqualToString:self.unpasswordTF.text]) {
        self.errorLabel.text = NSLocalizedStringFromTable(@"The passwords do not match",@"Internation", nil);
        return;
    }
    if (self.passwordTF.text.length<8 &&self.unpasswordTF.text.length<8) {
        self.errorLabel.text = NSLocalizedStringFromTable(@"no less than 8",@"Internation", nil);
        return;
    }
    NSString *str1 = [self.textview.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    BrainKey *brainkey = [[BrainKey alloc]init];
    brainkey= [[BitsharesWalletObject BitsharesWalletObjectManager] deriveKeyWithBrainKey:str1];
    BrainKey *ownerBrainkey = [[BrainKey alloc]init];
    ownerBrainkey= [[BitsharesWalletObject BitsharesWalletObjectManager] deriveKeyWithOwnerBrainKey:str1];
    
    NSLog(@"str---%@",str1);
    [MoneyPacketManager moneyAcctountManager].passWored = self.unpasswordTF.text;
    [MoneyPacketManager moneyAcctountManager].puliKeyStr =[NSString stringWithFormat:@"%@",brainkey.pubKey ];
    [MoneyPacketManager moneyAcctountManager].priveKeyStr = [NSString stringWithFormat:@"%@",brainkey.priKey];
    
    //测试网
    
//    [MoneyPacketManager moneyAcctountManager].puliKeyStr=@"SEER6SmSEJuzMfnWU9RnL7LfbJUc7Nf4rKy4B8JUXXGhGf12htanMd";
//    [MoneyPacketManager moneyAcctountManager].priveKeyStr =@"5KcEBuPJJvizkCf9fJhHNV4Mwz59nvx4HBWEvPG3hBjZjiq2Dvb";
    [MoneyPacketManager moneyAcctountManager].ownpriveKeyStr = [NSString stringWithFormat:@"%@",ownerBrainkey.priKey];
    
    [[BitsharesWalletObject BitsharesWalletObjectManager] getAccountName:[NSString stringWithFormat:@"%@", [MoneyPacketManager moneyAcctountManager].puliKeyStr]success:^(NSArray *result) {
        
        
        if ([result[0]isEqual:@[]]) {
            self.errorLabel.text = NSLocalizedStringFromTable(@"Mnemonic is wrong",@"Internation", nil);
            
        }else{
            
            [self getAccountName:result[0][0]];
            
            
            
        }
        
        
        
        
    } error:^(NSError *error) {
        
        
    }];
    
    
    
//    if ([self.passwordTF.text isEqualToString:self.unpasswordTF.text]) {
//
//        if (self.passwordTF.text.length>=8 &&self.unpasswordTF.text.length>=8) {
//
//            if (self.textview.text) {
////                NSString *str1 = self.textview.text;
//                NSString *str1 = [self.textview.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//
//                BrainKey *brainkey = [[BrainKey alloc]init];
//
//                brainkey= [self.wallet deriveKeyWithBrainKey:str1];
//
//                NSString *str = [NSString stringWithFormat:@"%@",brainkey.pubKey ];
//
//
//                [MoneyPacketManager moneyAcctountManager].passWored = self.unpasswordTF.text;
//                [MoneyPacketManager moneyAcctountManager].puliKeyStr =[NSString stringWithFormat:@"%@",brainkey.pubKey ];
//                [MoneyPacketManager moneyAcctountManager].priveKeyStr = [NSString stringWithFormat:@"%@",brainkey.priKey];
//
//
//                UploadParams *uploadParams = [[UploadParams alloc] init];
//
//                uploadParams.methodName = @"get_key_references";
//
//                uploadParams.totalParams = @[@[str]];
//
//                CallBackModel *callBackModel = [[CallBackModel alloc] init];
//                  __weak typeof(self) weakSelf = self;
//
//                callBackModel.successResult = ^(NSArray * resultfrom) {
//                    NSLog(@"%@",resultfrom);
//
//                    if ([resultfrom[0]isEqual:@[]]) {
//
//                         self.errorLabel.text = @"助记词不对";
//
//                    }else{
//
//                        [weakSelf.wallet getAccount:resultfrom[0][0] success:^(AccountObject *result) {
//
//
//                            if (!result.name) {
//                            self.errorLabel.text = @"助记词不对";
//                            }else{
//                                NSLog(@"laod new name:%@",result.name);
//                                [MoneyPacketManager moneyAcctountManager].userName = result.name;
//                                [MoneyPacketManager moneyAcctountManager].identifier =[NSString stringWithFormat:@"%@",result.identifier];
//                                [MoneyPacketManager moneyAcctountManager].isLogin = YES;
//                                [MoneyPacketManager moneyAcctountManager].isHiddenImage = YES;
//                                [MoneyPacketManager moneyAcctountManager].identifier = resultfrom[0][0];
//                                [[MoneyPacketManager moneyAcctountManager] saveUserData];
//                                [self.navigationController popToRootViewControllerAnimated:YES];
////                                dispatch_async(dispatch_get_main_queue(), ^{
////
////                                });
//
//                            }
//
//
//                        } error:^(NSError *error) {
//
//
//                          self.errorLabel.text = @"网络连接错误";
//                        }];
//
//
//
//                    }
//
//
//                };
//
//                [_wallet sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
//
//            }else{
//
//
//
//                self.errorLabel.text = @"助记词不能为空";
//            }
//
//
//        }else{
//
//
//                 self.errorLabel.text = @"密码不能小于8位";
//        }
//
//
//
//    }else{
//
//
//
//        self.errorLabel.text = @"两次密码不一致";
//    }
//





    
    
//    if (self.passwordTF.text.length>=8 &&self.unpasswordTF.text.length>=8) {
//
//        if ([self.passwordTF.text isEqualToString:self.unpasswordTF.text]) {
//
//
//            if (self.textview.text) {
//
//                BrainKey *brainkey = [[BrainKey alloc]init];
//
//                brainkey= [self.wallet deriveKeyWithBrainKey:self.textview.text];
//
//                NSString *str = [NSString stringWithFormat:@"%@",brainkey.pubKey ];
//
//
//                UploadParams *uploadParams = [[UploadParams alloc] init];
//
//                uploadParams.methodName = @"get_key_references";
//
//                uploadParams.totalParams = @[@[str]];
//
//                CallBackModel *callBackModel = [[CallBackModel alloc] init];
//
//                callBackModel.successResult = ^(NSArray * result) {
//
//                    self.reuslt = result;
//
//
//                    if ([self.reuslt[0] isEqual:@[]]) {
//
//                     self.errorLabel.text = @"助记词不对";
//
//                    }else{
//
//
//                        [self->_wallet getAccount:self.reuslt[0][0] success:^(AccountObject *result) {
//                            if (!result.name) {
//                                //                                self.errorLabel.text = @"助记词不对";
//                            }else{
//
//                                NSLog(@"%@",result.name);
//
//                            }
//
//                        } error:^(NSError *error) {
//
//                        }];
//
//                    }
//
//
//
//                };
//
//                [_wallet sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
//
//
////
//
////
////
//
//
//            }else{
//
//
//                self.errorLabel.text = @"助记词不对";
//            }
//
//        }else{
//
//            self.errorLabel.text =@"密码不一致";
//        }
//
//    }else{
//
//        self.errorLabel.text =@"密码小于8位";
//    }
//
//
    
   
   
    
   
}



-(void)getAccountName:(NSString *)identifier{
    
    [[BitsharesWalletObject BitsharesWalletObjectManager] getAccount:identifier success:^(AccountObject *result) {
        [MoneyPacketManager moneyAcctountManager].userName = result.name;
        [MoneyPacketManager moneyAcctountManager].identifier =[NSString stringWithFormat:@"%@",result.identifier];
//        [MoneyPacketManager moneyAcctountManager].surplus = 
        [MoneyPacketManager moneyAcctountManager].isLogin = YES;
        [MoneyPacketManager moneyAcctountManager].isHiddenImage = YES;
        [MoneyPacketManager moneyAcctountManager].identifier =identifier;
        [[MoneyPacketManager moneyAcctountManager] saveUserData];
        [self.navigationController popToRootViewControllerAnimated:YES];
//        self.connected = NO;
        
    } error:^(NSError *error) {
        
    }];
}




-(UITextView*)textview{
    
    if (!_textview) {
        _textview = [[UITextView alloc]init];
    }
    
    return _textview;
}


- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
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
