//
//  NewOrderHeaderView.m
//  BiBi
//
//  Created by 武建斌 on 2019/4/10.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "NewOrderHeaderView.h"
//#import "CPTopAnimationView.h"
//#import "SEERTopAnimationView.h"
@interface NewOrderHeaderView ()

//显示钱包的label
//@property(nonatomic,strong)UILabel *SEERlabel;

//seer的label
//@property(nonatomic,strong)UIImageView *SEERImgeView;

//累计收益

@property(nonatomic,strong)UILabel *gongLabel;

//金额
@property(nonatomic,strong)UILabel *jinerLabel;

//订单
@property(nonatomic,strong)UIView *orderView;

//胜场
@property(nonatomic,strong)UIView *winerView;

//胜率
@property(nonatomic,strong)UIView *oddsView;

//订单
@property(nonatomic,strong)UILabel *orderLabel;

//胜场
@property(nonatomic,strong)UILabel *winerLabel;

//胜率
@property(nonatomic,strong)UILabel *oddsLabel;


////进行中 待结算 已结束
//@property(nonatomic,strong)CPTopAnimationView *headerView;

//待结算标志
@property(nonatomic,assign)NSInteger flag;

////货币
//@property(nonatomic,strong)SEERTopAnimationView *seerTopView;

//货币切换标志
@property(nonatomic,assign)NSInteger seerFlag;

@end

@implementation NewOrderHeaderView

//-(instancetype)initWithFrame:(CGRect)frame{
//    
//    if (self = [super initWithFrame:frame]) {
//        [self setupUI];
//        
//    }
//    return self;
//}

-(instancetype)initWith:(NSArray *)arry andFlag:(NSInteger)flag andtopFlag:(NSInteger)topFlag{
    
    if (self = [super init]) {
        [self setupUI:arry andFlag:flag andtopFlag:topFlag];
        
    }
    
    return self;
}




-(void)setupUI:(NSArray*)totalArry andFlag:(NSInteger)flag andtopFlag:(NSInteger)topFlag{
    __weak typeof(self) _self = self;
    UIView *bagView = [[UIView alloc]init];
    
    bagView.backgroundColor = [UIColor whiteColor];
    bagView.layer.cornerRadius = 15;
    [self addSubview:bagView];
    
    [bagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(180);
    }];
//    self.seerFlag = 1;
//    NSString * jarry;
//    NSMutableArray *mrArry = [NSMutableArray arrayWithCapacity:10];
//    for (int i =0; i<totalArry.count; i++) {
//        jarry = totalArry[i][0];
//        if ([jarry isEqualToString:@"1.30"]) {
//            jarry = @"SEER";
//        }else if ([jarry isEqualToString:@"1.3.2"]){
//            jarry = @"USDT";
//        }
//        [mrArry addObject:jarry];
//    }
    
     NSArray * currencyArray = @[@"SEER"];
//    NSArray * currencyArray = @[@""];
    if (totalArry.count>0) {
        _seerTopView  =  [[SEERTopAnimationView alloc] initWithFrame:CGRectMake(0, 10, kScreenW, 35) WithTitles:totalArry flag:flag andbool:YES];
    }else{
        _seerTopView  =  [[SEERTopAnimationView alloc] initWithFrame:CGRectMake(0, 10, kScreenW, 35) WithTitles:currencyArray flag:flag andbool:NO];
    }
//    _seerTopView  =  [[SEERTopAnimationView alloc] initWithFrame:CGRectMake(0, 10, kScreenW, 35) WithTitles:currencyArray flag:self.seerFlag-1];
    [bagView addSubview:_seerTopView];
    _seerTopView.backgroundColor = [UIColor clearColor];
    _seerTopView.seerpe = ^(NSInteger index) {
        _self.seerFlag = index;
//        if (totalArry.count == 1&&index ==1) {
//            _self.counRmb = [totalArry[0][1] floatValue];
//        }else if (totalArry.count ==2){
//            if (index == 1) {
//                 _self.counRmb = [totalArry[0][1] floatValue];
//            }else if (index ==2){
//                _self.counRmb = [totalArry[1][1] floatValue];
//            }
//        }
    };
    
    
    
