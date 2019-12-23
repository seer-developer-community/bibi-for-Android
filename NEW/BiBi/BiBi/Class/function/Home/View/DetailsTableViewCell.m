//
//  DetailsTableViewCell.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/19.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "DetailsTableViewCell.h"
#import "ButtonView.h"
#import <QuartzCore/QuartzCore.h>

@implementation DetailsTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"wallet";
    DetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell =[[DetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = UIColorFromHexValue(0xf4f6fd);
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


#pragma mark - lazy load




- (UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"1234";
        _contentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
        _contentLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
        }
    
    return _contentLabel;
}


-(UILabel *)room_TypeLabel{
    
    if (!_room_TypeLabel) {
        _room_TypeLabel = [[UILabel alloc]init];
      
        _room_TypeLabel.font =  [UIFont fontWithName:@"PingFangSC-Light" size: 12];
        _room_TypeLabel.textColor = UIColorFromHexValue(0x2A7DDF);
        _room_TypeLabel.text =@"检查给的丰富的";
    }
    
    return _room_TypeLabel;
}

- (UILabel *)timeLb
{
    if (!_timeLb)
    {
        _timeLb = [[UILabel alloc] init];
        _timeLb.numberOfLines = 0;
        _timeLb.font =  [UIFont fontWithName:@"PingFangSC-Light" size: 12];
        _timeLb.textColor = UIColorFromHexValue(0x444444);
//        _timeLb.backgroundColor = [UIColor blackColor];
    
    }
    return _timeLb;
}

-(ButtonView *)chooseButton{
    
    if (!_chooseButton) {
        _chooseButton =[[ButtonView alloc]init];

        _chooseButton.backgroundColor = [UIColor whiteColor];
        
    }
    
    return _chooseButton;
}


//背景图

-(UIView *)bagView{
    if (!_bagView) {
        _bagView = [[UIView alloc]init];
        _bagView.backgroundColor = UIColorFromHexValue(0xffffff);
//        _bagView.backgroundColor =[UIColor yellowColor];
        _bagView.layer.cornerRadius = 6.7;
    }
    
    return _bagView;
    
}



//第一条线

-(UIView *)lineView1{
    
    if (!_lineView1) {
        
        _lineView1 = [[UIView alloc]init];
        
//        _lineView1.backgroundColor = [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0 alpha:1.0];
        
        _lineView1.backgroundColor = UIColorFromHexValue(0xC2C2C2);

    }
    
    return _lineView1;
}


//第二条线

-(UIView *)lineView2{
    
    if (!_lineView2) {
        
        _lineView2 = [[UIView alloc]init];
        
        //        _lineView1.backgroundColor = [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0 alpha:1.0];
        
        _lineView2.backgroundColor = UIColorFromHexValue(0xC2C2C2);
        
    }
    
    return _lineView2;
}


//toolHight

-(UIView *)toolView{
    
    if (!_toolView) {
        _toolView = [[UIView alloc]init];
        
        _toolView.backgroundColor = [UIColor clearColor];
    }
    
    return _toolView;
}



-(UIButton *)choseBut{
    
    if (!_choseBut) {
        
        _choseBut = [[UIButton alloc]init];
        
         [_choseBut setTitle:@"wo" forState:UIControlStateNormal];
        
        _choseBut.backgroundColor = UIColorFromHexValue(0x2A7DDF);
        
        _choseBut.layer.cornerRadius = 16.7;
        
        _choseBut.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
        
        [_choseBut setTitleColor: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        
    }
    
    return _choseBut;
}





-(UIButton *)totalmoney{
    
    if (!_totalmoney) {
        
        _totalmoney = [[UIButton alloc]init];
        _totalmoney.backgroundColor = [UIColor clearColor];
         _totalmoney.userInteractionEnabled = NO;
        [_totalmoney setTitle:@"2444" forState:UIControlStateNormal] ;
        
        //        _totalmoney.titleLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
        
        [_totalmoney setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _totalmoney.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size: 12];
        
        [_totalmoney setImage:[UIImage imageNamed:@"moneny_iocn"] forState:UIControlStateNormal];
        _totalmoney.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [_totalmoney setImageEdgeInsets:UIEdgeInsetsMake(0, 10,0.0, 0)];
        [_totalmoney setTitleEdgeInsets:UIEdgeInsetsMake(0, _totalmoney.height + 15, 0, 0)];
    }
    
    return _totalmoney;
    
}


-(UIButton *)totalpeople{
    
    if (!_totalpeople) {
        
        _totalpeople = [[UIButton alloc]init];
        _totalpeople.backgroundColor = [UIColor clearColor];
        _totalpeople.userInteractionEnabled = NO;
        [_totalpeople setTitle:@"244434" forState:UIControlStateNormal] ;
        
        //        _totalmoney.titleLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
        
        [_totalpeople setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _totalpeople.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size: 12];
        
        [_totalpeople setImage:[UIImage imageNamed:@"totalpeople_icon"] forState:UIControlStateNormal];
        
        _totalpeople.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [_totalpeople setImageEdgeInsets:UIEdgeInsetsMake(0, 40,0.0, 0)];
        [_totalpeople setTitleEdgeInsets:UIEdgeInsetsMake(0, _totalmoney.height+45, 0, 0)];
        
    }
    
    return _totalpeople;
    
}
-(UIButton *)percent{
    
    if (!_percent) {
        
        _percent = [[UIButton alloc]init];
        _percent.backgroundColor = [UIColor clearColor];
        _percent.userInteractionEnabled = NO;
        [_percent setTitle:@"244434" forState:UIControlStateNormal] ;
        
        //        _totalmoney.titleLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
        
        [_percent setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _percent.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size: 12];
        
        [_percent setImage:[UIImage imageNamed:@"percent_icon"] forState:UIControlStateNormal];
        
        _percent.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [_percent setImageEdgeInsets:UIEdgeInsetsMake(0, 45,0.0, 0)];
        [_percent setTitleEdgeInsets:UIEdgeInsetsMake(0, _totalmoney.height + 50, 0, 0)];
        
        
    }
    
    return _percent;
    
}



#pragma mark - set
- (void)setModel:(DetailsModel *)model
{
    _model = model;
    NSString * title2= [self handleStringWithString:_model.title];
    self.contentLabel.text = [self handleStringWithString2:title2];
    NSString *DeadlineStr= NSLocalizedStringFromTable(@"Deadline",@"Internation", nil);
    NSString *timeStr = [_model valueForKey:NSLocalizedStringFromTable(@"time",@"Internation", nil)];
    self.timeLb.text = [NSString stringWithFormat:@"%@: %@",DeadlineStr,timeStr];
//    "PVP" ="prize pool prediction";
//    "PVD" = "transaction prediction";
//    "Advanced" = "fixed odds";
    NSString *PVPstr =  NSLocalizedStringFromTable(@"PVP",@"Internation", nil);
    NSString *PVDstr =  NSLocalizedStringFromTable(@"PVD",@"Internation", nil);
    NSString *Advancedstr =  NSLocalizedStringFromTable(@"Advanced",@"Internation", nil);
    
    if (model.room_type == 1) {
        [self.totalmoney setTitle:[NSString stringWithFormat:@"%ld",(long)model.totalmoneyaCount]forState:UIControlStateNormal];
        self.room_TypeLabel.text = [NSString stringWithFormat:@"·%@",PVPstr];
    }
    if (model.room_type == 2) {
        NSInteger totalmoneyNum = model.totalmoneyaCount;
         [self.totalmoney setTitle:[NSString stringWithFormat:@"%ld",totalmoneyNum]forState:UIControlStateNormal];
        self.room_TypeLabel.text = [NSString stringWithFormat:@"·%@",Advancedstr];
    }
    if (model.room_type == 0) {
        self.room_TypeLabel.text =[NSString stringWithFormat:@"·%@",PVDstr];
        [self.totalmoney setTitle:[NSString stringWithFormat:@"%ld",(long)model.totalmoneyaCount]forState:UIControlStateNormal];
    }
    
    [self.totalpeople setTitle:[NSString stringWithFormat:@"%ld",model.totalpeople] forState:UIControlStateNormal];
//    [self.percent setTitle:[NSString stringWithFormat:@"%ld",model.percent] forState:UIControlStateNormal];
    [self.percent setTitle:model.accept_asset forState:UIControlStateNormal];
    
    self.chooseButton.butArry = _model.choseButcount;
    
    self.chooseButton.butCount = _model.choseButcount.count;
    
    [self.bagView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((model.hight-25));
    }];
    
}

- (UIButton*)createBtnWithTitile:(NSString*)title image:(UIImage*)image {
    UIButton * btn = [[UIButton alloc]init];
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    btn.layer.cornerRadius = 16.7;
    
    btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
    
    [btn setTitleColor: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];

    return btn;
}


-(void)setupUI{
    [self.contentView addSubview:self.bagView];
    [self.bagView addSubview:self.timeLb];
    [self.bagView addSubview:self.room_TypeLabel];
    [self.bagView addSubview:self.lineView1];
    [self.bagView addSubview:self.contentLabel];
//    self.contentView.backgroundColor = [UIColor redColor];
//    self.bagView.backgroundColor = [UIColor yellowColor];
    //添加chooseBut
   
//    [self.chooseButton addSubview:self.choseBut];
//    [self.chooseButton addSubview:self.choseBut1];
//    [self.chooseButton addSubview:self.choseBut2];
    
    
    [self.bagView addSubview:self.lineView2];
    [self.bagView addSubview:self.toolView];
    
    [self.toolView addSubview:self.totalmoney];
    [self.toolView addSubview:self.totalpeople];
    [self.toolView addSubview:self.percent];
    self.toolView.backgroundColor = [UIColor whiteColor];
     [self.bagView addSubview:self.chooseButton];

    [self.bagView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(0);
        
    }];
    [self.room_TypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bagView.mas_top).offset(10);
        make.left.equalTo(self.bagView.mas_left).offset(10);
    }];
    
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bagView.mas_top).offset(10);
        make.left.equalTo(self.room_TypeLabel.mas_right).offset(10);
