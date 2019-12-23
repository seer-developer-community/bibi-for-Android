//
//  CashOutViewController.m
//  BiBi
//
//  Created by 武建斌 on 2019/4/26.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "CashOutViewController.h"
#import "PrivateKey.h"
#import "PublicKey.h"
#import "WuLoadingView.h"
#define EPSILON 1e-6
@interface CashOutViewController ()<UITextFieldDelegate>
//两条分割线
@property (nonatomic, strong) UIView *accountLine;
@property (nonatomic, strong) UIView *passwordLine;

//提现地址
@property(nonatomic,strong)UILabel *accountLabel;

//转账金额
@property(nonatomic,strong)UILabel *ferLabel;

//手续费
@property(nonatomic,strong)UILabel *fertwoLabel;

//账户预计到账金额字
@property(nonatomic,strong)UILabel *succecdMoneyLabel;

//预计到账金额全部
@property(nonatomic,strong)UILabel *out_monrylabel;

//余额
@property(nonatomic,strong)UILabel *danqianyuer;

//错误提示
@property(nonatomic,strong)UILabel *errorLabel;

//loading
@property(nonatomic,strong)WuLoadingView *loadingView;



@end

@implementation CashOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopView];
}


-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    //    "Send" = "转账";
    //    "Username" ="转账用户";
    //    "Enter Username" = "请输入转账用户";
    //    "Amount" = "转账金额";
    //    "Enter Amount" ="请输入转账金额";
    //    "Transaction Fee" = "手续费";
    self.navigationController.navigationBarHidden = YES;
    self.navView.title = NSLocalizedStringFromTable(@"cashout",@"Internation", nil);
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick)
                         forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
    [self setupUI];
    
}

