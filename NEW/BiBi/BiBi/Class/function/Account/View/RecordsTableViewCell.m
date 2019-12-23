//
//  RecordsTableViewCell.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/18.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "RecordsTableViewCell.h"
#import "OPModel.h"

@interface RecordsTableViewCell ()

@property(nonatomic,strong)UILabel *label;

//总共金额
@property(nonatomic,strong)UILabel *bigSeerLabel;
//转账金额
@property(nonatomic,strong)UILabel * rmbLabel;
//手续费
@property(nonatomic,strong)UILabel *tranfeerLabel;
//用户名
@property(nonatomic,strong)UILabel *trAcountLabel;
//时间
@property(nonatomic,strong)UILabel *timeLabel;
//交易Label
@property(nonatomic,strong)UILabel *jiaoyiLabel;


@end

@implementation RecordsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"accountTableViewCell";
    RecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell =[[RecordsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = [UIColor yellowColor];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        [self setupUI];
        //        self.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return self;
}

-(void)setupUI{
//    "Transaction Records" = "近期交易记录";
//    "Transaction Date" = "交易时间";
//    "Transaction Types" ="交易类型";
//    "Transaction Users" = "交易用户";
//    "Transaction Amount" = "交易金额";

    UILabel *timeLabel1 = [[UILabel alloc]init];
    timeLabel1.text = NSLocalizedStringFromTable(@"Transaction Date",@"Internation", nil);
    timeLabel1.font =  [UIFont fontWithName:@"PingFangSC-Medium" size: 10.7];
    timeLabel1.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    [self addSubview:timeLabel1];
    
    [timeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(13);
    }];
    
    UILabel *timeLabel = [[UILabel alloc]init];
    
    timeLabel.text =@"2018-8-31 16:34:23";
    
    timeLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 10.7];
    timeLabel.textColor =[UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    //时间赋值
    self.timeLabel = timeLabel;
    
    [self addSubview:self.timeLabel];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(timeLabel1.mas_right).offset(5);
        make.centerY.mas_equalTo(timeLabel1.mas_centerY);
    }];
    
    UILabel *typeLabel1 = [[UILabel alloc]init];
    typeLabel1.text = NSLocalizedStringFromTable(@"Transaction Types",@"Internation", nil);
    typeLabel1.font =  [UIFont fontWithName:@"PingFangSC-Medium" size: 10.7];
    typeLabel1.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    [self addSubview:typeLabel1];
    
    [typeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel1.mas_bottom).offset(8);
        make.left.mas_equalTo(timeLabel1.mas_left);
    }];
    
    
    UILabel *typeLabel = [[UILabel alloc]init];
    
    typeLabel.text =NSLocalizedStringFromTable(@"Transfertop",@"Internation", nil);
    
    typeLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 10.7];
    typeLabel.textColor =[UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    
    [self addSubview:typeLabel];
    
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(typeLabel1.mas_right).offset(8);
        make.centerY.mas_equalTo(typeLabel1.mas_centerY);
    }];
    
    UILabel *TracountLabel1 = [[UILabel alloc]init];
    
    TracountLabel1.text = NSLocalizedStringFromTable(@"Transaction Users",@"Internation", nil);
    TracountLabel1.font =  [UIFont fontWithName:@"PingFangSC-Medium" size: 10.7];
    TracountLabel1.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    [self addSubview:TracountLabel1];
    
    [TracountLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(typeLabel1.mas_bottom).offset(8);
        make.left.mas_equalTo(timeLabel1.mas_left);
    }];
    
    UILabel *trAcountLabel = [[UILabel alloc]init];
    //账户赋值
    trAcountLabel.text =@"wujianbin";
    
    trAcountLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 10.7];
    trAcountLabel.textColor =[UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    self.trAcountLabel = trAcountLabel;
    
    [self addSubview:trAcountLabel];
    
    [trAcountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(TracountLabel1.mas_right).offset(8);
        make.centerY.mas_equalTo(TracountLabel1.mas_centerY);
    }];
    
    
    
    
    
    
    
    //转账seer
    UILabel *bigSeerLabel = [[UILabel alloc]init];
    bigSeerLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 13.3];
    bigSeerLabel.textColor =[ UIColor colorWithRed:241/255.0 green:53/255.0 blue:53/255.0 alpha:1.0];
    bigSeerLabel.text =@"- 3541SEER";
    
    self.bigSeerLabel = bigSeerLabel;
    [self addSubview:bigSeerLabel];

    [bigSeerLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.mas_equalTo(timeLabel1.mas_centerY);
        make.right.mas_equalTo(-15*kWidthScale);
    }];
