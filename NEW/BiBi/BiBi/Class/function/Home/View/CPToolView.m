//
//  CPToolView.m
//  随便
//
//  Created by 陈彦松 on 2018/12/23.
//  Copyright © 2018年 cmbc. All rights reserved.
//

#import "CPToolView.h"
#import "CPPassWordKeyboard.h"
#import "DetailsModel.h"
#import "XYSwitch.h"
//#import "YYKit.h"
#define EPSILON 1e-6
@interface CPToolView ()<CPPassWordKeyboardProtocol>

@property(strong,nonatomic)UIView *bagView;

@property (strong, nonatomic) UILabel * titleLabel;
//选项的label;
@property(strong,nonatomic)UILabel *chooseLabel;

@property (strong, nonatomic) UILabel * yuceLabel;
@property (strong, nonatomic) UIButton * getBB;
@property (strong, nonatomic) UILabel * inputLabel;
//手续费文字
@property (strong, nonatomic) UILabel * shouxuLabel;
//手续费金额
@property(strong,nonatomic)UILabel *seerMLabel;
//余额文字
@property(strong,nonatomic)UILabel *sumLabel;

@property (strong, nonatomic) UILabel * yueLabel;
@property (strong, nonatomic) UIButton * closeBtn;

@property(strong,nonatomic)UIButton *surBnt;


@property(strong,nonatomic)UIButton *surbutton;

@property(assign,nonatomic)float trsNumber;

@property(strong,nonatomic)UILabel *errorLabel;

@property(strong,nonatomic)UILabel *errorLabel2;

@property(strong,nonatomic)UILabel *buyLabel;

//总共份数的金额
@property(assign,nonatomic)float beforeBuy;
//买完后的金额
@property(assign,nonatomic)float  selecetBuy;

//买入卖出选择
@property(strong,nonatomic)XYSwitch *xySwitch;

@property(assign,nonatomic)NSInteger roomtype;

@property(nonatomic,strong)UILabel *hiddenLabel;

@property(nonatomic,strong)UILabel *saelLabel;

//全局bool值变量
@property(nonatomic,assign)BOOL isSelced;

@end

@implementation CPToolView

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//       
//
//    }
//    return self;
//}

-(instancetype)initWithRoomtype:(NSInteger)roomtype{
    
    self = [super init];
    
    if (self) {
        [self setUpUI:roomtype];

        
    }
    
    return self;
}


- (void)setUpUI:(NSInteger)roomtype{
    self.roomtype = roomtype;
    self.trsNumber = 0;
    self.frame = [UIScreen mainScreen].bounds;
    self.bagView = [[UIView alloc]init];
    self.bagView.backgroundColor = [UIColor whiteColor];
      CGFloat leftMargin = 10;
    if (roomtype == 0) {
        self.bagView.frame = CGRectMake(0, kScreenH -260, self.bounds.size.width, 260);
        XYSwitch * mySwitch = [[XYSwitch alloc] initWithTextFont:[UIFont systemFontOfSize:18] OnText:NSLocalizedStringFromTable(@"Sell",@"Internation", nil) offText:NSLocalizedStringFromTable(@"Buy",@"Internation", nil) onBackGroundColor:nil offBackGroundColor:nil onButtonColor:nil offButtonColor:nil onTextColor:nil andOffTextColor:nil];
        [self.bagView addSubview:mySwitch];
        [mySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(leftMargin);
            make.centerX.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(160, 40));
        }];
        _hiddenLabel = [[UILabel alloc]init];
        _hiddenLabel.text = NSLocalizedStringFromTable(@"Buy",@"Internation", nil);
        _hiddenLabel.font = [UIFont systemFontOfSize:18];
        _hiddenLabel.textColor =[UIColor whiteColor];
        _hiddenLabel.textAlignment = NSTextAlignmentCenter;
        [_hiddenLabel sizeToFit];
        [mySwitch addSubview:self.hiddenLabel];
        [self.hiddenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(20);
            
        }];
        
        _saelLabel = [[UILabel alloc]init];
        _saelLabel.text = NSLocalizedStringFromTable(@"Sell",@"Internation", nil);
        _saelLabel.font = [UIFont systemFontOfSize:18];
        _saelLabel.textColor =[UIColor blackColor];
        _saelLabel.textAlignment = NSTextAlignmentCenter;
        [_saelLabel sizeToFit];
        [mySwitch addSubview:self.saelLabel];
        [self.saelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-20);
        }];
        
        
        mySwitch.changeStateBlock = ^(BOOL isOn) {
            NSLog(@"Controller:%ld",(long)isOn);
            if (isOn) {
                self.hiddenLabel.textColor = [UIColor blackColor];
                self.saelLabel.textColor = [UIColor whiteColor];
                self.isSelced = isOn;
                self.inputLabel.text = @"";
                self.errorLabel2.text = @"";
                self.buyLabel.text =@"";
            }else{
                self.isSelced = isOn;
                self.hiddenLabel.textColor = [UIColor whiteColor];
                self.saelLabel.textColor = [UIColor blackColor];
                 self.inputLabel.text = @"";
                self.errorLabel2.text = @"";
                self.buyLabel.text = @"";
            }
        };
