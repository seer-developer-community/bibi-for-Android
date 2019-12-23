//
//  CreateWalletViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/11/29.
//  Copyright © 2018 武建斌. All rights reserved.
//





#import "CreateWalletViewController.h"
#import "LoginViewController.h"
#import "InventorViewController.h"

@interface CreateWalletViewController ()

@end

@implementation CreateWalletViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBarHidden = YES;
    
//    self.navView.title = @"创建/导入钱包";
    
    
}

////创建钱包
//"CreateImport Wallet" = "创建/导入钱包";
//"Create a Better" = "用区块链技术打造更美好的金融世界";
//"Create Wallet" ="导入钱包";
//"Import Wallet" ="导入钱包";


-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    
    self.navigationController.navigationBarHidden = YES;
    self.navView.title = NSLocalizedStringFromTable(@"CreateImport Wallet",@"Internation", nil);
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
}


-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopView];

    [self creteWallet];
    
}


-(void)creteWallet{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bibiImageView = [[UIImageView alloc]init];
    
    [bibiImageView setImage:[UIImage imageNamed:@"logo"]];
    
    [self.view addSubview:bibiImageView];
    
    //bibilogo布局
    
    [bibiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(141*kWidthScale);
        make.size.mas_equalTo(CGSizeMake(151*kWidthScale, 72*kHeightScale));
        
    }];
    
    //logolabel
    
    UILabel *logoLabel = [[UILabel alloc]init];
 
//   logoLabel.frame = CGRectMake(103.3,245.7,208.3,11.3);
    logoLabel.numberOfLines = 0;
    [self.view addSubview:logoLabel];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"Create a Better",@"Internation", nil) attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0]}];
    logoLabel.attributedText = string;
    
    [logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(bibiImageView.mas_bottom).offset(33*kHeightScale);
        
        make.centerX.mas_equalTo(0);
        
    }];
    
    
    //创建钱包
    UIButton *creatWalletButton = [[UIButton alloc]init];
    
    [creatWalletButton setBackgroundImage:[UIImage imageNamed:@"setWallet"] forState:UIControlStateNormal];
    
    [creatWalletButton setTitle:NSLocalizedStringFromTable(@"Create Wallet",@"Internation", nil) forState:UIControlStateNormal];
    
    [creatWalletButton setTintColor:[UIColor whiteColor]];
    
    creatWalletButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18.f];
    
    [creatWalletButton addTarget:self action:@selector(creatWallet) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:creatWalletButton];
    
    [creatWalletButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(logoLabel.mas_bottom).offset(102*kHeightScale);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(5*kWidthScale);
        make.right.mas_equalTo(-5*kWidthScale);
        
    }];
    
    
    
    //导入钱包
    
    
    
    
    UIButton *putWalletButton = [[UIButton alloc]init];
    
    [putWalletButton setBackgroundImage:[UIImage imageNamed:@"put_in"] forState:UIControlStateNormal];
    
    [putWalletButton setTitle:NSLocalizedStringFromTable(@"Import Wallet",@"Internation", nil) forState:UIControlStateNormal];
    
    [putWalletButton setTitleColor:[UIColor colorWithRed:44/255.0 green:134/255.0 blue:227/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    putWalletButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18.f];
    
    [putWalletButton addTarget:self action:@selector(inventorWallet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:putWalletButton];
    
    [putWalletButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(creatWalletButton.mas_bottom).offset(9*kHeightScale);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(10*kWidthScale);
        make.right.mas_equalTo(-10*kWidthScale);
        
    }];
    

}


-(void)creatWallet{
    
    
    LoginViewController *vc = [[LoginViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

-(void)inventorWallet{
    
    InventorViewController *invetorVC = [[InventorViewController alloc]init];
    
    [self.navigationController pushViewController:invetorVC animated:YES];
    
}


-(void)dealloc{
    
    
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