//
    //交易金额

    UILabel *rmbLabel = [[UILabel alloc]init];

    rmbLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 10.7];
    rmbLabel.text = @"3541.00";
    rmbLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    rmbLabel.numberOfLines = 0;
    self.rmbLabel = rmbLabel;

    [self addSubview:rmbLabel];
////
//
    [rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.mas_equalTo(-15*kWidthScale);
//        make.top.mas_equalTo(bigSeerLabel.mas_bottom).offset(6*kHeightScale);
        make.centerY.mas_equalTo(typeLabel.mas_centerY);
    }];
//
//    //交易金额
    UILabel *jiaoyi = [[UILabel alloc]init];
    jiaoyi.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 10.7];
    jiaoyi.text = NSLocalizedStringFromTable(@"Transaction Amount",@"Internation", nil);
    jiaoyi.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    self.jiaoyiLabel = jiaoyi;

    [self addSubview:jiaoyi];
//
    [jiaoyi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rmbLabel.mas_left).offset(-7);
        make.centerY.mas_equalTo(rmbLabel.mas_centerY);
//        make.top.mas_equalTo(rmbLabel.mas_bottom).offset(8);

    }];
//
//
//    //手续费
//
    UILabel *tranfeer = [[UILabel alloc]init];

    tranfeer.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 10.7];
    tranfeer.text = @"5.00";
    tranfeer.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    tranfeer.numberOfLines = 0;

    self.tranfeerLabel = tranfeer;
    [self addSubview:tranfeer];
//
    [tranfeer mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.mas_equalTo(-13*kWidthScale);
//        make.top.mas_equalTo(rmbLabel.mas_bottom).offset(6*kHeightScale);
        make.centerY.mas_equalTo(trAcountLabel.mas_centerY);
    }];
//
//
    UILabel *ferrLabel = [[UILabel alloc]init];
    ferrLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 10.7];
    ferrLabel.text = NSLocalizedStringFromTable(@"Transaction Fee",@"Internation", nil);

    ferrLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];

    [self addSubview:ferrLabel];

    [ferrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(jiaoyi.mas_left);
        make.centerY.mas_equalTo(tranfeer.mas_centerY);

    }];
//
//
//
//
//

}

//获取字符串长度
- (int)convertToByte:(NSString*)str {
    int strlength = 0;
    char* p = (char*)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength);
}


