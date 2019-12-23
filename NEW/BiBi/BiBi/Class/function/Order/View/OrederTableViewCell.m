//
//  OrederTableViewCell.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/7.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "OrederTableViewCell.h"

@implementation OrederTableViewCell



+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"walletwozaizhongbatong";
    OrederTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell =[[OrederTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        cell.cellIdenx = indexnum;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = UIColorFromHexValue(0xf4f6fd);
//        NSLog(@"窝巢%ld",cell.cellIdenx);
//        cell.contentView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
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
        
//        _contentLabel.backgroundColor = [UIColor yellowColor];
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
//        _sumLabel.backgroundColor = [UIColor redColor];
    }
    
    return _sumLabel;
}


-(UILabel *)guessLabel{
    
    if (!_guessLabel) {
        _guessLabel = [[UILabel alloc]init];
        _guessLabel.textColor =UIColorFromHexValue(0x2A7DDF);
        _guessLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 14];
        _guessLabel.text =@"是";
//        _guessLabel.backgroundColor = [UIColor redColor];
    }
    
    return _guessLabel;
}


//份数金额

-(UILabel *)piadLabel{
    
    if (!_piadLabel) {
        _piadLabel = [[UILabel alloc]init];
        _piadLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 14];
        _piadLabel.textColor = [UIColor greenColor];
        _piadLabel.text =@"收入2.3341 SEER";
//        _piadLabel.hidden = YES;
    }
    
    return _piadLabel;
}


-(UILabel *)timeOutLabel{
    
    if (!_timeOutLabel) {
        _timeOutLabel = [[UILabel alloc]init];
        _timeOutLabel.textColor = UIColorFromHexValue(0x2A7DDF);
        _timeOutLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size: 10.7];
        _timeOutLabel.text = @"参与时间: 2018-8-3 18:00:00";
//        _timeOutLabel.backgroundColor = [UIColor blueColor];
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


-(UIView *)bagView{
    
    if (!_bagView) {
      _bagView = [[UIView alloc]init];
    _bagView.backgroundColor = [UIColor whiteColor];
    }
    
    return _bagView;
}


-(UIView *)line1{
    
    
    if (!_line1) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = UIColorFromHexValue(0x444444);
        _line1.alpha = 0.3;

    }
    
    return _line1;
}


-(void)setupUI{
    
    [self.contentView addSubview:self.bagView];
//    CGFloat totalHeight = self.orderW.hight;
//    self.bagView.backgroundColor = [UIColor redColor];
    [self.bagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(0);
    }];
    
    
    [self.bagView addSubview:self.contentLabel];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self.bagView addSubview:self.guessLabel];
    [self.guessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.contentLabel.mas_left);
    }];
    
    
    [self.bagView addSubview:self.sumLabel];
    
    [self.sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.guessLabel.mas_right).offset(15);
        make.centerY.mas_equalTo(self.guessLabel.mas_centerY);
    }];
    
    [self.bagView addSubview:self.piadLabel];
//    self.piadLabel.hidden = YES;
    [self.piadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.guessLabel.mas_left);
        make.top.mas_equalTo(self.guessLabel.mas_bottom).offset(15);
    }];
    
    [self.bagView addSubview:self.timeOutLabel];
    
    [self.timeOutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bagView.mas_bottom).offset(-10);
        make.left.mas_equalTo(self.guessLabel.mas_left);
    }];
    
    [self.bagView addSubview:self.winnLabel];
    
    [self.winnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.guessLabel.mas_centerY);
        
    }];
 
    
    
 
    
   
    [self.bagView addSubview:self.line1];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bagView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    
    
    
}


