//
//  QuizzesSucdViewController.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/4.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "QuizzesSucdViewController.h"
#import "OrederViewController.h"


@interface QuizzesSucdViewController ()
@property(nonatomic,strong)UILabel *chooseLabel;
@property(nonatomic,strong)UILabel *textLabel;
@property(nonatomic,strong)UILabel *time_Label;
@end
@implementation QuizzesSucdViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

-(void)setUI{
    CGFloat toolHiget =0;
    if (self.preModel) {
        toolHiget = self.preModel.yuchengHight;
    }else if (self.orderM){
        toolHiget = self.orderM.yuchengHight;
    }
    
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    
    UIView *bagView = [[UIView alloc]init];
    bagView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bagView];
    
    [bagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(160*kHeightScale);
        make.height.mas_equalTo(toolHiget);
    }];
    
    UIView *buleView = [[UIView alloc]init];
    buleView.backgroundColor = UIColorFromHexValue(0x2A7DDF);
    [bagView addSubview:buleView];
    
    [buleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
//    //投注详情
//    "Done" ="预测成功";
//    "History" = "查看记录";
//    "Continue" = "继续预测";
//    "Portion" = "份数"
    UILabel *labelSuc = [[UILabel alloc]init];
    labelSuc.text =NSLocalizedStringFromTable(@"Done",@"Internation", nil);

    labelSuc.textColor =[UIColor colorWithRed:244/255.0 green:246/255.0 blue:253/255.0 alpha:1.0];
    labelSuc.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 18.6];
    [buleView addSubview:labelSuc];
    [labelSuc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(3);
        make.centerX.mas_equalTo(0);
        
    }];
    
    //文字label
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.textColor = UIColorFromHexValue(0x444444);
    textLabel.numberOfLines = 0;
    if (self.preModel) {
        textLabel.text = self.preModel.title;
    }else if (self.orderM){
        
        textLabel.text = self.orderM.contentStr;
    }
   
    textLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 12];
    self.textLabel = textLabel;
    [bagView addSubview:self.textLabel];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(19);
        make.right.mas_equalTo(-19);
        make.top.mas_equalTo(buleView.mas_bottom).offset(30);
    }];
    
  
    
    //选项的button
    UILabel *chooseLabel = [[UILabel alloc]init];
    chooseLabel.textColor = [UIColor colorWithRed:46/255.0 green:139/255.0 blue:229/255.0 alpha:1.0];
    chooseLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 12];
    
    if (self.preModel) {
        chooseLabel.text = self.preModel.choseButcount[self.chooseCount];
    }else if (self.orderM){
        
         chooseLabel.text = self.orderM.choseButcount[self.chooseCount];
    }
    
    
    chooseLabel.numberOfLines = 0;
    
    self.chooseLabel = chooseLabel;
    [bagView addSubview:self.chooseLabel];
    
    [self.chooseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(self.textLabel.mas_left);
        
    }];
    
    UILabel *seerLabel = [[UILabel alloc]init];
    
    
    seerLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 12];
    seerLabel.textColor = [UIColor colorWithRed:46/255.0 green:139/255.0 blue:229/255.0 alpha:1.0];
     NSString *prStr = NSLocalizedStringFromTable(@"Portion",@"Internation", nil);
    if (self.preModel) {
        
        if (self.preModel.room_type == 0) {
           
             seerLabel.text = [NSString stringWithFormat:@"%ld %@",self.trNmber,prStr];
        }else{
            if ([self.preModel.accept_asset isEqualToString:@"SEER"]) {
                seerLabel.text = [NSString stringWithFormat:@"%ld SEER",self.trNmber];
            }else if ([self.preModel.accept_asset isEqualToString:@"USDT"]){
                 seerLabel.text = [NSString stringWithFormat:@"%ld USDT",self.trNmber];
            }else if ([self.preModel.accept_asset isEqualToString:@"PFC"]){
                 seerLabel.text = [NSString stringWithFormat:@"%ld PFC",self.trNmber];
            }
            
        }
    }else if (self.orderM){
        if (self.orderM.room_type == 0) {
            seerLabel.text = [NSString stringWithFormat:@"%ld %@",self.trNmber,prStr];
        }else{
            if ([self.orderM.accept_asset isEqualToString:@"SEER"]) {
                seerLabel.text = [NSString stringWithFormat:@"%ld SEER",self.trNmber];
            }else if ([self.orderM.accept_asset isEqualToString:@"USDT"]){
                seerLabel.text = [NSString stringWithFormat:@"%ld USDT",self.trNmber];
            }else if ([self.orderM.accept_asset isEqualToString:@"PFC"]){
                seerLabel.text = [NSString stringWithFormat:@"%ld PFC",self.trNmber];
            }
        }
        
        
    }
    
