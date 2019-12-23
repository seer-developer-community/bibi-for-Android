//
//  WalletManageViewController.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/2.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "WalletManageViewController.h"
#import "ChangePasswordViewController.h"
#import "WalltMarkView.h"
#import "TestMineViewController.h"

#import "JBMTabBarController.h"
//

@interface WalletManageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *wallManageTableView;

@property(nonatomic,strong)NSArray *titleArry;

@end

@implementation WalletManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setTopView];
//    //钱包管理
//    "Change Password" ="修改密码";
//    "Delete Wallet" = "删除钱包";
    self.titleArry = @[NSLocalizedStringFromTable(@"Change Password",@"Internation", nil),NSLocalizedStringFromTable(@"Delete Wallet",@"Internation", nil)];
   
    [self.view addSubview:self.wallManageTableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
     NSLog(@"%@",[MoneyPacketManager moneyAcctountManager].passWored);
    
}



-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    
    self.navigationController.navigationBarHidden = YES;
    self.navView.title =NSLocalizedStringFromTable(@"Wallet Management",@"Internation", nil);
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
}


-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(UITableView *)wallManageTableView{
    
    if (!_wallManageTableView) {
        
        self.wallManageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navView.bottom+30, kScreenW, kScreenH) style:UITableViewStylePlain];
        self.wallManageTableView.delegate = self;
        self.wallManageTableView.dataSource = self;
        self.wallManageTableView.separatorStyle =   UITableViewCellSeparatorStyleSingleLine;
//        self.wallManageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.wallManageTableView.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    }
    
    return _wallManageTableView;
}


#pragma  mark ----------UITabelViewDataSource----------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"walletmange";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.text = self.titleArry[indexPath.row];
        [cell.textLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size: 12.7]];
        [cell.textLabel setTextColor:UIColorFromHexValue(0x444444)];
    }
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        ChangePasswordViewController *Cpassword = [[ChangePasswordViewController alloc]init];

        [self.navigationController pushViewController:Cpassword animated:YES];
        
    }else{
        
        WalltMarkView *wakView = [[WalltMarkView alloc]initWithTitleBiglable:NSLocalizedStringFromTable(@"Delete Wallet",@"Internation", nil) little:NSLocalizedStringFromTable(@"Attention Before",@"Internation", nil)];
       
        [wakView addButtonAction:^{
            
            [[MoneyPacketManager moneyAcctountManager] logout];
            dispatch_async(dispatch_get_main_queue(), ^{
                //回头好好看看这个强跳到一个控制器
                UITabBarController * rootVc = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
                    rootVc.selectedIndex = 0;
                [self.navigationController popToRootViewControllerAnimated:NO];
//               self.tabBarController.viewControllers = nil;
                // 这个是跳转到对应的哪个tabbar
//                self.tabBarController.viewControllers = [((JBMTabBarController *)self.tabBarController) getTabRootViewController];
//                JBMTabBarController *vc = [[JBMTabBarController alloc] init];
//                vc.view.backgroundColor = [UIColor whiteColor];
//
//                [UIApplication sharedApplication].keyWindow.rootViewController = vc;
//                vc.view.backgroundColor = [UIColor whiteColor];
                
                
                
               
                

                
//                 NSLog(@"%@",[[MoneyPacketManager moneyAcctountManager] mj_JSONObject]);
                
              
               
                
            });
            
//            [MoneyPacketManager moneyAcctountManager].isLogin = NO;
           
        }];
        
    }
    
}


#pragma mark ----------UITabelViewDelegate----------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 48;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return UIView.new;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return UIView.new;
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