//        make.right.equalTo(self.bagView.mas_right).offset(-10);
    }];
    
//

    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bagView.mas_top).offset(30);
        make.left.mas_equalTo(self.bagView.mas_left);
        make.right.mas_equalTo(self.bagView.mas_right);
        make.height.mas_equalTo(0.3);
    }];
//
//
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.timeLb.mas_bottom).offset(20);
        make.right.equalTo(self.bagView.mas_right).offset(-8);
        make.left.equalTo(self.bagView.mas_left).offset(8);
//        make.bottom.mas_equalTo(self.bagView.mas_bottom).offset(-10);

    }];
//    //
        [self.chooseButton  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(self.bagView.mas_left).offset(10);
            make.right.mas_equalTo(self.bagView.mas_right).offset(-10);
            make.height.mas_equalTo(33);


        }];
//
////    CGFloat chooseButW = (ScreenWidth - 100)/3;
////    CGFloat marign =8;
////
////    [self.choseBut mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.centerY.mas_equalTo(0);
////        make.left.mas_equalTo(0);
////        make.height.mas_equalTo(33);
////        make.width.mas_equalTo(chooseButW);
////    }];
//
//
////    [self.choseBut1 mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.centerY.mas_equalTo(0);
////        make.left.mas_equalTo(self.choseBut.mas_right).offset(marign);
////        make.height.mas_equalTo(33);
////        make.width.mas_equalTo(chooseButW);
////    }];
////
////    [self.choseBut2 mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.centerY.mas_equalTo(0);
////        make.left.mas_equalTo(self.choseBut1.mas_right).offset(marign);
////        make.height.mas_equalTo(33);
////        make.width.mas_equalTo(chooseButW);
////    }];
//
//
//
//
////    //第二条线
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.chooseButton.mas_bottom).offset(5);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.3);


    }];
//
//
    // toolView
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.chooseButton.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
//        make.bottom.mas_equalTo(self.bagView.bottom);
    }];

    CGFloat bottomW = (ScreenWidth - 20)/3;
    [self.totalmoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(bottomW);
    }];

    [self.totalpeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.totalmoney.mas_right);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(bottomW);
    }];

    [self.percent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.totalpeople.mas_right);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(bottomW);
    }];


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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
 