//        "Predictcontent" = "你所预测的选择是:";
//        "PredictMoney" = "预测额范围:";
//        "Free" ="手续费";
//        "Getbibi" ="如何获取代币";
//        "Balanceferr" = "余额";
//        "Buttonsure" = "确定";
        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.frame = CGRectMake(leftMargin, 40+leftMargin*2, 150, 30);
        _titleLabel.text =NSLocalizedStringFromTable(@"Predictcontent",@"Internation", nil);
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 12];
        [self.bagView  addSubview:_titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftMargin);
            make.top.mas_equalTo(mySwitch.mas_bottom).offset(20);
        }];
    }else{
        
        self.bagView.frame = CGRectMake(0, kScreenH -200, self.bounds.size.width, 210);
        CGFloat leftMargin = 10;
        _titleLabel = [[UILabel alloc] init];
      
//        _titleLabel.text = @"您所预测的选择是:";
       _titleLabel.text = NSLocalizedStringFromTable(@"Predictcontent",@"Internation", nil);
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 12];
        [self.bagView  addSubview:_titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftMargin);
            make.top.mas_equalTo(3);
        }];
        
    }
   
    [self addSubview:self.bagView ];
  
    
    _chooseLabel = [[UILabel alloc]init];
//    _chooseLabel.frame = CGRectMake(_titleLabel.right +5, 0, 150, 50);
    _chooseLabel.numberOfLines = 0;
    [_chooseLabel setTextColor:UIColorFromHexValue(0x2A7DDF)];
    _chooseLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 12];
    _chooseLabel.centerY = _titleLabel.centerY;
    [self.bagView  addSubview: _chooseLabel];
    [self.chooseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
    }];
    
    _yuceLabel = [[UILabel alloc] init];
    _yuceLabel.frame = CGRectMake(_titleLabel.left, _titleLabel.bottom, self.width/2, 30);
//    _yuceLabel.text = @"预测额范围:";
    _yueLabel.text =NSLocalizedStringFromTable(@"PredictMoney",@"Internation", nil);
    _yuceLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size: 9.3];
    _yuceLabel.textColor = UIColorFromHexValue(0x444444);
    [self.bagView  addSubview:_yuceLabel];
    [self.yuceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(leftMargin);
    }];
    
    
    
    _inputLabel = [[UILabel alloc] init];
//    _inputLabel.frame = CGRectMake(leftMargin,_yuceLabel.bottom, self.width - 2 * leftMargin, 44);
    _inputLabel.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _inputLabel.layer.borderWidth = 0.3f;
    _inputLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
//    _inputLabel.text = @"请输入数字";
    _inputLabel.text = NSLocalizedStringFromTable(@"Pleasenum",@"Internation", nil);
     _inputLabel.alpha = 0.5;
    _inputLabel.font = [UIFont systemFontOfSize:15];

    //初始化手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_inputLabel addGestureRecognizer:tap];
