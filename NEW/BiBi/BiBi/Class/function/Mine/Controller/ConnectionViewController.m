//
//  ConnectionViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/17.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "ConnectionViewController.h"

@interface ConnectionViewController ()
@property(nonatomic,strong)UILabel *weichatLabel;
@property(nonatomic,strong)UILabel *weiPublickLabel;
@end

@implementation ConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    self.navView.title = NSLocalizedStringFromTable(@"Contact Us",@"Internation", nil);
;
//
    
    [self setTopView];
    
    [self setupUI];
}


#pragma mark ---topView
-(void)setTopView{
//    self.navView.backgroundImage = [UIImage imageNamed:@"mycase_titlebar"];
      self.navigationController.navigationBarHidden = YES;
//    self.navView.title = @"联系我们";
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
//    self.navView.rightBarButtonImage =[UIImage imageNamed:@"mycase_reset"];
}

-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)setupUI{
    UIImageView *backImage =[[UIImageView alloc]init];
    
    backImage.image = [UIImage imageNamed:@"back_image"];
    
    backImage.frame = CGRectMake(0,self.navView.bottom,kScreenW,145.3*kHeightScale);
    
    [self.view addSubview:backImage];
    
    UIView *whiteView = [[UIView alloc] init];
    whiteView.frame = CGRectMake(13*kWidthScale,150.3*kHeightScale,350*kWidthScale,176.3*kHeightScale);
    whiteView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
   whiteView.layer.cornerRadius = 6.7;
    
    [self.view addSubview:whiteView];
    
    
    
    UILabel *weichatLabel = [[UILabel alloc]init];
    weichatLabel.frame = CGRectMake(25.3*kWidthScale,173.7*kHeightScale,100*kWidthScale,12*kHeightScale);
    weichatLabel.numberOfLines = 0;
   NSString *weChatpublick = NSLocalizedStringFromTable(@"WeChat public account",@"Internation", nil);
   NSString * wechat = NSLocalizedStringFromTable(@"WeChat",@"Internation", nil);
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:wechat attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7],NSForegroundColorAttributeName: [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0]}];
    
    weichatLabel.attributedText = string;
    
    [self.view addSubview:weichatLabel];
    
    //微信号
    UILabel *wchatNumber = [[UILabel alloc] init];
    wchatNumber.frame = CGRectMake(103*kWidthScale,174*kHeightScale,150*kWidthScale,15*kHeightScale);
    wchatNumber.centerY = weichatLabel.centerY;
    wchatNumber.numberOfLines = 0;
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"seeryuanyuan" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7],NSForegroundColorAttributeName: [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0]}];
    
    wchatNumber.attributedText = string2;
    self.weichatLabel = wchatNumber;
     [self.view addSubview:wchatNumber];
    
//    //点击复制button
//    UIButton *wchatButton = [[UIButton alloc]init];
//
//    [wchatButton setTitle:@"复制" forState:UIControlStateNormal];
//    [wchatButton setTintColor:[UIColor whiteColor]];
//        wchatButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
//    [wchatButton setBackgroundImage:[UIImage imageNamed:@"pase_button"] forState:UIControlStateNormal];
//
//    wchatButton.frame = CGRectMake(255*kWidthScale, 10*kHeightScale, 100*kWidthScale, 40*kHeightScale);
//
////     wchatButton.centerY = wchatNumber.centerY;
//    [wchatButton addTarget:self action:@selector(passwordClick) forControlEvents:UIControlEventTouchUpInside];
//
//    [whiteView addSubview:wchatButton];
    
    
    
   //分割线
    
    UIView *lineview = [[UIView alloc] init];
    lineview.frame = CGRectMake(12.7*kWidthScale,208.7*kHeightScale,350*kWidthScale,0.3*kHeightScale);
   lineview.backgroundColor = [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0 alpha:1.0];
    
    [self.view addSubview:lineview];
    
    
    //微信公众号
    
    UILabel *weiPublickLabel = [[UILabel alloc] init];
    weiPublickLabel.frame = CGRectMake(27.3*kWidthScale,233*kHeightScale,150,12*kHeightScale);
    weiPublickLabel.numberOfLines = 0;
   
    
    NSMutableAttributedString *string3= [[NSMutableAttributedString alloc] initWithString:weChatpublick attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7],NSForegroundColorAttributeName: [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0]}];
    
    weiPublickLabel.attributedText = string3;
    
     [self.view addSubview:weiPublickLabel];
    
    
    UILabel *weiPublickNumber = [[UILabel alloc] init];
    weiPublickNumber.frame = CGRectMake(180,233.3*kHeightScale,100*kWidthScale,11.7*kHeightScale);
    weiPublickNumber.numberOfLines = 0;
    NSMutableAttributedString *string4 = [[NSMutableAttributedString alloc] initWithString:@"SEER区块链" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7],NSForegroundColorAttributeName: [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0]}];
    
    weiPublickNumber.attributedText = string4;
    self.weiPublickLabel = weiPublickLabel;
     [self.view addSubview:weiPublickNumber];
    
    
//    //点击复制button
//    UIButton *wchatButton2 = [[UIButton alloc]init];
//    
//    [wchatButton2 setTitle:@"复制" forState:UIControlStateNormal];
//    [wchatButton2 setTintColor:[UIColor whiteColor]];
//    wchatButton2.titleLabel.font = [UIFont systemFontOfSize:12.f];
//    [wchatButton2 setBackgroundImage:[UIImage imageNamed:@"pase_button"] forState:UIControlStateNormal];
//    
//    wchatButton2.frame = CGRectMake(255*kWidthScale, 70*kHeightScale, 100*kWidthScale, 40*kHeightScale);
//    
//    //     wchatButton.centerY = wchatNumber.centerY;
//    [wchatButton2 addTarget:self action:@selector(passwordClickbutton) forControlEvents:UIControlEventTouchUpInside];
//    
//    [whiteView addSubview:wchatButton2];
//    
    
    
    
    //分割线
    UIView *lineview2 = [[UIView alloc] init];
    lineview2.frame = CGRectMake(12.7*kWidthScale,267.7*kHeightScale,350.3*kWidthScale,0.3*kHeightScale);
    lineview2.backgroundColor = [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0 alpha:1.0];
    
    [self.view addSubview:lineview2];
    
    
    
    
}

-(void)passwordClick{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.weichatLabel.text;
    
    
}


-(void)passwordClickbutton{
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.weiPublickLabel.text;
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
