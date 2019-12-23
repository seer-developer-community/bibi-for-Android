//
//  MaskView.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/2.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "MaskView.h"

@interface MaskView ()

//弹窗View
@property(nonatomic,strong)UIView *alertView;
//确定bnt
@property(nonatomic,strong)UIButton *sureBtn;

//大字
@property(nonatomic,strong)UILabel *bigLabel;

//小字

@property(nonatomic,strong)UILabel *littleLabel;

//传来的值
@property(nonatomic,copy)NSString *bigStr;

@property(nonatomic,copy)NSString *littleStr;

@property(nonatomic,strong)UIColor *textColor;

@property(nonatomic,strong)UILabel *littleLabel2;
@property(nonatomic,strong)NSString *littleTwoStr;
//

@end

@implementation MaskView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(instancetype) initWithTitleBiglable:(NSString *)bigLabel little:(NSString *)little littletwo:(NSString *)littletwo textColor:(UIColor *)textColor{
    
    self = [super init];
    
    if (self) {
        self.bigStr = bigLabel;
        self.littleStr = little;
        self.littleTwoStr = littletwo;
        self.textColor = textColor;
        
        
        
        [self setupUI];
        
        
    }
    
    return self;
    
    
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
    self.bigLabel.textColor = self.textColor;
    
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
    self.littleLabel.numberOfLines = 0;
    self.littleLabel.textColor = UIColorFromHexValue(0x444444);
    self.littleLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size: 11];
    [self.alertView addSubview:self.littleLabel];
    [self.littleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(25);
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(20);
        

    }];
     self.littleLabel.centerX = self.centerX;
    
    self.littleLabel2 = [[UILabel alloc]init];
    self.littleLabel2.text =self.littleTwoStr;
    self.littleLabel2.numberOfLines = 0;
    self.littleLabel2.textColor = UIColorFromHexValue(0x444444);
    self.littleLabel2.font =[UIFont fontWithName:@"PingFangSC-Regular" size: 11];
    [self.alertView addSubview:self.littleLabel2];
    [self.littleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(25);
        make.centerX.mas_equalTo(0);
        
        
    }];
    


    
    
   
    UIButton *sureBtn = [[UIButton alloc]init];
    [sureBtn setTitle:NSLocalizedStringFromTable(@"Buttonsure",@"Internation", nil) forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 18.7];
    [sureBtn setTitleColor:UIColorFromHexValue(0xffffff) forState:UIControlStateNormal];
//    [sureBtn setBackgroundColor:UIColorFromHexValue(0x2A7DDF) forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:UIColorFromHexValue(0x2A7DDF)];
    sureBtn.layer.cornerRadius =22;
    [sureBtn addTarget:self action:@selector(SureClick:) forControlEvents:UIControlEventTouchUpInside];
    self.sureBtn = sureBtn;
    [self.alertView addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).offset(-20);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
        
    }];
    
    
    
    
    
    
    [self showAnimation];
    
}


-(void)showAnimation{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3f];
    
}

-(void)SureClick:(UIButton *)sender{
    
    if (self.block) {
        self.block(sender);
        [UIView animateWithDuration:0.3 animations:^{
            [self removeFromSuperview];
            
        }];
    }
    
  
    
}

- (void)addButtonAction:(ButtonBlock)block{
    
    self.block = block;
}


@end