-(void)setOrderM:(OrderModel *)orderM{
    
    _orderM = orderM;
    self.winnLabel.hidden = YES;
    self.contentLabel.text = [self handleStringWithString:orderM.contentStr];
    self.contentLabel.text = [self handleStringWithString2:self.contentLabel.text];
    if (orderM.room_type == 1) {
        if ([orderM.accept_asset isEqualToString:@"SEER"]) {
             self.sumLabel.text = [NSString stringWithFormat:@"%.f SEER",orderM.amount/100000];
        }else if([orderM.accept_asset isEqualToString:@"USDT"]){
              self.sumLabel.text = [NSString stringWithFormat:@"%.f USDT",orderM.amount/100];
        }else if([orderM.accept_asset isEqualToString:@"PFC"]){
               self.sumLabel.text = [NSString stringWithFormat:@"%.f PFC",orderM.amount/100000];
            
        }
       
        self.piadLabel.hidden = YES;
    }
    if (orderM.room_type == 2) {
         self.piadLabel.hidden = YES;
//        float num =(orderM.amount/100000)/([self.orderM.awards[orderM.choosenumber]floatValue]/10000);
//         self.sumLabel.text = [NSString stringWithFormat:@"%.f SEER(x0.1)",orderM.amount/100000];
        NSString *sumlabelStr;
        if ([orderM.accept_asset isEqualToString:@"SEER"]) {
           sumlabelStr = [NSString stringWithFormat:@"%f",orderM.paid/100000];
            self.sumLabel.text = [NSString stringWithFormat:@"%@ SEER(X%.2f)",[self removeFloatAllZeroByString:sumlabelStr],[self.orderM.awards[orderM.choosenumber]floatValue]/10000];
        }else if ([orderM.accept_asset isEqualToString:@"USDT"]){
           sumlabelStr = [NSString stringWithFormat:@"%f",orderM.paid/100];
            
            self.sumLabel.text = [NSString stringWithFormat:@"%@ USDT(X%.2f)",[self removeFloatAllZeroByString:sumlabelStr]
                                  ,[self.orderM.awards[orderM.choosenumber]floatValue]/10000];
        }else if ([orderM.accept_asset isEqualToString:@"PFC"]){
            sumlabelStr = [NSString stringWithFormat:@"%f",orderM.paid/100000];
            self.sumLabel.text = [NSString stringWithFormat:@"%@ SEER(X%.2f)",[self removeFloatAllZeroByString:sumlabelStr],[self.orderM.awards[orderM.choosenumber]floatValue]/10000];
        }
       
    }if (orderM.room_type == 0) {
        self.piadLabel.hidden = NO;
        NSString *PortionStr =  NSLocalizedStringFromTable(@"Portion",@"Internation", nil);
        NSString *SpendingStr = NSLocalizedStringFromTable(@"Spending",@"Internation", nil);
        NSString *IncomeStr = NSLocalizedStringFromTable(@"Income",@"Internation", nil);
        if ([orderM.accept_asset isEqualToString:@"SEER"]) {
           self.sumLabel.text = [NSString stringWithFormat:@"%.f %@",orderM.amount/100000,PortionStr];
        }else if ([orderM.accept_asset isEqualToString:@"USDT"]){
             self.sumLabel.text = [NSString stringWithFormat:@"%.f %@",orderM.amount/100,PortionStr];
        }else if ([orderM.accept_asset isEqualToString:@"PFC"]){
            self.sumLabel.text = [NSString stringWithFormat:@"%.f %@",orderM.amount/100000,PortionStr];
        }
        
        if (self.orderM.paid>0) {
            if ([orderM.accept_asset isEqualToString:@"SEER"]){
               self.piadLabel.text = [NSString stringWithFormat:@"%@ %.5f SEER",SpendingStr,(orderM.paid/100000)];
            }else if ([orderM.accept_asset isEqualToString:@"USDT"]){
                  self.piadLabel.text = [NSString stringWithFormat:@"%@ %.5f USDT",SpendingStr,(orderM.paid/100)];
            }else if ([orderM.accept_asset isEqualToString:@"PFC"]){
                 self.piadLabel.text = [NSString stringWithFormat:@"%@ %.5f PFC",SpendingStr,(orderM.paid/100000)];
            }
           
            self.piadLabel.textColor = [UIColor redColor];
        }else{
            if ([orderM.accept_asset isEqualToString:@"SEER"]){
               self.piadLabel.text = [NSString stringWithFormat:@"%@ %.5f SEER",IncomeStr,(-orderM.paid/100000)];
            }else if ([orderM.accept_asset isEqualToString:@"USDT"]){
                   self.piadLabel.text = [NSString stringWithFormat:@"%@ %.5f USDT",IncomeStr,(-orderM.paid/100)];
            }else if ([orderM.accept_asset isEqualToString:@"PFC"]){
                 self.piadLabel.text = [NSString stringWithFormat:@"%@ %.5f SEER",IncomeStr,(-orderM.paid/100000)];
                
            }
            
            self.piadLabel.textColor = UIColorFromHexValue(0x34AD56);
        }
        
        
    }
    
    NSString *ParticipationTime = NSLocalizedStringFromTable(@"Participation Time",@"Internation", nil);
    NSString *timeOutStrEN =[orderM valueForKey:NSLocalizedStringFromTable(@"timeOutStrEN",@"Internation", nil)];
    self.guessLabel.text = orderM.chooseStr;
    if (orderM.orderIndex == 2) {
        
        if (orderM.reward>0) {
            NSString *  winnStr =@"";
            NSString *bizhong = @"";
            if ([orderM.accept_asset isEqualToString:@"SEER"]){
                winnStr = [self removeFloatAllZeroByString:[NSString stringWithFormat:@"%.4f",orderM.reward/100000.00]];
                bizhong =@"SEER";
            }else if ([orderM.accept_asset isEqualToString:@"USDT"]){
                 winnStr = [self removeFloatAllZeroByString:[NSString stringWithFormat:@"%.4f",orderM.reward/100.00]];
                bizhong =@"USDT";
            }else if ([orderM.accept_asset isEqualToString:@"PFC"]){
                winnStr = [self removeFloatAllZeroByString:[NSString stringWithFormat:@"%.4f",orderM.reward/100000.00]];
                bizhong =@"PFC";
                
            }
            self.winnLabel.text = [NSString stringWithFormat:@"+%@ %@",winnStr,bizhong];
            self.winnLabel.textColor = UIColorFromHexValue(0x34AD56);
            self.winnLabel.hidden = NO;
//            NSLog(@"进来多少次");
        }else {
            self.winnLabel.text = NSLocalizedStringFromTable(@"Not winning",@"Internation", nil);
            self.winnLabel.textColor = [UIColor redColor];
            self.winnLabel.hidden = NO;
//             NSLog(@"没有进来多少次");
        }
    
    }

    self.timeOutLabel.text = [NSString stringWithFormat:@"%@%@",ParticipationTime,timeOutStrEN];
    [self setupUI];
    
}


