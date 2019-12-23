//
//  OrderHeaderFootView.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/8.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "OrderHeaderFootView.h"

@interface OrderHeaderFootView (){
    
    int flag;
}

@property (strong,nonatomic)UIButton * tmpBtn;

@property(nonatomic,strong)UIButton *ONorderBnt;

@property(nonatomic,strong)UIButton *forandBnt;

@property(nonatomic,strong)UIButton *finishBnt;

@end

@implementation OrderHeaderFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    
    return self;
}


-(UIButton *)ONorderBnt{
    if (!_ONorderBnt) {
        _ONorderBnt = [[UIButton alloc]init];
        [_ONorderBnt setTitle:@"进行中" forState:UIControlStateNormal];
        [_ONorderBnt setTitleColor:UIColorFromHexValue(0x444444) forState:UIControlStateNormal];
        _ONorderBnt.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
        
//        _ONorderBnt.backgroundColor= [UIColor greenColor];
    }
    
    return _ONorderBnt;
}

-(UIButton *)forandBnt{
    
    if (!_forandBnt) {
        _forandBnt = [[UIButton alloc]init];
        [_forandBnt setTitle:@"待结算" forState:UIControlStateNormal];
        [_forandBnt setTitleColor:UIColorFromHexValue(0x444444) forState:UIControlStateNormal];
        _forandBnt.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
//        _forandBnt.backgroundColor = [UIColor blueColor];
    }
    
    return _forandBnt;
}


-(UIButton*)finishBnt{
    
    if (!_finishBnt) {
        _finishBnt = [[UIButton alloc]init];
        [_finishBnt setTitle:@"已结束" forState:UIControlStateNormal];
        [_finishBnt setTitleColor:UIColorFromHexValue(0x444444) forState:UIControlStateNormal];
        _finishBnt.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
//        _finishBnt.backgroundColor =[UIColor redColor];
        
        
    }
    
    return _finishBnt;
}






-(void)setupUI{
    UIView *bagView = [[UIView alloc]init];
    bagView.frame = CGRectMake(15, 0, kScreenW-30, 40);
    bagView.backgroundColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bagView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bagView.bounds;
    maskLayer.path = maskPath.CGPath;
    bagView.layer.mask = maskLayer;
    [self addSubview:bagView];
    
    [bagView addSubview:self.ONorderBnt];
    self.ONorderBnt.tag = 10001;
    [self.ONorderBnt addTarget:self action:@selector(dianjishijian:) forControlEvents:UIControlEventTouchUpInside];
//    self.ONorderBnt.selected = YES;
    [self.ONorderBnt setTitle:@"进行中" forState:UIControlStateSelected];
    CGFloat bottomW = (ScreenWidth -30)/3;
    [self.ONorderBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(bottomW);
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = UIColorFromHexValue(0x2A7DDF);
    
    line1.layer.cornerRadius = 0.5;

    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ONorderBnt.mas_bottom).offset(2);
        make.centerX.mas_equalTo(self.ONorderBnt.mas_centerX);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(self.ONorderBnt.width/4);
    }];
    
    
    
    
    
    
    [self addSubview: self.forandBnt];

    self.forandBnt.tag = 10002;
    
    [self.forandBnt addTarget:self action:@selector(dianjishijian:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.forandBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(self.ONorderBnt.mas_height);
        make.left.mas_equalTo(self.ONorderBnt.mas_right);
        make.width.mas_equalTo(bottomW);
        
    }];
    
    
    [self addSubview:self.finishBnt];
    self.finishBnt.tag = 10003;
    [self.finishBnt addTarget:self action:@selector(dianjishijian:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.finishBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(self.ONorderBnt.mas_height);
        make.width.mas_equalTo(bottomW);
        make.left.mas_equalTo(self.forandBnt.mas_right);
        
    }];
    
    
    
    
    UIView *line5 = [[UIView alloc]init];
    
    line5.backgroundColor = UIColorFromHexValue(0x444444);
    line5.alpha = 0.3;
    [bagView addSubview:line5];
    
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(0);
        make.bottom.mas_equalTo(bagView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    
    
}



-(void)dianjishijian:(UIButton*)sender{
   
    
    if (_tmpBtn == nil){
        sender.selected = YES;
        _tmpBtn = sender;
//        sender.titleLabel.font = [UIFont systemFontOfSize:18*kWidthScale];
//        line1.hidden = NO;
        
    }
    else if (_tmpBtn !=nil && _tmpBtn == sender){
        sender.selected = YES;
//        sender.titleLabel.font = [UIFont systemFontOfSize:18*kWidthScale];
//        line1.hidden = NO;
    }
    else if (_tmpBtn!= sender && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
//        _tmpBtn.titleLabel.font = [UIFont systemFontOfSize:14*kWidthScale];
//        line1.hidden = YES;
        sender.selected = YES;
        _tmpBtn = sender;
//        sender.titleLabel.font = [UIFont systemFontOfSize:18*kWidthScale];
//        line1.hidden =NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(caseHeaderButtontag:)]) {
        [self.delegate caseHeaderButtontag:sender.tag];
    }
}

@end