-(void)goBackClick{
    if (self.cashOutDelegate && [self.cashOutDelegate respondsToSelector:@selector(CashOutReload)]) {
        [self.cashOutDelegate CashOutReload];
        
    }
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
    
    //"address" ="Address";
//    "Amountmoney"="Amount";

    UILabel *accountLabel = [[UILabel alloc]init];
    accountLabel.text = NSLocalizedStringFromTable(@"address",@"Internation", nil);
    accountLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7];
    accountLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    self.accountLabel = accountLabel;
    [self.containerView addSubview:accountLabel];
    
    /** 设置账号输入 */
    self.accountTF.placeholder = NSLocalizedStringFromTable(@"Enter address",@"Internation", nil);
    //    self.accountTF.text =@"gateway";
    self.accountTF.tintColor = UIColorFromHexValue(0x444444);
    self.accountTF.textColor = UIColorFromHexValue(0x444444);
    self.accountTF.font = [UIFont systemFontOfSize:9.0f];
    //    self.accountTF.leftViewMode = UITextFieldViewModeAlways;
    self.accountTF.delegate = self;
    //    self.accountTF.text =@"13581721469";
    //    self.accountTF.keyboardType=UIKeyboardTypeDefault;
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
    
    //转账金额
    
    UILabel *ferLabel = [[UILabel alloc]init];
    ferLabel.text = NSLocalizedStringFromTable(@"Amountmoney",@"Internation", nil);
    ferLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7];
    ferLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    self.ferLabel = ferLabel;
    [self.containerView addSubview:ferLabel];
    
    //转账金额
    self.passwordTF.placeholder = NSLocalizedStringFromTable(@"Enter Amount",@"Internation", nil);
    self.passwordTF.tintColor = UIColorFromHexValue(0x444444);
    self.passwordTF.textColor = UIColorFromHexValue(0x444444);
    self.passwordTF.font = [UIFont systemFontOfSize:13.f];
    //    self.accountTF.keyboardType=UIKeyboardTypeDefault;
    self.passwordTF.keyboardType = UIKeyboardTypeNumberPad;
    self.passwordTF.delegate = self;
    [self.passwordTF setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.containerView addSubview:self.passwordTF];
    //
    //转账手续费
    
    UILabel *fertwoLabel = [[UILabel alloc]init];
    NSString *feerStr = NSLocalizedStringFromTable(@"Transaction Fee",@"Internation", nil);
    NSString *money;
    //判断手续费
    if ([_cash_model.ass_id isEqualToString:@"1.3.0"]) {
        money = @"3.36718 SEER";
    }else if ([_cash_model.ass_id isEqualToString:@"1.3.5"]){
        money = @"0.01 USDT";
    }else if ([_cash_model.ass_id isEqualToString:@"1.3.2"]){
        money = @"0.00448 PFC";
    }
    fertwoLabel.numberOfLines = 0;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]
                                         initWithString:[NSString stringWithFormat:@"%@ %@",feerStr,money]
                                         attributes:
                                         @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7],
                                           NSForegroundColorAttributeName:
                                               [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0]}];
    
    [string addAttributes:@{NSFontAttributeName:
                                [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7]} range:NSMakeRange(0, feerStr.length)];
    
    [string addAttributes:@{NSFontAttributeName:
                                [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7],
                            NSForegroundColorAttributeName:
                                [UIColor colorWithRed:241/255.0 green:53/255.0 blue:53/255.0 alpha:1.0]}
                    range:NSMakeRange(feerStr.length, money.length+1)];
    
    fertwoLabel.attributedText = string;
    
    self.fertwoLabel = fertwoLabel;
    [self.view addSubview:fertwoLabel];
    
    //预计到账金额
    
    self.succecdMoneyLabel = [[UILabel alloc]init];
    self.succecdMoneyLabel.text = NSLocalizedStringFromTable(@"Account expected",@"Internation", nil);
    self.succecdMoneyLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    self.succecdMoneyLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    [self.view addSubview:self.succecdMoneyLabel];
    
    //预计到账金额
    
    self.out_monrylabel = [[UILabel alloc]init];
    self.out_monrylabel.text = @"0";
    self.out_monrylabel.textColor =[UIColor colorWithRed:241/255.0 green:53/255.0 blue:53/255.0 alpha:1.0];
    self.out_monrylabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    [self.view addSubview:self.out_monrylabel];
    
    
    //余额显示
    
    self.yueLabel.textColor = [UIColor colorWithRed:44/255.0 green:133/255.0 blue:226/255.0 alpha:1.0];
    self.yueLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    if ([_cash_model.ass_id isEqualToString:@"1.3.0"]) {
        self.yueLabel.text = [NSString stringWithFormat:@"%.4f SEER",[MoneyPacketManager moneyAcctountManager].surplus];
    }else if ([_cash_model.ass_id isEqualToString:@"1.3.5"]){
        
        self.yueLabel.text = [NSString stringWithFormat:@"%.4f USDT",[MoneyPacketManager moneyAcctountManager].usdt_surplus];
    }else{
        self.yueLabel.text = [NSString stringWithFormat:@"%.4f PFC",[MoneyPacketManager moneyAcctountManager].pdfc_surplus];
    }
    
    
    [self.view addSubview:self.yueLabel];
    
    //余额
    
    UILabel * danqianyuer = [[UILabel alloc]init];
    
    danqianyuer.text = NSLocalizedStringFromTable(@"Balanceferr",@"Internation", nil);
    danqianyuer.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    danqianyuer.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    
    self.danqianyuer = danqianyuer;
    
    [self.view addSubview:self.danqianyuer];
    //
    
    //    /** 转账按钮 */
    [self.loginBtn setTitle:NSLocalizedStringFromTable(@"cashout",@"Internation", nil) forState:UIControlStateNormal];
    [self.loginBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    InQusetion.backgroundColor =  UIColorFromHexValue(0x81d8cf);
    [self.loginBtn setGradientBackgroundWithColors:@[UIColorFromHexValue(0x2A7DDF),UIColorFromHexValue(0x38AFF4)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    self.loginBtn .layer.cornerRadius = 20;
    self.loginBtn .layer.masksToBounds = NO;
    [self.loginBtn  addTarget:self action:@selector(transAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn ];
    
    self.errorLabel =[[UILabel alloc]init];
    _errorLabel.numberOfLines = 0;
    _errorLabel.textColor = [UIColor redColor];
    _errorLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    _errorLabel.text =@"";
    [self.view addSubview:_errorLabel];
    
    
    [self uplayout];
    
}
//提现交易web接口
-(void)GetAccountUser:(NSString *)ETHText withMemo:(NSString *)memo andWithAccoutId:(NSString *)accountID{
    
    __weak typeof(self) _self = self;
    [[BitsharesWalletObject BitsharesWalletObjectManager]getAccount:M_userName success:^(AccountObject *tusowner) {
        NSError *error;
        [[BitsharesWalletObject BitsharesWalletObjectManager]importKey:[[PrivateKey alloc]initWithPrivateKey:[MoneyPacketManager moneyAcctountManager].priveKeyStr] forAccount:tusowner error:&error];
        [[BitsharesWalletObject BitsharesWalletObjectManager]getAccount:accountID success:^(AccountObject *tusowner2) {
            [[BitsharesWalletObject BitsharesWalletObjectManager]getAsset:_self.cash_model.ass_id success:^(AssetObject *SEER) {
                [[BitsharesWalletObject BitsharesWalletObjectManager]getMoneyFromAccount:tusowner toAccount:tusowner2 assetAmount: [SEER getAmountFromNormalFloatString:memo] memo:ETHText feePayingAsset:SEER success:^(SignedTransaction *signedTransaction) {
                    NSLog(@"转账成功");
                    //取消loding
                    [[BitsharesWalletObject BitsharesWalletObjectManager]listAccountBalance:tusowner success:^(NSArray<AssetAmountObject *> *amount) {
                        for (AssetAmountObject *amountObject in amount) {
                            if ([amountObject.assetId isEqual:@"1.3.0"]) {
                                [MoneyPacketManager moneyAcctountManager].surplus = amountObject.amount/100000.00;;
                            }else if ([amountObject.assetId isEqual:@"1.3.5"]){
                                [MoneyPacketManager moneyAcctountManager].usdt_surplus =amountObject.amount/100.00;
                            }
                            else if([amountObject.assetId isEqual:@"1.3.2"]){
                                [MoneyPacketManager moneyAcctountManager].pdfc_surplus =amountObject.amount/100000.00;
                            }
                            
                        }
                        [self.loadingView cancelView];
                    } error:^(NSError *error) {
                        self.errorLabel.text =@"余额没查到";
                        [self.loadingView cancelView];
                    }];
                    UIView *view = [[UIView alloc]init];
                    view.frame = CGRectMake(0, 0, kScreenW, kScreenH);
                    
                    UIImageView *changeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:NSLocalizedStringFromTable(@"Transfericon",@"Internation", nil)]];
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
                        //                                                                     [self.navigationController popViewControllerAnimated:YES];
                        
                    });//这句话的意思是
                    
                    
                    
                } error:^(NSError *error) {
                    
                    [self.loadingView cancelView];
                    self.errorLabel.text =@"转账失败";
                }];
                
            } error:^(NSError *error) {
                [self.loadingView cancelView];
                self.errorLabel.text =@"资产没查到";
            }];
            
            
        } error:^(NSError *error) {
            [self.loadingView cancelView];
            self.errorLabel.text =@"对方用户查询失败";
        }];
        
    } error:^(NSError *error) {
        [self.loadingView cancelView];
        self.errorLabel.text =@"自己用户查询失败";
    }];
    
}