-(void)setOrderH:(OrderModel *)orderH{
    _orderH = orderH;
    self.winnLabel.hidden = YES;
    //内容
    self.contentLabel.text = [self handleStringWithString:orderH.contentStr];
    self.contentLabel.text = [self handleStringWithString2:self.contentLabel.text];
    if (orderH.room_type == 1) {
        
        self.sumLabel.text = [NSString stringWithFormat:@"%.f SEER",orderH.amount/100000];
        self.piadLabel.hidden = YES;
    }
    if (orderH.room_type == 2) {
        self.piadLabel.hidden = YES;
        //        float num =(orderM.amount/100000)/([self.orderM.awards[orderM.choosenumber]floatValue]/10000);
        //         self.sumLabel.text = [NSString stringWithFormat:@"%.f SEER(x0.1)",orderM.amount/100000];
        NSString *sumlabelStr = [NSString stringWithFormat:@"%f",orderH.paid/100000];
        self.sumLabel.text = [NSString stringWithFormat:@"%@ SEER(X%.2f)",[self removeFloatAllZeroByString:sumlabelStr],[self.orderM.awards[orderH.choosenumber]floatValue]/10000];
    }if (orderH.room_type == 0) {
        self.piadLabel.hidden = NO;
        NSString *PortionStr =  NSLocalizedStringFromTable(@"Portion",@"Internation", nil);
        NSString *SpendingStr = NSLocalizedStringFromTable(@"Spending",@"Internation", nil);
        NSString *IncomeStr = NSLocalizedStringFromTable(@"Income",@"Internation", nil);
        self.sumLabel.text = [NSString stringWithFormat:@"%.f %@",orderH.amount/100000,PortionStr];
        
        if (self.orderH.paid>0) {
            self.piadLabel.text = [NSString stringWithFormat:@"%@ %.5f SEER",SpendingStr,(orderH.paid/100000)];
            self.piadLabel.textColor = [UIColor redColor];
        }else{
            
            self.piadLabel.text = [NSString stringWithFormat:@"%@ %.5f SEER",IncomeStr,(-orderH.paid/100000)];
            self.piadLabel.textColor = UIColorFromHexValue(0x34AD56);
            
        }
        
        
    }
    
    NSString *ParticipationTime = NSLocalizedStringFromTable(@"Participation Time",@"Internation", nil);
    NSString *timeOutStrEN =[orderH valueForKey:NSLocalizedStringFromTable(@"timeOutStrEN",@"Internation", nil)];
    self.guessLabel.text = orderH.chooseStr;
    self.timeOutLabel.text = [NSString stringWithFormat:@"%@%@",ParticipationTime,timeOutStrEN];
    [self setupUI];

}



