//
//  PredictHeaderView.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/27.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "PredictHeaderView.h"
#import "DetailsModel.h"

@implementation PredictHeaderView

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

//        [self setupUI];
        
//        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

//- (void)setHeadPredicModel:(DetailsModel *)headPredicModel {
//    _headPredicModel = headPredicModel;
//
//}

//背景图
-(UIView *)bagView{
    if (!_bagView) {
        _bagView = [[UIView alloc]init];
//        _bagView.backgroundColor = UIColorFromHexValue(0xffffff);
                _bagView.backgroundColor =[UIColor whiteColor];
//        _bagView.layer.cornerRadius = 6.7;
    }
    
    return _bagView;
    
}




//时间
- (UILabel *)stopTimeLabel
{
    if (!_stopTimeLabel)
    {
        _stopTimeLabel = [[UILabel alloc] init];
//        _stopTimeLabel.numberOfLines = 0;
        _stopTimeLabel.text =@"2018-8-17 10:00";
        _stopTimeLabel.font =  [UIFont fontWithName:@"PingFangSC-Light" size: 12];
//        _stopTimeLabel.textColor = [UIColor colorWithRed:42/255.0 green:125/255.0 blue:223/255.0 alpha:1.0];
        _stopTimeLabel.textColor = UIColorFromHexValue(0x444444);

        
    }
    
    return _stopTimeLabel;
}


//时间
- (UILabel *)room_typeLabel
{
    if (!_room_typeLabel)
    {
        _room_typeLabel = [[UILabel alloc] init];
        //        _stopTimeLabel.numberOfLines = 0;
        _room_typeLabel.text =@"20";
        _room_typeLabel.font =  [UIFont fontWithName:@"PingFangSC-Light" size: 12];
        //        _stopTimeLabel.textColor = [UIColor colorWithRed:42/255.0 green:125/255.0 blue:223/255.0 alpha:1.0];
        _room_typeLabel.textColor = UIColorFromHexValue(0x2A7DDF);
        
        
    }
    
    return _room_typeLabel;
}


////预测button
//-(UIButton *)preBnt{
//
//    if (!_preBnt) {
//
//        _preBnt = [[UIButton alloc]init];
//        _preBnt.titleLabel.textAlignment =  NSTextAlignmentCenter;
//
//        [_preBnt setTitle:@"预测中" forState:UIControlStateNormal];
//        [_preBnt setTitleColor:UIColorFromHexValue(0x2A7DDF) forState:UIControlStateNormal];
//        _preBnt.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Medium" size: 14];
//        [_preBnt setBackgroundImage:[UIImage imageNamed:@"prebnt_icon"] forState:UIControlStateNormal];
//    }
//
//
//    return _preBnt;
//}




//第一条线

-(UIView *)lineView1{
    
    if (!_lineView1) {
        
        _lineView1 = [[UIView alloc]init];
        
        //        _lineView1.backgroundColor = [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0 alpha:1.0];
        
        _lineView1.backgroundColor = UIColorFromHexValue(0xC2C2C2);
        
    }
    
    return _lineView1;
}



// 竞猜的内容
- (UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"1234二分二发个加热管进入了；国际饭店；龙岗街道发了；给大家的发了；就搞定了；国际饭店了；国际饭店了感觉到了；房管局的赶快来发达国家弗兰克的攻击力肯德基";
        _contentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
        _contentLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    }
    
    return _contentLabel;
}


//创建选项进度view
-(ProgressView *)progressView{
    
    if (!_progressView) {
        
        _progressView = [[ProgressView alloc]init];
        _progressView.backgroundColor = [UIColor whiteColor];
    }
    
    return _progressView;
}


//进度条2
-(UIView *)lineView2{
    
    if (!_lineView2) {
        _lineView2 = [[UIView alloc]init];
          _lineView2.backgroundColor = UIColorFromHexValue(0xC2C2C2);
    }
    
    return _lineView2;
}

//最下面的View
-(UIView *)toolView{
    
    if (!_toolView) {
        _toolView = [[UIView alloc]init];
        
        _toolView.backgroundColor = [UIColor whiteColor];
    }
    
    return _toolView;
}