//提现
-(void)transAction{
    
    self.succecdMoneyLabel.hidden = NO;
    self.out_monrylabel.hidden = NO;
    if (self.accountTF.text.length>0&& self.passwordTF.text.length>0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            WuLoadingView *loadingView = [[WuLoadingView alloc]init];
            self.loadingView = loadingView;
            [loadingView showLoadingView];
        });
        
        float jiner = 0;
        float trjin = 0;
        float tixian = 0;
        NSString*ETCstring =@"";
        NSString *accout_id =@"";
        NSString *withdrawalStr =NSLocalizedStringFromTable(@"The withdrawal",@"Internation", nil);

        //判断转账金额
        if ([self.cash_model.ass_id isEqualToString:@"1.3.0"]) {
             NSString*etcStr =@"erc20#";
            jiner = [MoneyPacketManager moneyAcctountManager].surplus;
            trjin = [self.passwordTF.text floatValue] +3.36718+250;
            ETCstring = [ETCstring stringByAppendingFormat:@"%@%@",etcStr, self.accountTF.text];
            //预计多少钱
            tixian = [self.passwordTF.text floatValue] - 250;
            if (tixian<=0) {
                self.out_monrylabel.text = [NSString stringWithFormat:@"0 SEER %@ 255 SEER以上",withdrawalStr];
            }else{
                self.out_monrylabel.text = [NSString stringWithFormat:@"%.5f SEER",tixian];
            }
            
            
            
            //转账用户
            accout_id =@"gateway";
            
            if ([self.passwordTF.text floatValue]<=250) {
//                self.errorLabel.text = @"预计到账金额为0SEER";
//                self.succecdMoneyLabel.hidden = YES;
//                self.out_monrylabel.hidden = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                   [self.loadingView cancelView];
                });
                
                return;
            }
            
        }
        else if ([self.cash_model.ass_id isEqualToString:@"1.3.5"]){
             NSString*etcStr =@"omni#";
            jiner = [MoneyPacketManager moneyAcctountManager].usdt_surplus;
            trjin = [self.passwordTF.text floatValue] +0.01+5;
            ETCstring = [ETCstring stringByAppendingFormat:@"%@%@",etcStr, self.accountTF.text];
            //预计多少钱
            tixian = [self.passwordTF.text floatValue] - 5;
            
            if (tixian<0) {
                self.out_monrylabel.text = [NSString stringWithFormat:@"0 USDT %@ 6 USDT以上",withdrawalStr];
            }else{
                self.out_monrylabel.text = [NSString stringWithFormat:@"%.5f USDT",tixian];
            }
            
           
            //转账用户
            accout_id =@"usdt-gateway";
            if ([self.passwordTF.text floatValue]<=5) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.loadingView cancelView];
                });
                return;
            }
        }
        else{
            //1.3.2
             NSString*etcStr =@"erc20#";
            jiner = [MoneyPacketManager moneyAcctountManager].pdfc_surplus;
            trjin = [self.passwordTF.text floatValue] +0.00448+5;
            ETCstring = [ETCstring stringByAppendingFormat:@"%@%@",etcStr, self.accountTF.text];
            
             tixian = [self.passwordTF.text floatValue] - 5;
            
            if (tixian<0) {
                self.out_monrylabel.text = [NSString stringWithFormat:@"0 PFC %@ 6 PFC以上",withdrawalStr];
            }else{
               self.out_monrylabel.text = [NSString stringWithFormat:@"%.5f PFC",tixian];
            }
            
            
            //转账用户
            accout_id =@"pfc-gateway";
            
            if ([self.passwordTF.text floatValue]<=5) {
//                self.errorLabel.text = @"预计到账金额为0SEER";
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.loadingView cancelView];
                });
                return;
            }
        }
        NSNumber *a=[NSNumber numberWithFloat:jiner];
        NSNumber *b=[NSNumber numberWithFloat:trjin];
        
        if ([b compare:a] == NSOrderedAscending||fabsf(trjin-jiner) <= EPSILON) {
                [self GetAccountUser:ETCstring withMemo:self.passwordTF.text andWithAccoutId:accout_id];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.loadingView cancelView];
            });
            NSLog(@"金额不足");
            self.errorLabel.text =NSLocalizedStringFromTable(@"Insufficientfunds",@"Internation", nil);
        }
    }else{
        NSLog(@"账号不能为空或者金额不能为空");
        self.errorLabel.text =NSLocalizedStringFromTable(@"User or amount cannot be empty",@"Internation", nil);
    }
    
    
}