//    self.SEERImgeView = [[UIImageView alloc]init];
//    self.SEERImgeView.image = [UIImage imageNamed:@"wallet_N"];
//    [bagView addSubview:self.SEERImgeView];
//
//    [self.SEERImgeView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.mas_equalTo(12);
//        make.top.mas_equalTo(12);
//        make.size.mas_equalTo(CGSizeMake(20, 20));
//
//    }];
//
//    self.SEERlabel = [[UILabel alloc]init];
//    self.SEERlabel.text = @"SEER";
//    self.SEERlabel.textColor = UIColorFromHexValue(0x444444);
//    self.SEERlabel.font =[UIFont fontWithName:@"PingFangSC-Medium" size: 14];
//    [bagView addSubview:self.SEERlabel];
//
//    [self.SEERlabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.SEERImgeView.mas_right).offset(2);
//        make.centerY.mas_equalTo(self.SEERImgeView.mas_centerY);
//
//    }];
//    //下划线
//    UIView *line1 = [[UIView alloc]init];
//    line1.backgroundColor = UIColorFromHexValue(0x2A7DDF);
//    line1.layer.cornerRadius = 1.3;
//    [bagView addSubview:line1];
//
//    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.SEERlabel.mas_bottom).offset(2);
//        make.left.mas_equalTo(self.SEERlabel.mas_left).offset(-5);
//        make.size.mas_equalTo(CGSizeMake(26, 3));
//
//    }];
//
    self.gongLabel = [[UILabel alloc]init];
    //    "Profits in Total" ="累计收益";
    //    "Orders" = "订单";
    //    "Win" = "胜场";
    //    "WinRate" = "胜率";
    //    "Ongoing" = "进行中";
    self.gongLabel.text =NSLocalizedStringFromTable(@"Profits in Total",@"Internation", nil);
    self.gongLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
    self.gongLabel.textColor = UIColorFromHexValue(0x444444);
    [bagView addSubview:self.gongLabel];

    [self.gongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.seerTopView.mas_left).offset(12);
        make.top.mas_equalTo(self.seerTopView.mas_bottom).offset(20);
    }];

    self.jinerLabel = [[UILabel alloc]init];

    self.jinerLabel.text = @"0.0000";
    self.jinerLabel.textColor = UIColorFromHexValue(0x444444);
    self.jinerLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 22];
    [bagView addSubview:self.jinerLabel];

    [self.jinerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.gongLabel.mas_left);
        make.top.mas_equalTo(self.gongLabel.mas_bottom).offset(14);
    }];

    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0 alpha:1.0];
    [bagView addSubview:line2];

    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bagView);
        make.right.mas_equalTo(bagView);
        make.height.mas_equalTo(0.3);
        make.top.mas_equalTo(self.jinerLabel.mas_bottom).offset(17);
    }];

    UIView *toolView = [[UIView alloc]init];
    //    toolView.backgroundColor = [UIColor greenColor];
    [bagView addSubview:toolView];

    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).offset(2);
        make.left.right.mas_equalTo(bagView);
        make.height.mas_equalTo(35);
    }];

    //订单
    self.orderView = [[UIView alloc]init];
    //    self.orderView.backgroundColor = [UIColor redColor];
    [toolView addSubview:self.orderView];

    //订单label；
    UILabel *orderLabel1 = [[UILabel alloc]init];
    orderLabel1.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
    orderLabel1.text =NSLocalizedStringFromTable(@"Orders",@"Internation", nil);
    orderLabel1.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    [self.orderView addSubview:orderLabel1];

    self.orderLabel = [[UILabel alloc]init];
    self.orderLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
    self.orderLabel.textColor = UIColorFromHexValue(0x2A7DDF);
    self.orderLabel.text = @"0";

    [self.orderView addSubview:self.orderLabel];


    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = UIColorFromHexValue(0xe0e0e0);
    [bagView addSubview:line3];

    //胜场
    self.winerView = [[UIView alloc]init];
    //    self.winerView.backgroundColor =[UIColor purpleColor];
    [toolView addSubview:self.winerView];
    //胜场
    UILabel *winerLabel1 = [[UILabel alloc]init];
    winerLabel1.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
    winerLabel1.text =NSLocalizedStringFromTable(@"Win",@"Internation", nil);
    winerLabel1.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    [self.winerView addSubview:winerLabel1];

    self.winerLabel = [[UILabel alloc]init];
    self.winerLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
    self.winerLabel.textColor = UIColorFromHexValue(0x2A7DDF);
    self.winerLabel.text = @"0";
    [self.winerView addSubview:self.winerLabel];


    UIView *line4 = [[UIView alloc]init];
    line4.backgroundColor = UIColorFromHexValue(0xe0e0e0);
    [bagView addSubview:line4];

    //胜率
    self.oddsView = [[UIView alloc]init];
    //    self.oddsView.backgroundColor = [UIColor blueColor];
    [toolView addSubview:self.oddsView];


    UILabel *oddLabel1 = [[UILabel alloc]init];
    oddLabel1.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
    oddLabel1.text =NSLocalizedStringFromTable(@"WinRate",@"Internation", nil);
    oddLabel1.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    [self.oddsView addSubview:oddLabel1];

    self.oddsLabel = [[UILabel alloc]init];
    self.oddsLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
    self.oddsLabel.textColor = UIColorFromHexValue(0x2A7DDF);
    self.oddsLabel.text = @"0%";
    [self.oddsView addSubview: self.oddsLabel];






    CGFloat bottomW = (ScreenWidth -30)/3;

    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(5);
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(bottomW);

    }];

    [orderLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);

    }];

    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(orderLabel1.mas_right).offset(15);
        make.centerY.mas_equalTo(0);

    }];


    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(toolView.mas_centerY);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(2);
        make.left.mas_equalTo(self.orderView.mas_right);
    }];



    [self.winerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.orderView.mas_centerY);
        make.left.mas_equalTo(self.orderView.mas_right);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(bottomW);
    }];


    [winerLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).offset(-20);
        make.centerY.mas_equalTo(0);
    }];

    [self.winerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(winerLabel1.mas_right).offset(15);
    }];




    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(toolView.mas_centerY);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(2);
        make.left.mas_equalTo(self.winerView.mas_right);
    }];


    [self.oddsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.orderView.mas_centerY);
        make.left.mas_equalTo(self.winerView.mas_right);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(bottomW);
    }];

    [self.oddsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);

    }];

    [oddLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.mas_equalTo(self.oddsLabel.mas_left).offset(-15);
        make.centerY.mas_equalTo(0);

    }];