-(UIButton *)totalmoney{
    
    if (!_totalmoney) {
        
        _totalmoney = [[UIButton alloc]init];
        _totalmoney.backgroundColor = [UIColor clearColor];
        
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




- (void)setHeadPredicModel:(DetailsModel *)headPredicModel{

    _headPredicModel = headPredicModel;
    //    "PVP" ="prize pool prediction";
    //    "PVD" = "transaction prediction";
    //    "Advanced" = "fixed odds";
    NSString *DeadlineStr= NSLocalizedStringFromTable(@"Deadline",@"Internation", nil);
    NSString *timeStr = [headPredicModel valueForKey:NSLocalizedStringFromTable(@"time",@"Internation", nil)];
    self.stopTimeLabel.text = [NSString stringWithFormat:@"%@: %@",DeadlineStr,timeStr];
    NSString *PVPstr =  NSLocalizedStringFromTable(@"PVP",@"Internation", nil);
    NSString *PVDstr =  NSLocalizedStringFromTable(@"PVD",@"Internation", nil);
    NSString *Advancedstr =  NSLocalizedStringFromTable(@"Advanced",@"Internation", nil);
    //时间
//    self.stopTimeLabel.text = [NSString stringWithFormat:@"截止时间: %@",headPredicModel.time];
    
    if (headPredicModel.room_type == 1) {
         self.room_typeLabel.text = [NSString stringWithFormat:@"·%@",PVPstr];
//        self.room_typeLabel.text = @"·奖池型预测";
         [self.totalmoney setTitle:[NSString stringWithFormat:@"%ld",(long)headPredicModel.totalmoneyaCount]forState:UIControlStateNormal];
    }
    if (headPredicModel.room_type == 2) {
//        self.room_typeLabel.text = @"·固定赔率";
         self.room_typeLabel.text = [NSString stringWithFormat:@"·%@",Advancedstr];
        NSInteger totalmoneyNum = headPredicModel.totalmoneyaCount;
        [self.totalmoney setTitle:[NSString stringWithFormat:@"%ld",(long)totalmoneyNum]forState:UIControlStateNormal];
    }
    if (headPredicModel.room_type == 0) {
        self.room_typeLabel.text = [NSString stringWithFormat:@"·%@",PVDstr];
//        float totalmoney = [headPredicModel.totalmoneyaCount ;
        [self.totalmoney setTitle:[NSString stringWithFormat:@"%ld",(long)headPredicModel.totalmoneyaCount] forState:UIControlStateNormal];
    }
    
    
    //内容
    self.contentLabel.text = [self handleStringWithString:headPredicModel.title];
    self.contentLabel.text = [self handleStringWithString2:self.contentLabel.text];
    //金额
   
    //人数
      [self.totalpeople setTitle:[NSString stringWithFormat:@"%ld",(long)headPredicModel.totalpeople] forState:UIControlStateNormal];

    //百分比
//    [self.percent setTitle:[NSString stringWithFormat:@"%ld%%",(long)headPredicModel.percent] forState:UIControlStateNormal];
    [self.percent setTitle:headPredicModel.accept_asset forState:UIControlStateNormal];
    
    self.progressView.progessDetail = headPredicModel;
    

       [self setupUI];
    
}


-(void)setHeadOrderModel:(OrderModel *)headOrderModel{
    
    _headOrderModel = headOrderModel;
    NSString *DeadlineStr= NSLocalizedStringFromTable(@"Deadline",@"Internation", nil);
    NSString *timeStopEN =[headOrderModel valueForKey:NSLocalizedStringFromTable(@"timeStopEN",@"Internation", nil)];
    
    self.stopTimeLabel.text = [NSString stringWithFormat:@"%@: %@",DeadlineStr,timeStopEN];
    //    "PVP" ="prize pool prediction";
    //    "PVD" = "transaction prediction";
    //    "Advanced" = "fixed odds";
    NSString *PVPstr =  NSLocalizedStringFromTable(@"PVP",@"Internation", nil);
    NSString *PVDstr =  NSLocalizedStringFromTable(@"PVD",@"Internation", nil);
    NSString *Advancedstr =  NSLocalizedStringFromTable(@"Advanced",@"Internation", nil);
    //时间
//    self.stopTimeLabel.text = [NSString stringWithFormat:@"截止时间 %@",headOrderModel.timeStop];
    
    if (headOrderModel.room_type == 1) {
         self.room_typeLabel.text = [NSString stringWithFormat:@"·%@",PVPstr];
//        self.room_typeLabel.text = @"·奖池型预测";
        [self.totalmoney setTitle:[NSString stringWithFormat:@"%ld",(long)headOrderModel.totalmoneyaCount]forState:UIControlStateNormal];
    }
    if (headOrderModel.room_type == 2) {
         self.room_typeLabel.text = [NSString stringWithFormat:@"·%@",Advancedstr];
//        self.room_typeLabel.text = @"·固定赔率";
        NSInteger totalmoneyNum = headOrderModel.totalmoneyaCount;
        
        [self.totalmoney setTitle:[NSString stringWithFormat:@"%ld",(long)totalmoneyNum]forState:UIControlStateNormal];
    }
    if (headOrderModel.room_type == 0) {
//        self.room_typeLabel.text = @"·交易类型预测";
          self.room_typeLabel.text = [NSString stringWithFormat:@"·%@",PVDstr];
        //        float totalmoney = [headPredicModel.totalmoneyaCount ;
        [self.totalmoney setTitle:[NSString stringWithFormat:@"%ld",(long)headOrderModel.totalmoneyaCount ] forState:UIControlStateNormal];
    }
    

    //内容
    self.contentLabel.text = [self handleStringWithString:headOrderModel.contentStr];
    self.contentLabel.text = [self handleStringWithString2:self.contentLabel.text];
    

    //金额
//    [self.totalmoney setTitle:[NSString stringWithFormat:@"%ld",(long)headOrderModel.totalmoneyaCount]forState:UIControlStateNormal];
    //人数
    [self.totalpeople setTitle:[NSString stringWithFormat:@"%ld",(long)headOrderModel.totalpeople] forState:UIControlStateNormal];
    //百分比
//    [self.percent setTitle:[NSString stringWithFormat:@"%ld%%",(long)headOrderModel.percent] forState:UIControlStateNormal];
    [self.percent setTitle:headOrderModel.accept_asset forState:UIControlStateNormal];
    
    self.progressView.progessOrderModel = headOrderModel;
    [self setupUI];

}






-(void)setupUI{
    CGFloat totalHeight  = 0;
    if (self.headPredicModel) {
        totalHeight = self.headPredicModel.hightH;
    }else if (self.headOrderModel){
        
        
        totalHeight = self.headOrderModel.hightH;
    }
    
    CGFloat xuanzeHeight = 48;
    CGFloat toolHeight = 46;
    CGFloat timeHeight = 50;
    
       CGFloat progressHeight = 0;
    if (self.headPredicModel) {
         progressHeight = self.headPredicModel.choseButcount.count * 30;
    } else if (self.headOrderModel){
        progressHeight = self.headOrderModel.choseButcount.count * 30;
        
    }
 

    [self addSubview:self.bagView];
    [self.bagView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo((totalHeight- xuanzeHeight));
        
    }];
    
    //下面toolView的高度
    UIView *topView = [[UIView alloc]init];
    
    topView.backgroundColor = [UIColor whiteColor];
    
    [self.bagView addSubview:topView];

    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(timeHeight);
    }];
    
    
    
    //添加预测按钮
    
