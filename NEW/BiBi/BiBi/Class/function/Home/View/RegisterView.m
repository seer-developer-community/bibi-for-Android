//
//  RegisterView.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/28.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "RegisterView.h"

@interface RegisterView ()

@property(nonatomic,strong)UIButton *registerButton;

@property(nonatomic,strong)UIButton *cancelButton;

@end

@implementation RegisterView


-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        [self setupUI];
//         [self showAnimation];
    }
    return self;
}


-(void)setupUI{
    
    UIImageView *registerImageView = [[UIImageView alloc]init];
    [registerImageView setImage:[UIImage imageNamed:NSLocalizedStringFromTable(@"registerimage",@"Internation", nil)]];
    [self addSubview:registerImageView];
    
    [registerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(386);
        
    }];
    
    self.registerButton = [[UIButton alloc]init];
    [ self.registerButton setGradientBackgroundWithColors:@[UIColorFromHexValue(0x2A7DDF),UIColorFromHexValue(0x38AFF4)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    [self.registerButton setTitle:NSLocalizedStringFromTable(@"Register",@"Internation", nil) forState:UIControlStateNormal];
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.registerButton.layer.cornerRadius = 25;
    
    [self.registerButton addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(registerImageView.mas_bottom).offset(-10);
        make.centerX.mas_equalTo(registerImageView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(220, 50));
    }];
    
    self.cancelButton = [[UIButton alloc]init];
    [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"regicster_canel_icon"] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelButton];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(registerImageView.mas_top);
        make.right.mas_equalTo(registerImageView.mas_right);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self showAnimation];
}


-(void)showAnimation{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3f];
    
}


-(void)registerClick{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(registerPushlog)]) {
        [self.delegate registerPushlog];
        [self removeFromSuperview];
        [MoneyPacketManager moneyAcctountManager].isHiddenImage = YES;
    }
    NSLog(@"点击了");
}

-(void)cancelButtonClick{
    [self removeFromSuperview];
    [MoneyPacketManager moneyAcctountManager].isHiddenImage = YES;
}

@end