//    self.chooseLabel = chooseLabel;
    [bagView addSubview: seerLabel];
    
    [seerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.textLabel.mas_bottom).offset(20);
        make.right.mas_equalTo(self.textLabel.mas_right);
        make.centerY.mas_equalTo(self.chooseLabel);
        
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = UIColorFromHexValue(0xc2c2c2);
    [bagView addSubview:line1];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(seerLabel.mas_bottom).offset(16);
        make.height.mas_equalTo(0.3);
        make.width.mas_equalTo(bagView.width);
    }];
    
    UILabel * timeLabel = [[UILabel alloc]init];
    timeLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size: 10.7];
    timeLabel.textColor = UIColorFromHexValue(0x2A7DDF);
    self.time_Label = timeLabel;
    NSString *deadineStr = NSLocalizedStringFromTable(@"Deadline",@"Internation", nil);
    if (self.preModel) {
         NSString *timeStr = [self.preModel valueForKey:NSLocalizedStringFromTable(@"time",@"Internation", nil)];
        self.time_Label.text =[NSString stringWithFormat:@"%@:%@",deadineStr,timeStr];
    }else if (self.orderM){
        
        self.time_Label.text =[NSString stringWithFormat:@"%@:%@",deadineStr,self.orderM.timeStop];
    }
    
    [bagView addSubview:timeLabel];
    [self.time_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(13);
        make.left.mas_equalTo(self.textLabel.mas_left);
    }];
    
    
    UIButton *jilvBnt = [[UIButton alloc]init];
    [jilvBnt setBackgroundImage:[UIImage imageNamed:@"record_bnt"] forState:UIControlStateNormal];
    [jilvBnt setTitle:NSLocalizedStringFromTable(@"History",@"Internation", nil) forState:UIControlStateNormal];
    [jilvBnt setTitleColor:[UIColor colorWithRed:46/255.0 green:139/255.0 blue:229/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [jilvBnt addTarget:self action:@selector(orderClick) forControlEvents:UIControlEventTouchUpInside];
    jilvBnt.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 18];
    [self.view addSubview:jilvBnt];
    
    [jilvBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bagView.mas_left);
        make.top.mas_equalTo(bagView.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(163, 60));
        
    }];
    
    
    UIButton *conntBnt = [[UIButton alloc]init];
    [conntBnt setBackgroundImage:[UIImage imageNamed:@"Continue_bnt"] forState:UIControlStateNormal];
    [conntBnt setTitle:NSLocalizedStringFromTable(@"Continue",@"Internation", nil) forState:UIControlStateNormal];
    [conntBnt setTitleColor:UIColorFromHexValue(0xffffff) forState:UIControlStateNormal];
    conntBnt.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 18];
    [conntBnt addTarget:self action:@selector(cliclPoP) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:conntBnt];
    
    [conntBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bagView.mas_right);
        make.top.mas_equalTo(bagView.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(163, 60));
        
    }];
}

-(void)cliclPoP{
    [self.navigationController popViewControllerAnimated:YES];
//    vc.preModel = self.dataArray[indexPath.row];
}

-(void)orderClick{
     self.tabBarController.selectedIndex = 1;
    if (self.preModel) {
        [MoneyPacketManager moneyAcctountManager].assorder_id = self.preModel.ass_id;
    }else if (self.orderM){
         [MoneyPacketManager moneyAcctountManager].assorder_id = self.orderM.ass_id;
    }
//     NSLog(@"给我他妈看看-----%@",[MoneyPacketManager moneyAcctountManager].assorder_id);
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}



@end