//    _inputLabel.text = [NSString stringWithFormat:@"%ld",roomtype];
    _inputLabel.userInteractionEnabled = YES;
    [self.bagView addSubview:_inputLabel];
    [self.inputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftMargin);
        make.top.mas_equalTo(self.yuceLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(self.width - 2 * leftMargin, 44));
    }];
    
    
    
    
    _closeBtn = [[UIButton alloc]init];
    [_closeBtn setImage:[UIImage imageNamed:@"x_iocn"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(ColseClick) forControlEvents:UIControlEventTouchUpInside];
    _closeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.bagView addSubview:_closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    //获取代币
    _getBB = [UIButton buttonWithType:UIButtonTypeCustom];
//    _getBB.frame = CGRectMake(_inputLabel.right-self.width/4, _yuceLabel.top, self.width/3, _yuceLabel.height);
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"如何获取代币?  " attributes:attribtDic];
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:NSLocalizedStringFromTable(@"Getbibi",@"Internation", nil)  attributes:attribtDic];
    [attribtStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, attribtStr.length)];
    [_getBB  setAttributedTitle:attribtStr forState:UIControlStateNormal];
    _getBB.titleLabel.font = [UIFont systemFontOfSize:10];
    [_getBB addTarget:self action:@selector(getBBClick) forControlEvents:UIControlEventTouchUpInside];
    _getBB.titleLabel.textAlignment = NSTextAlignmentRight;
    [_getBB setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.bagView addSubview:_getBB];
    
    [self.getBB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.yuceLabel.mas_centerY);
    }];
    
    
//
//
//
    _shouxuLabel = [[UILabel alloc] init];
//    _shouxuLabel.text = @"手续费:";
    _shouxuLabel.text = NSLocalizedStringFromTable(@"Free",@"Internation", nil);;
    _shouxuLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
//    _shouxuLabel.frame = CGRectMake(_inputLabel.left, _inputLabel.bottom, 40, 15);
    [self.bagView  addSubview:_shouxuLabel];
    
    [self.shouxuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftMargin);
        make.top.mas_equalTo(self.inputLabel.mas_bottom).offset(8);
    }];
    
//
    _seerMLabel = [[UILabel alloc]init];
    _seerMLabel.text =@"5 SEER";
    _seerMLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    _seerMLabel.textColor = [UIColor redColor];
//    _seerMLabel.frame = CGRectMake(_shouxuLabel.right+5, _shouxuLabel.top, self.bounds.size.width/6, 15);
    [self.bagView addSubview:_seerMLabel];
    [self.seerMLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shouxuLabel.mas_right).offset(2);
        make.centerY.mas_equalTo(self.shouxuLabel);
    }];
    

    _errorLabel = [[UILabel alloc]init];
    _errorLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10];
    _errorLabel.textColor =[UIColor redColor];
//    _errorLabel.frame = CGRectMake(_inputLabel.left, _shouxuLabel.bottom, self.bounds.size.width, 15);
    [self.bagView addSubview:self.errorLabel];
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.inputLabel.mas_left);
        make.top.mas_equalTo(self.shouxuLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(self.width, 15));
    }];
//
    _yueLabel = [[UILabel alloc] init];
    _yueLabel.text = @"555555555555555555";
    _yueLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    _yueLabel.textColor = UIColorFromHexValue(0x2A7DDF);
    _yueLabel.textAlignment = NSTextAlignmentRight;
    [self.bagView addSubview:_yueLabel];
    [_yueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.inputLabel.mas_right);
        make.centerY.mas_equalTo(self.shouxuLabel.mas_centerY);
    }];
//
//
//    //余额
    _sumLabel = [[UILabel alloc]init];
    _sumLabel.text = NSLocalizedStringFromTable(@"Balanceferr",@"Internation", nil);
    _sumLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    _sumLabel.textColor = UIColorFromHexValue(0x444444);
    [self.bagView addSubview:_sumLabel];
    [self.sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.yueLabel.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.yueLabel.mas_centerY);
    }];
//
//    //确定按钮
    _surBnt = [[UIButton alloc]init];
    [_surBnt setBackgroundImage:[UIImage imageNamed:@"toolSurbnt_icon"] forState:UIControlStateNormal];
    [_surBnt setTitle:NSLocalizedStringFromTable(@"Buttonsure",@"Internation", nil) forState:UIControlStateNormal];
    [_surBnt addTarget:self action:@selector(surBnterror) forControlEvents:UIControlEventTouchUpInside];
    _surBnt.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size: 18.7];
//    _surBnt.frame =CGRectMake(15, self.shouxuLabel.bottom +7, 350,65 );
    _surBnt.centerX = self.centerX;
    [self.bagView addSubview:_surBnt];
    
    [self.surBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.shouxuLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(350, 65));
    }];
    
