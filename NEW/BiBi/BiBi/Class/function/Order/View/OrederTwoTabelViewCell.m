//
//  OrederTwoTabelViewCell.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/9.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "OrederTwoTabelViewCell.h"

@implementation OrederTwoTabelViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"walletwujianbin";
    OrederTwoTabelViewCell*cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell =[[ OrederTwoTabelViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = UIColorFromHexValue(0xf4f6fd);
        //        cell.backgroundColor = [UIColor whiteColor];
        //                cell.contentView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];;
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

//内容
-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.text = @"我弄点饭女方的不耐烦不耐烦该板块的烦恼不多付款了不耐烦地离不开是；京东方来几个房贷了感";
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = UIColorFromHexValue(0x444444);
        _contentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
    }
    
    return _contentLabel;
}

//竞猜记录
-(UILabel *)sumLabel{
    if (!_sumLabel) {
        _sumLabel = [[UILabel alloc]init];
        _sumLabel.textColor =UIColorFromHexValue(0x2A7DDF);
        _sumLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 14];
        _sumLabel.text = @"5 SEER";
    }
    
    return _sumLabel;
}


-(UILabel *)guessLabel{
    
    if (!_guessLabel) {
        _guessLabel = [[UILabel alloc]init];
        _guessLabel.textColor =UIColorFromHexValue(0x2A7DDF);
        _guessLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 14];
        _guessLabel.text =@"是";
    }
    
    
    return _guessLabel;
}


-(UILabel *)timeOutLabel{
    
    if (!_timeOutLabel) {
        _timeOutLabel = [[UILabel alloc]init];
        _timeOutLabel.textColor = UIColorFromHexValue(0x2A7DDF);
        _timeOutLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size: 10.7];
        _timeOutLabel.text = @"参与时间: 2018-8-3 18:00:00";
    }
    
    return _timeOutLabel;
}


-(UILabel *)winnLabel{
    
    if (!_winnLabel) {
        _winnLabel = [[UILabel alloc]init];
        _winnLabel.textColor = UIColorFromHexValue(0x34AD56);
        _winnLabel.font =[UIFont fontWithName:@"PingFangSC-Medium" size: 14];
        _winnLabel.text = @"456753";
    }
    return _winnLabel;
}





-(void)setupUI{
    
    
    UIView *bagView = [[UIView alloc]init];
    bagView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:bagView];
    //    CGFloat totalHeight = self.orderM.hight;
    
    [bagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(self.orderM.hight);
    }];
    
    
    [bagView addSubview:self.contentLabel];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [bagView addSubview:self.guessLabel];
    [self.guessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.contentLabel.mas_left);
    }];
    
    
    [bagView addSubview:self.sumLabel];
    
    [self.sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.guessLabel.mas_right).offset(15);
        make.centerY.mas_equalTo(self.guessLabel.mas_centerY);
    }];
    
    
    [bagView addSubview:self.timeOutLabel];
    
    [self.timeOutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sumLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.guessLabel.mas_left);
    }];
    
    [bagView addSubview:self.winnLabel];
    
    [self.winnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.guessLabel.mas_centerY);
        
    }];
    
    
    
    UIView *line1 = [[UIView alloc]init];
    
    line1.backgroundColor = UIColorFromHexValue(0x444444);
    line1.alpha = 0.3;
    [bagView addSubview:line1];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(0);
        make.bottom.mas_equalTo(bagView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    
    
    
}


//-(void)setOrderM:(OrderModel *)orderM{
//    
//    _orderM = orderM;
//    self.winnLabel.hidden = YES;
//    self.contentLabel.text = orderM.contentStr;
//    self.sumLabel.text = [NSString stringWithFormat:@"%.f SEER",orderM.amount/100000];
//    self.guessLabel.text = orderM.chooseStr;
//    self.timeOutLabel.text = orderM.timeOutStr;
//    
//    
//    [self setupUI];
//    
//}



-(void)setOrderW:(OrderModel *)orderW{
    
    _orderW = orderW;
    
    
    self.contentLabel.text = orderW.contentStr;
    self.sumLabel.text = [NSString stringWithFormat:@"%.5f SEER",orderW.amount/100000];
    self.guessLabel.text = orderW.chooseStr;
    self.timeOutLabel.text = orderW.timeOutStr;
    if (orderW.reward) {
        self.winnLabel.text = [NSString stringWithFormat:@"+ %5.f SEER",orderW.reward/100000];
        self.winnLabel.textColor = UIColorFromHexValue(0x34AD56);
        self.winnLabel.hidden = NO;
    }else{
        
        self.winnLabel.text = @"未中奖";
        self.winnLabel.textColor = [UIColor redColor];
        self.winnLabel.hidden = NO;
    }
    
    
    
    
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