//    [topView addSubview:self.preBnt];
//
//    [self.preBnt mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
//        make.height.mas_equalTo(33);
//    }];
    
    
    //预测类型
    [topView addSubview:self.room_typeLabel];
    
    [self.room_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
        
    }];
    
    //添加时间
    
    [topView addSubview:self.stopTimeLabel];
    [self.stopTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topView.mas_right).offset(-10);
        make.centerY.mas_equalTo(0);
//        make.centerY.mas_equalTo(self.preBnt.mas_centerY);
        
    }];
    
    
   
    

    
    //添加分割线
    
    [self.bagView addSubview:self.lineView1];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom);
        make.left.mas_equalTo(topView.mas_left);
        make.right.mas_equalTo(topView.mas_right);
        make.height.mas_equalTo(0.3);
    }];
    
    
    
    //添加竞猜内容
    [self.bagView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.lineView1.mas_bottom).offset(20);
        make.right.equalTo(self.bagView.mas_right).offset(-8);
        make.left.equalTo(self.bagView.mas_left).offset(8);
    }];
    
    [self.bagView addSubview:self.progressView];
    
    //添加进度条
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(self.contentLabel.mas_left);
        make.right.mas_equalTo(self.contentLabel.mas_right);
        make.height.mas_equalTo(progressHeight);
        
    }];
    
    
    
    
    
    [self.bagView addSubview:self.toolView];
    // toolView
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.progressView.mas_bottom).offset(20);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(toolHeight);
   
    }];
    
    [self.toolView addSubview:self.totalmoney];
    [self.toolView addSubview:self.percent];
    [self.toolView addSubview:self.totalpeople];
    
    
    
    CGFloat bottomW = kScreenW /3;
     // 三个按钮
    [self.totalmoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(bottomW);
    }];
//
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
    
    
    UIView *lineview = [[UIView alloc]init];
    lineview.layer.cornerRadius = 1.7;
    lineview.backgroundColor = UIColorFromHexValue(0x2A7DDF);
    [self addSubview:lineview];
    
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bagView.mas_bottom).offset(17);
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-17);
        make.width.mas_equalTo(3);
    }];
    
    UILabel *xuanzheLabel = [[UILabel alloc]init];
    xuanzheLabel.text = NSLocalizedStringFromTable(@"Options",@"Internation", nil);
    xuanzheLabel.textColor = UIColorFromHexValue(0x444444);
    xuanzheLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 12.7];
    [self addSubview:xuanzheLabel];
    
    [xuanzheLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineview.mas_right).offset(5);
        make.centerY.mas_equalTo(lineview.mas_centerY);
    }];
  
    //分割线
    [self.bagView addSubview:self.lineView2];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.progressView.mas_bottom).offset(20);
        make.left.mas_equalTo(topView.mas_left);
        make.right.mas_equalTo(topView.mas_right);
        make.height.mas_equalTo(0.8);
        
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

@end