//
//
//
}

- (void)getBBClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushnextVc)]) {
        [self.delegate pushnextVc];
    }
    [self removeFromSuperview];
}

- (void)ColseClick {
    [self removeFromSuperview];
    self.inputLabel.text =@"";
}


-(void)surBnterror{
    
   
    self.errorLabel.text = NSLocalizedStringFromTable(@"Inputempty",@"Internation", nil);
}

-(void)tapAction{
    self.errorLabel.text = @"";

    if (self.roomtype == 0) {

         self.bagView.frame = CGRectMake(0, kScreenH -510, self.bounds.size.width, 260);
    }else{
        self.bagView.frame = CGRectMake(0, kScreenH -425, self.bounds.size.width, 210);
    }
//     self.bagView.frame = CGRectMake(0, kScreenH -425, self.bounds.size.width, 210);
//    self.bagView.backgroundColor = [UIColor redColor];
        CPPassWordKeyboard * cp = [[CPPassWordKeyboard alloc] init];
    cp.backgroundColor =  [UIColor colorWithRed:214/255.0 green:215/255.0 blue:220/255.0 alpha:1.0];
        cp.frame = CGRectMake(0, kScreenH -310, self.width, 210);
//    cp.backgroundColor = [UIColor yellowColor];
          cp.delegate =self;
        [self addSubview:cp];
    
    self.inputLabel.text =@"";
    
    UIView *bbView = [[UIView alloc]init];
    
    bbView.backgroundColor =[UIColor whiteColor];
    
    bbView.frame = CGRectMake(0, cp.bottom, kScreenW, 105);
    
    [self addSubview:bbView];
    
    _errorLabel2 = [[UILabel alloc]init];
    _errorLabel2.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10];
    _errorLabel2.textColor =[UIColor redColor];
    _errorLabel2.frame = CGRectMake(10, 5, self.bounds.size.width/2, 15);
    [bbView addSubview:self.errorLabel2];
    
    _buyLabel = [[UILabel alloc]init];
    _buyLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10];
    _buyLabel.textColor =[UIColor redColor];
    _buyLabel.frame = CGRectMake(_errorLabel2.right/2, _errorLabel2.bottom +2, self.bounds.size.width, 15);
    [bbView addSubview:self.buyLabel];
    
    
    //确定button
    self.surbutton = [[UIButton alloc]init];
    [self.surbutton setBackgroundImage:[UIImage imageNamed:@"toolSurbnt_icon"] forState:UIControlStateNormal];
    [self.surbutton setTitle:NSLocalizedStringFromTable(@"Buttonsure",@"Internation", nil) forState:UIControlStateNormal];
    [self.surbutton addTarget:self action:@selector(bettingBnt) forControlEvents:UIControlEventTouchUpInside];
    self.surbutton.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size: 18.7];
    self.surbutton.frame =CGRectMake(0, 35, 350,65 );
    self.surbutton.centerX = cp.centerX;
    [bbView addSubview:self.surbutton];

}




