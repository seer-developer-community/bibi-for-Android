//
//  OrderFirstTableViewCell.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/8.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "OrderFirstTableViewCell.h"

@interface OrderFirstTableViewCell ()
//显示钱包的label
@property(nonatomic,strong)UILabel *SEERlabel;

//seer的label
@property(nonatomic,strong)UIImageView *SEERImgeView;

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


@end

@implementation OrderFirstTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"walletorder";
    OrderFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell =[[OrderFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = UIColorFromHexValue(0xf4f6fd);
        
//        cell.backgroundColor = [UIColor yellowColor];
//                cell.contentView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        [self setupUI];
    }
    return self;
}




-(void)setupUI{
    
    UIView *bagView = [[UIView alloc]init];
    
    bagView.backgroundColor = [UIColor whiteColor];
    bagView.layer.cornerRadius = 15;
    [self addSubview:bagView];
    
    [bagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(self);
    }];
    
    
    
    self.SEERImgeView = [[UIImageView alloc]init];
    self.SEERImgeView.image = [UIImage imageNamed:@"wallet_N"];
    [bagView addSubview:self.SEERImgeView];
    
    [self.SEERImgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(12);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        
    }];
    
    self.SEERlabel = [[UILabel alloc]init];
    self.SEERlabel.text = @"SEER";
    self.SEERlabel.textColor = UIColorFromHexValue(0x444444);
    self.SEERlabel.font =[UIFont fontWithName:@"PingFangSC-Medium" size: 14];
    [bagView addSubview:self.SEERlabel];
    
    [self.SEERlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.SEERImgeView.mas_right).offset(2);
        make.centerY.mas_equalTo(self.SEERImgeView.mas_centerY);
        
    }];
    //下划线
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = UIColorFromHexValue(0x2A7DDF);
    line1.layer.cornerRadius = 1.3;
    [bagView addSubview:line1];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.SEERlabel.mas_bottom).offset(2);
        make.left.mas_equalTo(self.SEERlabel.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(26, 3));
        
    }];
    
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
        make.left.mas_equalTo(self.SEERImgeView.mas_left);
        make.top.mas_equalTo(self.SEERImgeView.mas_bottom).offset(20);
    }];
    
    self.jinerLabel = [[UILabel alloc]init];
    
    self.jinerLabel.text = @"35694.34";
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
    self.orderLabel.text = @"0";
    [self.orderView addSubview:orderLabel1];
    
    self.orderLabel = [[UILabel alloc]init];
    self.orderLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
    self.orderLabel.textColor = UIColorFromHexValue(0x2A7DDF);
   
    
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
    self.winerLabel.text = @"16";
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
    
    
    
    
    
    
    
}


-(void)setCountNmb:(NSInteger)countNmb{
    
    _countNmb =countNmb;
     self.orderLabel.text = [NSString stringWithFormat:@"%ld",self.countNmb];
    
}

-(void)setCounRmb:(float)counRmb{
    
    _counRmb = counRmb;
    
    self.jinerLabel.text = [NSString stringWithFormat:@"%.4f SEER",counRmb/100000];
}

-(void)setSuncedCount:(NSInteger)suncedCount{
    _suncedCount = suncedCount;
    
    self.winerLabel.text = [NSString stringWithFormat:@"%ld",suncedCount];
    
}

-(void)setPrendStr:(float)prendStr{
    _prendStr = prendStr;
    NSInteger persentNum = (NSInteger)(prendStr * 100);
    self.oddsLabel.text = [NSString stringWithFormat:@"%ld%%",(long)persentNum];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
