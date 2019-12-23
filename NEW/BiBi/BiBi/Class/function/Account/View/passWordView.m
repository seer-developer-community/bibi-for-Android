//
//  passWordView.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/24.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "passWordView.h"

#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface passWordView ()<UITextFieldDelegate>
//弹窗View
@property(nonatomic,strong)UIView *alertView;
//确定bnt
@property(nonatomic,strong)UIButton *sureBtn;

//取消bnt
@property(nonatomic,strong)UIButton *cancelBtn;

//输入框
@property(nonatomic,strong)UITextField * passWordField;

//错误提示

@property(nonatomic,strong)UILabel *errorLabel;



@end

@implementation passWordView


-(instancetype) initWithTitleImage {
    
    self = [super init];
    
    if (self) {
        
        [self setupUI];
        
        
    }
    
    return self;
    
    
}




-(void)setupUI{
    self.frame = [UIScreen mainScreen].bounds;
    self.alertView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH -125, kScreenW, self.height)];
    self.alertView.backgroundColor =  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
//    self.alertView.layer.cornerRadius=5.0;
    self.alertView.layer.masksToBounds=YES;
    self.alertView.userInteractionEnabled=YES;
    [self addSubview:self.alertView];
    
    UIButton * backBtn = [[UIButton alloc]init];
    
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    backBtn.backgroundColor = [UIColor redColor];
    self.cancelBtn = backBtn;
    [backBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelBtn = backBtn;
    [self.alertView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(25, 40));
        
    }];
    
    UILabel *qianbaoLabel = [[UILabel alloc]init];
    
    qianbaoLabel.text = NSLocalizedStringFromTable(@"Please enter the password",@"Internation", nil);
    
    qianbaoLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 12];
    [self.alertView addSubview:qianbaoLabel];

    [qianbaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.cancelBtn.mas_centerY);
        make.centerX.mas_equalTo(0);
    }];
    
    
    UIButton *sureBtn = [[UIButton alloc]init];
    [sureBtn setTitle:NSLocalizedStringFromTable(@"Buttonsure",@"Internation", nil) forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 12];
    [sureBtn setTitleColor:UIColorFromHexValue(0x2A7DDF) forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(SureClick:) forControlEvents:UIControlEventTouchUpInside];
    self.sureBtn = sureBtn;
    [self.alertView addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 15));
        
    }];
    
    UITextField *passWordField = [[UITextField alloc]init];
     passWordField.placeholder = NSLocalizedStringFromTable(@"Please enter the password",@"Internation", nil);;
    passWordField.borderStyle = UITextBorderStyleRoundedRect;
    passWordField.textColor = UIColorFromHexValue(0x444444);
    passWordField.tintColor = UIColorFromHexValue(0x444444);
    passWordField.font = [UIFont systemFontOfSize:13.f];
     passWordField.secureTextEntry = YES;
    passWordField.keyboardType = UIKeyboardTypeASCIICapable;
    passWordField.autocapitalizationType = UITextAutocapitalizationTypeNone;

    
    self.passWordField = passWordField;
    self.passWordField.delegate = self;
    
    [self addSubview:passWordField];
    [passWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backBtn.mas_bottom).offset(15);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(40);
        
    }];
    
    
    
    self.errorLabel =[[UILabel alloc]init];
    _errorLabel.numberOfLines = 0;
    _errorLabel.textColor = [UIColor redColor];
    _errorLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    _errorLabel.text =@"";
    [self addSubview:_errorLabel];
    
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(passWordField.mas_bottom).offset(5);
        make.left.mas_equalTo(passWordField.mas_left);
        
    }];
    
    
    
     [self showAnimation];
    
}


-(void)showAnimation{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
    
}


// 取消button
-(void)cancelClick:(UIButton *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

//

-(void)SureClick:(UIButton *)sender{
    
    NSLog(@"确定");
    
//    if (self.block) {
//        self.block(self);
//         [self removeFromSuperview];
//    }
    
    
    
//    if (self.sureClick) {
//        self.sureClick(self.passWordField.text);
//        [self removeFromSuperview];
//    }
    
//
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *testStr = [defaults objectForKey:@"NCUserDefaultPasswordKey"];
    NSString *testStr = [MoneyPacketManager moneyAcctountManager].passWored;
    
    
    
    if (self.passWordField.text.length<0) {
        self.errorLabel.text = NSLocalizedStringFromTable(@"Inputempty",@"Internation", nil);
        return;
    }
//
    
    if ([self.passWordField.text isEqualToString:testStr]) {
        if (self.sureClick) {
            self.sureClick(self.passWordField.text);
            [self removeFromSuperview];
        }

    }else{

        self.errorLabel.text = NSLocalizedStringFromTable(@"The password is incorrect, please retype it",@"Internation", nil);
        NSLog(@"密码错误");
    }

    
}


//实现block回调的方法
- (void)addButtonAction:(ButtonBlock)block {
    self.block = block;
}



//点击屏蔽HUD消失
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        [self removeFromSuperview];
//    }];
//    
//    
//}




//
//-(void)SureClick:(UIButton *)sender{

//
//    //    [UIView animateWithDuration:0.3 animations:^{
//    //        [self removeFromSuperview];
//    //    }];
//}



//调用代码块传值
-(void)withSureClick:(sureBlock)block{

    _sureClick = block;
}





- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:0.20];
    //??使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置视图移动的位移
    if(IS_iPhoneX){
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 350, self.frame.size.width, self.frame.size.height);
    }else{
         self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 270*kHeightScale, self.frame.size.width, self.frame.size.height);
    }
   
    //设置动画结束
    [UIView commitAnimations];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:0.20];
    //??使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置视图移动的位移
    if (IS_iPhoneX) {
      self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y +350, self.frame.size.width, self.frame.size.height);
    }else{
      self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y +270*kHeightScale, self.frame.size.width, self.frame.size.height);
    }
    
    //设置动画结束
    [UIView commitAnimations];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
     [self hideKeyboard];
//    [_text resignFirstResponder];
    return YES;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];


    return [string isEqualToString:filtered];
    
}



- (void)hideKeyboard{
    
    [self endEditing:YES];
}



@end