//投注确定
-(void)bettingBnt{
    if (self.preModel) {
        if (self.trsNumber<=0) {
            _errorLabel2.text = NSLocalizedStringFromTable(@"Please enter the estimated amount",@"Internation", nil);
            return;
        }
        
        if (self.trsNumber>=self.preModel.minNub&&self.trsNumber<=self.preModel.maxNub&&self.trsNumber>0) {
            float jiner = 0;
            float trjin = 0;
            if ([self.preModel.accept_asset isEqualToString:@"SEER"]) {
                jiner = [MoneyPacketManager moneyAcctountManager].surplus;
                trjin = self.trsNumber +5;
            }else if ([self.preModel.accept_asset isEqualToString:@"USDT"]){
                jiner = [MoneyPacketManager moneyAcctountManager].usdt_surplus;
                trjin = self.trsNumber  +0.1;
                
            }else if ([self.preModel.accept_asset isEqualToString:@"PFC"]){
                jiner = [MoneyPacketManager moneyAcctountManager].pdfc_surplus;
                trjin = self.trsNumber +0.00664;
            }
//            float jiner = [MoneyPacketManager moneyAcctountManager].surplus;
            //        float trjin = [self.trsNumber floatValue] +2;
//            NSNumber *a=[NSNumber numberWithFloat:jiner];
//            NSNumber *b=[NSNumber numberWithInteger:self.trsNumber +4];
            NSNumber *a=[NSNumber numberWithFloat:jiner];
            NSNumber *b=[NSNumber numberWithInteger:trjin];
            
            if ([b compare:a]== NSOrderedAscending ||fabs(trjin-jiner) <= EPSILON){
            
                if (self.delegate && [self.delegate respondsToSelector:@selector(selectedIndex:)]) {
                    if (self.isSelced) {
                        [self.delegate selectedIndex:-self.trsNumber];
                    }else{
                        
                        [self.delegate selectedIndex:self.trsNumber];
                    }
                    
                    
                    [self removeFromSuperview];
                    
                }
                
                
            }else{
                _errorLabel2.text = NSLocalizedStringFromTable(@"Insufficientfunds",@"Internation", nil);
                NSLog(@"金额不足");
            }
            
        }else{
           _errorLabel2.text =  NSLocalizedStringFromTable(@"Notinpredictionrange",@"Internation", nil);
            NSLog(@"投注范围必必须在区间值");
            
        }
        
    }else if (self.toolOrderM){
        
        if (self.trsNumber<=0) {
            
            _errorLabel2.text = NSLocalizedStringFromTable(@"Please enter the estimated amount",@"Internation", nil);
            return;
        }
        
        if (self.trsNumber>=self.toolOrderM.minNub&&self.trsNumber<=self.toolOrderM.maxNub) {
            float jiner = 0;
            float trjin = 0;
            if ([self.toolOrderM.accept_asset isEqualToString:@"SEER"]) {
                jiner = [MoneyPacketManager moneyAcctountManager].surplus;
                trjin = self.trsNumber +5;
                
            }else if ([self.toolOrderM.accept_asset isEqualToString:@"USDT"]){
                jiner = [MoneyPacketManager moneyAcctountManager].usdt_surplus;
                trjin = self.trsNumber  +0.1;
                
            }else if ([self.toolOrderM.accept_asset isEqualToString:@"PFC"]){
                jiner = [MoneyPacketManager moneyAcctountManager].pdfc_surplus;
                trjin = self.trsNumber +0.00664;
                
            }
            NSNumber *a=[NSNumber numberWithFloat:jiner];
            NSNumber *b=[NSNumber numberWithInteger:trjin];
//            float jiner = [MoneyPacketManager moneyAcctountManager].surplus;
//            //        float trjin = [self.trsNumber floatValue] +2;
//            NSNumber *a=[NSNumber numberWithFloat:jiner];
//            NSNumber *b=[NSNumber numberWithInteger:self.trsNumber +4];
            
            if ([b compare:a]== NSOrderedAscending ||fabs(trjin-jiner) <= EPSILON){
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(selectedIndex:)]) {
                    if (self.isSelced) {
                         [self.delegate selectedIndex:-self.trsNumber];
                    }else{
                        
                         [self.delegate selectedIndex:self.trsNumber];
                        
                    }
                   
                    
                    [self removeFromSuperview];
                    
                }
                
                
            }else{
                
            _errorLabel2.text = NSLocalizedStringFromTable(@"Insufficientfunds",@"Internation", nil);
                NSLog(@"金额不足");
                
            }
            
        }else{
           
            _errorLabel2.text =  NSLocalizedStringFromTable(@"Notinpredictionrange",@"Internation", nil);
            NSLog(@"投注范围必必须在区间值");
            
        }
        
    }
        
  
   
    
    
}


