//
//  WalltMarkView.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/2.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "WalltMarkView.h"


@interface WalltMarkView ()

//弹窗View
@property(nonatomic,strong)UIView *alertView;
//确定bnt
@property(nonatomic,strong)UIButton *sureBtn;

//取消bnt
@property(nonatomic,strong)UIButton *cancelBtn;

//大字
@property(nonatomic,strong)UILabel *bigLabel;

//小字
@property(nonatomic,strong)UILabel *littleLabel;

//传来的值
@property(nonatomic,copy)NSString *bigStr;

@property(nonatomic,copy)NSString *littleStr;

//@property(nonatomic,strong)UIColor *textColor;

@end

@implementation WalltMarkView

-(instancetype) initWithTitleBiglable:(NSString *)bigLabel little:(NSString *)little{
    
    self = [super init];
    
    if (self) {
        
        self.bigStr = bigLabel;
        self.littleStr = little;
        
        [self setupUI];
    }
    
    return  self;
}


-(void)setupUI{
    
    self.frame = [UIScreen mainScreen].bounds;
    self.alertView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH -213, kScreenW, self.height)];
    self.alertView.backgroundColor =  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.alertView.layer.masksToBounds=YES;
    self.alertView.userInteractionEnabled=YES;
    [self addSubview:self.alertView];
    
    //初始化大字
    self.bigLabel = [[UILabel alloc]init];
    self.bigLabel.text =self.bigStr;
    self.bigLabel.font =[UIFont fontWithName:@"PingFangSC-Medium" size: 14];
    self.bigLabel.textColor = UIColorFromHexValue(0x444444);
    
    [self.alertView addSubview:self.bigLabel];
    
    [self.bigLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18);
        make.centerX.mas_equalTo(0);
        
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0 alpha:1.0];
    [self.alertView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bigLabel.mas_bottom).offset(18);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(0.3);
    }];
    
    self.littleLabel = [[UILabel alloc]init];
    self.littleLabel.text =self.littleStr;
    self.littleLabel.textColor = UIColorFromHexValue(0x444444);
    self.littleLabel.alpha = 0.5;
    self.littleLabel.numberOfLines = 0;
    self.littleLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size: 11];
    [self.alertView addSubview:self.littleLabel];
    
    [self.littleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(30);
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(20);
        make.centerX.mas_equalTo(0);
        
    }];
    
    self.sureBtn = [[UIButton alloc]init];
    
    [self.sureBtn setTitle:NSLocalizedStringFromTable(@"Buttonsure",@"Internation", nil) forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:UIColorFromHexValue(0x2C86E3) forState:UIControlStateNormal];
    self.sureBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 18.7];
    
    [self.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sureBtn setBackgroundImage:[UIImage imageNamed:@"markwllt_icon"] forState:UIControlStateNormal];
     self.sureBtn.layer.cornerRadius =22;
    [self.alertView addSubview: self.sureBtn];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.littleLabel.mas_bottom).offset(25);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(150, 44));
        
    }];
    
    
    self.cancelBtn = [[UIButton alloc]init];
    
    [self.cancelBtn setTitle:NSLocalizedStringFromTable(@"Cancel",@"Internation", nil) forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromHexValue(0xffffff) forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 18.7];
    self.cancelBtn.backgroundColor = UIColorFromHexValue(0x2A7DDF);
//    [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"markwllt2_icon"] forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius =22;
    
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView addSubview: self.cancelBtn];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.littleLabel.mas_bottom).offset(25);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(150, 44));
        
    }];
    
    
    
    [self showAnimation];
    
}


-(void)showAnimation{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3f];
    
}

-(void)cancelBtnClick{
    
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
        
    }];
    
}


-(void)sureBtnClick{
    
    if (self.block) {
        self.block();
        [UIView animateWithDuration:0.3 animations:^{
            [self removeFromSuperview];
            
        }];
    }
    
    
}
//回调block;
- (void)addButtonAction:(ButtonBlock)block{
    _block = block;
    
    
}




@end
