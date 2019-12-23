//
//  NineNoteViewController.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/1.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "NineNoteViewController.h"
#import "BitsharesWalletObject.h"
#import "BrainKey.h"
#import "PrivateKey.h"
#import "PublicKey.h"
#import "BaseConfig.h"
#import "MaskView.h"

#import "NoteTagsRightViewController.h"

@interface NineNoteViewController ()

@property(nonatomic,strong)UIView *ciView;

//助记词标签
@property (nonatomic,strong)NSArray *dataArr;

//下一步
@property(nonatomic,strong)UIButton *labelBnt;

@end

@implementation NineNoteViewController

{
    UIScrollView *scrollview;
    CGFloat W;
    CGFloat H;
    NSInteger rank;
    CGFloat rankMargin;
    CGFloat rowMargin;
}




//-(NSArray *)dataArr{
//    if (!_dataArr) {
//        NSString * str = @"JHOW BALLOT CALLOUS HEADCAP AMNESIC TARSIER HELLUO SEEKER OPERAE CURLIKE PUTT HOOPOE RUSPONE JARRA ODORANT ACEPHAL";
//
//        NSString *str1 = [str lowercaseString];
//
//        _dataArr = [str1  componentsSeparatedByString:@" "];
//    }
//
//
//    return _dataArr;
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
     [BaseConfig setPrefix:@"SEER"];
    
    BitsharesWalletObject *walltObject = [[BitsharesWalletObject alloc]init];
    
    BrainKey *brainKey = [walltObject suggestBrainKey];
    NSLog(@"-------%@-------",brainKey.priKey);
    NSLog(@"------%@-------",brainKey.pubKey);
    NSLog(@"--------%@-------",brainKey.brainKey);
//    //助记词
    [MoneyPacketManager moneyAcctountManager].brainKeyStr = [NSString stringWithFormat:@"%@",brainKey.brainKey];
    // 私钥
    [MoneyPacketManager moneyAcctountManager].priveKeyStr = [NSString stringWithFormat:@"%@",brainKey.priKey];
    //公钥
    [MoneyPacketManager moneyAcctountManager].puliKeyStr = [NSString stringWithFormat:@"%@",brainKey.pubKey];
    NSString * str = [MoneyPacketManager moneyAcctountManager].brainKeyStr;
    
//     NSString * str = @"A B C D E F G H I J K M L N O P";
    NSString *str1 = [str lowercaseString];
    _dataArr = [str1  componentsSeparatedByString:@" "];
    
    [self setTopView];
    
  
    

    
}



-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    
    self.navigationController.navigationBarHidden = YES;
    self.navView.title = NSLocalizedStringFromTable(@"Back Up Mnemonic Words",@"Internation", nil);
    //    self.navView.backgroundColor = [UIColor redColor];
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick)
                         forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
    
    [self setupUI];
}


-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}
//"Back Up Mnemonic Words" = "备份助记词";
//"Back Up Mnemonic Words" = "备份";
//"Please write down " ="请记下你的钱包助记词并保存到安全的地方";
//"Wallet mnemonic words" ="钱包助记词用于恢复钱包资产，拥有助记词即可完全控制钱包资产，请务 必妥善保管，丢失助词即丢失钱包资产。币比不存储用户助记词，无法提供找回功能。";
//"Next" = "下一步";
//"Do not take a screenshot" = "请勿截图";
//"Disclosure of mnemonic" = "泄露记词将导致资产丢失，请认真抄写并放在安全到地方，请勿截屏！";

-(void)setupUI{
    
//    rank = 4;    //每行列数
//    rankMargin = (self.view.frame.size.width - rank * W) / (rank - 1)-20;  //每列间距
//    rowMargin = 10; //每行间距
    
    W = 70;  H = 35;    //每个Item宽高
    rank = 4;    //每行列数
    rankMargin = (self.view.frame.size.width - rank * W) / (rank - 1)-20;  //每列间距
    rowMargin = 10; //每行间距
    
    UILabel *bigLabel = [[UILabel alloc]init];
    bigLabel.textColor = UIColorFromHexValue(0x444444);
    bigLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 14.7];