- (void)selectedIndex:(NSInteger)index andText:(NSString *)text {
    self.errorLabel2.text = @"";
    if (index == 11) {
        text = @"";
    }
    
    NSString * str2 = [self.inputLabel.text stringByAppendingString:text];

    switch (index) {
        case 9:
            str2 = @"";
            self.errorLabel2.text =@"";
            break;
        case 10:
            
            break;
        case 11:
            if (str2.length>=1) {
                str2 = [str2 substringToIndex:[str2 length]-1];
                    self.buyLabel.text = @"";
                
            }else{
                
                str2 = @"";
                
            }
            
            
            break;
        default:
            break;
    }
    
    self.inputLabel.text = str2;
    
    self.trsNumber = [self.inputLabel.text floatValue];
    
    if (self.trsNumber) {
        if (self.preModel) {
            if (self.preModel.room_type == 0) {
                self.beforeBuy = 0;
                self.selecetBuy = 0;
                for (int i = 0; i<self.preModel.items_countNum.count;i++) {
                    self.beforeBuy+=exp([self.preModel.items_countNum[i] floatValue]/self.preModel.lmsr_number);
                }
                
                for (int j = 0; j<self.preModel.items_countNum.count; j++) {
                    if (j == self.indexpath) {
                        if (self.isSelced) {
                            if ([self.preModel.accept_asset isEqualToString:@"SEER"]||
                                [self.preModel.accept_asset isEqualToString:@"PFC"]) {
                                  self.selecetBuy += exp([self.preModel.items_countNum[j] floatValue]/self.preModel.lmsr_number +(-self.trsNumber)*100000/self.preModel.lmsr_number);
                            }else if ([self.preModel.accept_asset isEqualToString:@"USDT"]){
                                 self.selecetBuy += exp([self.preModel.items_countNum[j] floatValue]/self.preModel.lmsr_number +(-self.trsNumber)*100/self.preModel.lmsr_number);
                            }
                          
                        }else{
                            if ([self.preModel.accept_asset isEqualToString:@"SEER"]||[self.preModel.accept_asset isEqualToString:@"PFC"]){
                                 self.selecetBuy += exp([self.preModel.items_countNum[j] floatValue]/self.preModel.lmsr_number +(self.trsNumber)*100000/self.preModel.lmsr_number);
                            }else if ([self.preModel.accept_asset isEqualToString:@"USDT"]){
                                self.selecetBuy += exp([self.preModel.items_countNum[j] floatValue]/self.preModel.lmsr_number +(self.trsNumber)*100/self.preModel.lmsr_number);
                            }
                            
                           
                        }
                        
                    }else{
                        
                        self.selecetBuy += exp([self.preModel.items_countNum[j] floatValue]/self.preModel.lmsr_number);
                    }
                    
                    
                }
                float money = 0;
                if ([self.preModel.accept_asset isEqualToString:@"SEER"]||[self.preModel.accept_asset isEqualToString:@"PFC"]) {
                      money =((log(self.selecetBuy)-log(self.beforeBuy))*self.preModel.lmsr_number)/100000;
                }else if ([self.preModel.accept_asset isEqualToString:@"USDT"]){
                    money =((log(self.selecetBuy)-log(self.beforeBuy))*self.preModel.lmsr_number)/100;
                }
              
//                "Selling" = "卖出";
//                "Buying" = "买入";
//                "Shares Selling" = "份大概收入";
//                "Shaers Buing" = "份大概需要";
                 NSString *bizhong = @"";
                if (self.isSelced) {
                    if ([self.preModel.accept_asset isEqualToString:@"SEER"]) {
                        bizhong = @"SEER";
                    }else if ([self.preModel.accept_asset isEqualToString:@"USDT"]){
                        bizhong = @"USDT";
                    }else if ([self.preModel.accept_asset isEqualToString:@"USDT"]){
                        bizhong = @"PFC";
                    }
                    self.buyLabel.text =[NSString stringWithFormat:@"%@ %ld %@ %.5f%@ ",NSLocalizedStringFromTable(@"Selling",@"Internation", nil),(NSInteger)self.trsNumber ,NSLocalizedStringFromTable(@"Shares Selling",@"Internation", nil),-money,bizhong];
                }else{
                    if ([self.preModel.accept_asset isEqualToString:@"SEER"]) {
                        bizhong = @"SEER";
                    }else if ([self.preModel.accept_asset isEqualToString:@"USDT"]){
                        bizhong = @"USDT";
                    }else if ([self.preModel.accept_asset isEqualToString:@"USDT"]){
                         bizhong = @"PFC";
                    }
                     self.buyLabel.text =[NSString stringWithFormat:@"%@ %ld %@ %.5f %@",NSLocalizedStringFromTable(@"Buying",@"Internation", nil),(NSInteger)self.trsNumber ,NSLocalizedStringFromTable(@"Shares Buing",@"Internation", nil),money,bizhong];
                    
//                    self.buyLabel.text =[NSString stringWithFormat:@"购买%ld份大概需要%.5f SEER",(NSInteger)self.trsNumber ,money];
                }
                
            }
            
        }else if (self.toolOrderM){
            
            if (self.toolOrderM.room_type == 0) {
                self.beforeBuy = 0;
                self.selecetBuy = 0;
                for (int i = 0; i<self.toolOrderM.items_countNum.count;i++) {
                    self.beforeBuy+=exp([self.toolOrderM.items_countNum[i] floatValue]/self.toolOrderM.lmsr_number);
                }
                
                for (int j = 0; j<self.toolOrderM.items_countNum.count; j++) {
                    if (j == self.indexpath) {
                        if (self.isSelced) {
                            if ([self.toolOrderM.accept_asset isEqualToString:@"SEER"]
                                ||[self.toolOrderM.accept_asset isEqualToString:@"PFC"]){
                               self.selecetBuy += exp([self.toolOrderM.items_countNum[j] floatValue]/self.toolOrderM.lmsr_number +(-self.trsNumber)*100000/self.toolOrderM.lmsr_number);
                            }else if ([self.toolOrderM.accept_asset isEqualToString:@"USDT"]){
                                self.selecetBuy += exp([self.toolOrderM.items_countNum[j] floatValue]/self.toolOrderM.lmsr_number +(-self.trsNumber)*100/self.toolOrderM.lmsr_number);
                            }
                            
                        }else{
                            if ([self.toolOrderM.accept_asset isEqualToString:@"SEER"]||[self.toolOrderM.accept_asset isEqualToString:@"PFC"]){
                                   self.selecetBuy += exp([self.toolOrderM.items_countNum[j] floatValue]/self.toolOrderM.lmsr_number +(self.trsNumber)*100000/self.toolOrderM.lmsr_number);
                            }else if ([self.toolOrderM.accept_asset isEqualToString:@"USDT"]){
                                self.selecetBuy += exp([self.toolOrderM.items_countNum[j] floatValue]/self.toolOrderM.lmsr_number +(self.trsNumber)*100/self.toolOrderM.lmsr_number);
                            }
                        
                        }
                        
                    }else{
                        
                        self.selecetBuy += exp([self.toolOrderM.items_countNum[j] floatValue]/self.toolOrderM.lmsr_number);
                    }
                    
                    
                }
                float money =0;
                NSString *bizhong = @"";
                if ([self.toolOrderM.accept_asset isEqualToString:@"SEER"]){
                     money =((log(self.selecetBuy)-log(self.beforeBuy))*self.toolOrderM.lmsr_number)/100000;
                    bizhong = @"SEER";
                }else if ([self.toolOrderM.accept_asset isEqualToString:@"USDT"]){
                    money =((log(self.selecetBuy)-log(self.beforeBuy))*self.toolOrderM.lmsr_number)/100;
                    bizhong =@"USDT";
                }else if ([self.toolOrderM.accept_asset isEqualToString:@"PFC"]){
                    money =((log(self.selecetBuy)-log(self.beforeBuy))*self.toolOrderM.lmsr_number)/100000;
                    bizhong =@"PFC";
                }
                
               
                if (self.isSelced) {
                    //                    10. Selling XXX shares of SEER will cost about 5 SEER
                    //                    11. Buying XXX shares of SEER will cost about 5 SEER
                     self.buyLabel.text =[NSString stringWithFormat:@"%@ %ld %@ %.5f %@",NSLocalizedStringFromTable(@"Selling",@"Internation", nil),(NSInteger)self.trsNumber ,NSLocalizedStringFromTable(@"Shares Selling",@"Internation", nil),-money,bizhong];
//                    self.buyLabel.text =[NSString stringWithFormat:@"卖出%ld份大概收入%.5f SEER",(NSInteger)self.trsNumber ,-money];
                }else{
                      self.buyLabel.text =[NSString stringWithFormat:@"%@ %ld %@ %.5f %@",NSLocalizedStringFromTable(@"Buying",@"Internation", nil),(NSInteger)self.trsNumber ,NSLocalizedStringFromTable(@"Shares Buing",@"Internation", nil),money,bizhong];
//                    self.buyLabel.text =[NSString stringWithFormat:@"购买%ld份大概需要%.5f SEER",(NSInteger)self.trsNumber ,money];
                }
                
            }
            
        }
       
    }
    
    
    
 
}