- (void)setHistoryModel:(TrAccountModel *)historyModel{
    
    _historyModel = historyModel;
    if ([historyModel.fromnName isEqualToString:M_userName]) {
        if ([historyModel.ass_id isEqualToString:@"1.3.0"]) {
            self.tranfeerLabel.text = [NSString stringWithFormat:@"%.2f",1.0*historyModel.feerCount/100000];
            self.rmbLabel.text = [NSString stringWithFormat:@"-%lld",historyModel.jinerCount/100000];
            self.rmbLabel.textColor = UIColorFromHexValue(0xF13535);
            self.jiaoyiLabel.textColor =UIColorFromHexValue(0xF13535);
            self.trAcountLabel.text = historyModel.tooName;
            self.bigSeerLabel.text = [NSString stringWithFormat:@"-%.2f",1.0*(historyModel.feerCount +historyModel.jinerCount)/100000];
            self.bigSeerLabel.textColor = UIColorFromHexValue(0xF13535);
        } else if ([historyModel.ass_id isEqualToString:@"1.3.5"]){
//            if (historyModel.feerCount == 200000) {
//                
//            }
//            (float)historyModel.feerCount;
            self.tranfeerLabel.text = [NSString stringWithFormat:@"%.2f",1.0*historyModel.feerCount/100];
            self.rmbLabel.text = [NSString stringWithFormat:@"-%lld",historyModel.jinerCount/100];
            self.rmbLabel.textColor = UIColorFromHexValue(0xF13535);
            self.jiaoyiLabel.textColor =UIColorFromHexValue(0xF13535);
            self.trAcountLabel.text = historyModel.tooName;
            self.bigSeerLabel.text = [NSString stringWithFormat:@"-%.2f",1.0*(historyModel.feerCount +historyModel.jinerCount)/100];
            self.bigSeerLabel.textColor = UIColorFromHexValue(0xF13535);
        }else if ([historyModel.ass_id isEqualToString:@"1.3.2"]){
            
            self.tranfeerLabel.text = [NSString stringWithFormat:@"%.5f",(1.0*historyModel.feerCount)/100000];
            self.tranfeerLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 9];
            self.rmbLabel.text = [NSString stringWithFormat:@"-%lld",historyModel.jinerCount/100000];
            self.rmbLabel.textColor = UIColorFromHexValue(0xF13535);
            self.jiaoyiLabel.textColor =UIColorFromHexValue(0xF13535);
            self.trAcountLabel.text = historyModel.tooName;
            self.bigSeerLabel.text = [NSString stringWithFormat:@"-%.5f",(1.0*historyModel.feerCount +historyModel.jinerCount)/100000];
            self.bigSeerLabel.textColor = UIColorFromHexValue(0xF13535);
        }
    }else{
        
        if ([historyModel.ass_id isEqualToString:@"1.3.0"]) {
            self.tranfeerLabel.text = [NSString stringWithFormat:@"%d.00",0];
            self.rmbLabel.text = [NSString stringWithFormat:@"+%lld",historyModel.jinerCount/100000];
            self.rmbLabel.textColor = UIColorFromHexValue(0x3AAF5A);
            self.jiaoyiLabel.textColor = UIColorFromHexValue(0x3AAF5A);
            self.trAcountLabel.text = historyModel.fromnName;
            self.bigSeerLabel.text = [NSString stringWithFormat:@"+%lld",(historyModel.jinerCount)/100000];
            self.bigSeerLabel.textColor =  UIColorFromHexValue(0x3AAF5A);

        }else if ([historyModel.ass_id isEqualToString:@"1.3.5"]){
            
            self.tranfeerLabel.text = [NSString stringWithFormat:@"%d.00",0];
            self.rmbLabel.text = [NSString stringWithFormat:@"+%lld",historyModel.jinerCount/100];
            self.rmbLabel.textColor = UIColorFromHexValue(0x3AAF5A);
            self.jiaoyiLabel.textColor = UIColorFromHexValue(0x3AAF5A);
            self.trAcountLabel.text = historyModel.fromnName;
            self.bigSeerLabel.text = [NSString stringWithFormat:@"+%lld",(historyModel.jinerCount)/100];
            self.bigSeerLabel.textColor =  UIColorFromHexValue(0x3AAF5A);
            
        }else if ([historyModel.ass_id isEqualToString:@"1.3.2"]){
            self.tranfeerLabel.text = [NSString stringWithFormat:@"%d.00",0];
            self.rmbLabel.text = [NSString stringWithFormat:@"+%lld",historyModel.jinerCount/100000];
            self.rmbLabel.textColor = UIColorFromHexValue(0x3AAF5A);
            self.jiaoyiLabel.textColor = UIColorFromHexValue(0x3AAF5A);
            self.trAcountLabel.text = historyModel.fromnName;
            self.bigSeerLabel.text = [NSString stringWithFormat:@"+%lld",(historyModel.jinerCount)/100000];
            self.bigSeerLabel.textColor =  UIColorFromHexValue(0x3AAF5A);
            
            
        }
        
       
        
        
    }
    
//    self.tranfeerLabel.text = [NSString stringWithFormat:@"%lld.00",historyModel.feerCount/100000];
//    self.rmbLabel.text = [NSString stringWithFormat:@"%lld",historyModel.jinerCount/100000];
//    self.bigSeerLabel.text = [NSString stringWithFormat:@"%lld SEER",(historyModel.feerCount +historyModel.jinerCount)/100000];
//    self.trAcountLabel.text =historyModel.tooName;
//
    self.timeLabel.text = historyModel.dataTime;
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