//
//    self.flag = 1;
    NSArray * itemArray = @[NSLocalizedStringFromTable(@"Ongoing",@"Internation", nil),NSLocalizedStringFromTable(@"To Be Settled",@"Internation", nil),NSLocalizedStringFromTable(@"Ended",@"Internation", nil)];
    _headerView  =  [[CPTopAnimationView alloc] initWithFrame:CGRectMake(0, 260-44, kScreenW, 44) WithTitles:itemArray flag:topFlag];
    [self addSubview:_headerView];
    _headerView.backgroundColor = [UIColor clearColor];

//    __weak typeof(self) _self = self;
//    _headerView.swipe = ^(NSInteger index) {
//        _self.flag = index;
//    };
    
}

-(void)setCountNmb:(NSInteger)countNmb{
    
     _countNmb = countNmb;
    self.orderLabel.text = [NSString stringWithFormat:@"%ld",countNmb];
}

//-(void)setCounRmb:(float)counRmb{
//    _counRmb = counRmb;
//    self.jinerLabel.text = [NSString stringWithFormat:@"%f",counRmb];
//    
//}

-(void)setSuncedCount:(NSInteger)suncedCount{
    _suncedCount = suncedCount;
    self.winerLabel.text =[NSString stringWithFormat:@"%ld",suncedCount];
    
}

-(void)setLeiji:(NSString *)leiji{
    _leiji = leiji;
    self.jinerLabel.text = leiji;
}

-(void)setPrendStr:(float)prendStr{
    _prendStr = prendStr;
    self.oddsLabel.text = [NSString stringWithFormat:@"%.1f%%",prendStr*100];
}
@end