-(void)setChoseStr:(NSString *)choseStr{
    _choseStr = choseStr;
    self.chooseLabel.text =choseStr;
    NSString *prMoney = NSLocalizedStringFromTable(@"PredictMoney",@"Internation", nil);
    if (self.preModel) {
        if ([self.preModel.accept_asset isEqualToString:@"USDT"]) {
            self.yuceLabel.text = [NSString stringWithFormat:@"%@ %ld - %ld USDT",prMoney,self.preModel.minNub,self.preModel.maxNub];
            self.yueLabel.text = [NSString stringWithFormat:@"%.4f USDT",[MoneyPacketManager moneyAcctountManager].usdt_surplus];
            self.seerMLabel.text = @"0.1 USDT";
        }else if ([self.preModel.accept_asset isEqualToString:@"SEER"]){
            self.yuceLabel.text = [NSString stringWithFormat:@"%@ %ld - %ld SEER",prMoney,self.preModel.minNub,self.preModel.maxNub];
            self.yueLabel.text = [NSString stringWithFormat:@"%.4f SEER",[MoneyPacketManager moneyAcctountManager].surplus];
            self.seerMLabel.text = @"5 SEER";

        }else if ([self.preModel.accept_asset isEqualToString:@"PFC"]){
            self.yuceLabel.text = [NSString stringWithFormat:@"%@ %ld - %ld PFC",prMoney,self.preModel.minNub,self.preModel.maxNub];
            self.yueLabel.text = [NSString stringWithFormat:@"%.4f PFC",[MoneyPacketManager moneyAcctountManager].surplus];
            self.seerMLabel.text = @"0.00665 PFC";
            
        }
//        self.yuceLabel.text = [NSString stringWithFormat:@"%@ %ld - %ld SEER",prMoney,self.preModel.minNub,self.preModel.maxNub];
//        self.yueLabel.text = [NSString stringWithFormat:@"%.4f SEER",[MoneyPacketManager moneyAcctountManager].surplus];
    }else if (self.toolOrderM){
        
        if ([self.toolOrderM.accept_asset isEqualToString:@"USDT"]) {
            self.yuceLabel.text = [NSString stringWithFormat:@"%@ %ld - %ld USDT",prMoney,self.toolOrderM.minNub,self.toolOrderM.maxNub];
            self.yueLabel.text = [NSString stringWithFormat:@"%.4f USDT",[MoneyPacketManager moneyAcctountManager].usdt_surplus];
            self.seerMLabel.text = @"0.1 USDT";
        }else if ([self.toolOrderM.accept_asset isEqualToString:@"SEER"]){
            
            self.yuceLabel.text = [NSString stringWithFormat:@"%@ %ld - %ld SEER",prMoney,self.toolOrderM.minNub,self.toolOrderM.maxNub];
            self.yueLabel.text = [NSString stringWithFormat:@"%.4f SEER",[MoneyPacketManager moneyAcctountManager].surplus];
             self.seerMLabel.text = @"5 SEER";
            
        }else if ([self.toolOrderM.accept_asset isEqualToString:@"PFC"]){
            self.yuceLabel.text = [NSString stringWithFormat:@"%@ %ld - %ld SEER",prMoney,self.toolOrderM.minNub,self.toolOrderM.maxNub];
            self.yueLabel.text = [NSString stringWithFormat:@"%.4f PFC",[MoneyPacketManager moneyAcctountManager].pdfc_surplus];
            self.seerMLabel.text = @"0.00665 PFC";
        }
//        self.yuceLabel.text = [NSString stringWithFormat:@"%@ %ld - %ld SEER",prMoney,self.toolOrderM.minNub,self.toolOrderM.maxNub];
//        self.yueLabel.text = [NSString stringWithFormat:@"%.4f SEER",[MoneyPacketManager moneyAcctountManager].surplus];
    }
  
}

- (void)setPreModel:(DetailsModel *)preModel{
    
    _preModel = preModel;
}


- (void)setToolOrderM:(OrderModel *)toolOrderM{
    
    _toolOrderM = toolOrderM;
}


//传值选项
-(void)setIndexpath:(NSInteger)indexpath{
    
    _indexpath = indexpath;
}


@end