-(void)uplayout{
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom).offset(20*kHeightScale);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(340*kWidthScale, 116*kHeightScale));
        
    }];
    
    
    //转账账号名
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(20*kWidthScale);
        make.top.mas_equalTo(20*kHeightScale);
        
    }];
    
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(self.containerView.mas_top).offset(15*kHeightScale);
        make.left.mas_equalTo(self.accountLabel.mas_right).offset(15*kWidthScale);
        make.size.mas_equalTo(CGSizeMake(250*kWidthScale, 45*kHeightScale));
        make.centerY.mas_equalTo(self.accountLabel.mas_centerY);
    }];
    
    
    
    [self.accountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-1.f);
        make.top.mas_equalTo(self.accountTF.mas_bottom);
        make.height.mas_equalTo(.8f);
    }];
    
    // 转账金额
    
    [self.ferLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.accountLabel.mas_left);
        make.top.mas_equalTo(self.accountLine.mas_bottom).offset(20*kHeightScale);
        
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(self.containerView.mas_top).offset(15*kHeightScale);
        make.left.mas_equalTo(self.accountLabel.mas_right).offset(15*kWidthScale);
        make.size.mas_equalTo(CGSizeMake(250*kWidthScale, 45*kHeightScale));
        make.centerY.mas_equalTo(self.ferLabel.mas_centerY);
    }];
    
    //转账手续费
    
    [self.fertwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(28*kWidthScale);
        make.top.mas_equalTo(self.containerView.mas_bottom).offset(13*kHeightScale);
        
    }];
    
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.fertwoLabel.mas_left);
        make.top.mas_equalTo(self.fertwoLabel.mas_bottom).offset(10);
    }];
    
    [self.succecdMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.fertwoLabel.mas_left);
        make.top.mas_equalTo(self.errorLabel.mas_bottom).offset(8);
    }];
    
    [self.out_monrylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.succecdMoneyLabel.mas_right).offset(2);
        make.top.mas_equalTo(self.errorLabel.mas_bottom).offset(8);
        
    }];
    
    
    //余额
    
    [self.yueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25*kWidthScale);
        make.centerY.mas_equalTo(self.fertwoLabel.mas_centerY);
        
    }];
    
    [self.danqianyuer mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.yueLabel.mas_left).offset(-5*kWidthScale);
        make.centerY.mas_equalTo(self.yueLabel.mas_centerY);
        
    }];
    
    //转账按钮
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.containerView.mas_bottom).offset(77*kHeightScale);
        
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(360*kWidthScale, 44*kHeightScale));
        
    }];
    
    
}


#pragma mark - Getters/Setters/Lazy

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

#pragma mark - Public Method

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