-(void)setOrderW:(OrderModel *)orderW{
    
    _orderW = orderW;
    
//    self.bagView.backgroundColor = [UIColor whiteColor];
    self.contentLabel.text = [self handleStringWithString:orderW.contentStr];
    self.contentLabel.text = [self handleStringWithString2:self.contentLabel.text];
    
    if (orderW.room_type == 1) {
        self.piadLabel.hidden = YES;
        self.sumLabel.text = [NSString stringWithFormat:@"%.f SEER",orderW.amount/100000];
    }
    if (orderW.room_type == 2) {
//        [self.orderM.awards[indexPath.row]floatValue]/10000;
        self.piadLabel.hidden = YES;
       
        self.sumLabel.text = [NSString stringWithFormat:@"%.f SEER (x%.2f)", orderW.paid/100000,[self.orderW.awards[orderW.choosenumber]floatValue]/10000];
        
    }if (orderW.room_type == 0) {
        self.piadLabel.hidden = NO;
        NSString *PortionStr =  NSLocalizedStringFromTable(@"Portion",@"Internation", nil);
        NSString *SpendingStr = NSLocalizedStringFromTable(@"Spending",@"Internation", nil);
        NSString *IncomeStr = NSLocalizedStringFromTable(@"Income",@"Internation", nil);
        self.sumLabel.text = [NSString stringWithFormat:@"%.f %@",orderW.amount/100000,PortionStr];
        if (self.orderW.paid>0) {
            self.piadLabel.text = [NSString stringWithFormat:@"%@ %.5f SEER",SpendingStr,(orderW.paid/100000)];
            self.piadLabel.textColor = [UIColor redColor];
        }else{
            self.piadLabel.text = [NSString stringWithFormat:@"%@ %.5f SEER",IncomeStr,(-orderW.paid/100000)];
            self.piadLabel.textColor = UIColorFromHexValue(0x34AD56);
        }
        
    }
//    self.sumLabel.text = [NSString stringWithFormat:@"%.f SEER",orderW.amount/100000.00];
    NSString *ParticipationTime = NSLocalizedStringFromTable(@"Participation Time",@"Internation", nil);
     NSString *timeOutStrEN =[orderW valueForKey:NSLocalizedStringFromTable(@"timeOutStrEN",@"Internation", nil)];
    NSLocalizedStringFromTable(@"timeOutStrEN",@"Internation", nil);
    self.guessLabel.text = orderW.chooseStr;
    self.timeOutLabel.text = [NSString stringWithFormat:@"%@%@",ParticipationTime,timeOutStrEN];
    if (orderW.reward) {
        NSString *  winnStr = [self removeFloatAllZeroByString:[NSString stringWithFormat:@"%.4f",orderW.reward/100000.00]];
        self.winnLabel.text = [NSString stringWithFormat:@"+%@ SEER",winnStr];
        self.winnLabel.textColor = UIColorFromHexValue(0x34AD56);
        self.winnLabel.hidden = NO;
    }else{
        self.winnLabel.text = NSLocalizedStringFromTable(@"Not winning",@"Internation", nil);
        self.winnLabel.textColor = [UIColor redColor];
        self.winnLabel.hidden = NO;
    }
    
    [self setupUI];
    
}







- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (NSString*)removeFloatAllZeroByString:(NSString *)testNumber{
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    return outNumber;
    
}




//取消中括号
-(NSString *)handleStringWithString:(NSString *)str{
    
    NSMutableString * muStr = [NSMutableString stringWithString:str];
    while (1) {
        NSRange range = [muStr rangeOfString:@"@#-("];
        NSRange range1 = [muStr rangeOfString:@")"];
        if (range.location != NSNotFound) {
            NSInteger loc = range.location;
            NSInteger len = range1.location - range.location;
            [muStr deleteCharactersInRange:NSMakeRange(loc, len + 1)];
        }else{
            break;
        }
    }
    
    return muStr;
}


//二次取消
-(NSString *)handleStringWithString2:(NSString *)str{
    
    NSMutableString * muStr = [NSMutableString stringWithString:str];
    while (1) {
        NSRange range = [muStr rangeOfString:@"("];
        NSRange range1 = [muStr rangeOfString:@")"];
        if (range.location != NSNotFound) {
            NSInteger loc = range.location;
            NSInteger len = range1.location - range.location;
            [muStr deleteCharactersInRange:NSMakeRange(loc, len + 1)];
        }else{
            break;
        }
    }
    
    return muStr;
}

@end