//    bigLabel.text = @"请记下你的钱包助记词并保存到安全的地方";
    bigLabel.text =  NSLocalizedStringFromTable(@"Please write down",@"Internation", nil);

    [self.view addSubview:bigLabel];
    
    [bigLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom).offset(35);
        make.centerX.mas_equalTo(0);
        
    }];
    
    UILabel *littleLabel = [[UILabel alloc]init];
    
    littleLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    littleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    littleLabel.text = NSLocalizedStringFromTable(@"Wallet mnemonic words",@"Internation", nil);
    littleLabel.numberOfLines = 0;
    
    [self.view addSubview:littleLabel];
    
    [littleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(bigLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        
    }];
    
    //背景View
    _ciView = [[UIView alloc]init];
    _ciView.backgroundColor = [UIColor whiteColor];
    _ciView.layer.cornerRadius = 6.7;
    [self.view addSubview:_ciView];
    
    [self.ciView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(littleLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(180);
        
    }];
    
    
    for (int i = 0 ; i< self.dataArr.count; i++) {
        CGFloat X = (i % rank) * (W + rankMargin);//Item X轴
        NSUInteger Y = (i / rank) * (H +rowMargin); //Item Y轴
        CGFloat top =  5;     //Item top
        CGFloat left = 10;
        UIButton *bnt = [[UIButton alloc]init];
        bnt.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 12];
        bnt.titleLabel.adjustsFontSizeToFitWidth = YES;
        bnt.layer.cornerRadius = 10;
        bnt.layer.borderWidth = 1;
        bnt.layer.borderColor = UIColorFromHexValue(0x2D86E3).CGColor;
        bnt.layer.cornerRadius = 10;
        [ bnt setTitleColor:UIColorFromHexValue(0x2D86E3) forState:UIControlStateNormal];
        [ bnt setBackgroundColor:[UIColor colorWithRed:45/255.0 green:134/255.0 blue:227/255.0 alpha:0.3]];
        [self.ciView addSubview:bnt];
        
        [bnt setTitle:[NSString stringWithFormat:@"%@",self.dataArr[i]] forState:UIControlStateNormal];
        
    
        [bnt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(X+left);
            make.top.mas_equalTo(Y+top);
            make.width.mas_equalTo(55);
            make.height.mas_equalTo(20);
        }];
    
    
    }
    
    
    UIButton *nextBnt = [[UIButton alloc]init];
    nextBnt.backgroundColor = UIColorFromHexValue(0x2A7DDF);
    nextBnt.layer.cornerRadius = 20;
    [nextBnt setTitle:NSLocalizedStringFromTable(@"Next",@"Internation", nil) forState:UIControlStateNormal];
    nextBnt.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 18.7];
    [nextBnt setTitleColor:UIColorFromHexValue(0xffffff) forState:UIControlStateNormal];
    [nextBnt addTarget:self action:@selector(clickNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBnt];
    
    [nextBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.ciView.mas_bottom).offset(25);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(40);
        
    }];
    
    
    //蒙版View
    
    MaskView *maskView = [[MaskView alloc]initWithTitleBiglable:NSLocalizedStringFromTable(@"Do not take a screenshot",@"Internation", nil) little:NSLocalizedStringFromTable(@"Disclosure of mnemonic",@"Internation", nil)littletwo:@""  textColor:UIColorFromHexValue(0x444444)];
    
    [maskView addButtonAction:^(id  _Nonnull sender) {
        
    }];
    
    
    
    
}


-(void)clickNext{
    
    NoteTagsRightViewController * noteTagsR = [[NoteTagsRightViewController alloc]init];
    
    noteTagsR.ciArry = self.dataArr;
    
//    NSString * srt =[MoneyPacketManager moneyAcctountManager].userName;
    
    [self.navigationController pushViewController:noteTagsR animated:YES];
    
}








//回头研究一下怎么用

-(UIButton *)labelBnt{
    
    _labelBnt = [[UIButton alloc]init];
    _labelBnt.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 14];
    _labelBnt.layer.cornerRadius = 10;
    [_labelBnt setTitleColor:UIColorFromHexValue(0x2D86E3) forState:UIControlStateNormal];
    [_labelBnt setBackgroundColor:UIColorFromHexValue(0x444444)];
    
    return _labelBnt;
}



@end
