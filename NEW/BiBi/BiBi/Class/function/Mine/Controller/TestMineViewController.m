//
//  TestMineViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/17.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "TestMineViewController.h"

#import "MineTableViewCell.h"
#import "MineTableViewHeaderView.h"
#import "ConnectionViewController.h"
#import "SetAboutViewController.h"
#import "WalletManageViewController.h"
@interface TestMineViewController ()<UITableViewDelegate,UITableViewDataSource>
//tableView

@property(nonatomic,strong)UIView *mine_headView;
@property(nonatomic,strong)MineTableViewHeaderView *caseHeaderView;


//图片数组
@property(nonatomic,strong)NSArray *imageArry;

//文字数组
//@property(nonatomic,strong)NSArray *labelArry;

@end

@implementation TestMineViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    if (self.mintableView) {
        [self.mintableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.title = NSLocalizedStringFromTable(@"Profile",@"Internation", nil);
    
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);

    [self setupUI];
}


-(void)setupUI{
    
    [self.view addSubview:self.mintableView];
    
    self.imageArry = @[@"Mine_callme",@"Mine_set"];
    
    self.labelArry = @[NSLocalizedStringFromTable(@"Contact Us",@"Internation", nil),NSLocalizedStringFromTable(@"Setings",@"Internation", nil)];
}


-(MineTableView *)mintableView{
    
    if(!_mintableView){
        
        _mintableView = [[MineTableView alloc]initWithFrame:CGRectMake(0, self.navView.bottom, kScreenW, kScreenH - self.navView.height-88) style:UITableViewStyleGrouped];
        _mintableView.delegate = self;
        _mintableView.dataSource =self;
    
        _mintableView.separatorStyle =   UITableViewCellSeparatorStyleSingleLine;
        
        _mintableView.backgroundColor = UIColorFromHexValue(0xf4f6fd);
        
//        _mintableView.layer.masksToBounds = NO;
       
    }
    
    return _mintableView;
}

#pragma mark ----------UITabelViewDataSource----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
    }
   
    return  [self.imageArry count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     MineTableViewCell *cell = [MineTableViewCell cellWithTableView:tableView];
    if (indexPath.section == 0) {
        cell.cellimageView.image =[UIImage imageNamed:@"Mine_wallet"];
        cell.cellLabel.text =NSLocalizedStringFromTable(@"Wallet Management",@"Internation", nil);
    }else{
        
        cell.cellimageView.image = [UIImage imageNamed:self.imageArry[indexPath.row]];
        cell.cellLabel.text = self.labelArry[indexPath.row];
        
        
        
    }
    
        return cell;

}


#pragma mark ----  TabViewdelegate代理
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 113;
    }
  
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 20;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        self.caseHeaderView  = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"caseHeaderView"];
        if (self.caseHeaderView ==nil ) {
            self.caseHeaderView  = [[MineTableViewHeaderView alloc]initWithReuseIdentifier:@"caseHeaderView"];
        }
        NSLog(@"mine get userName:%@",[MoneyPacketManager moneyAcctountManager].userName);
        self.caseHeaderView.userName = [MoneyPacketManager moneyAcctountManager].userName;
        return self.caseHeaderView;
    }

    return UIView.new;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        if (indexPath.row == 0) {
            WalletManageViewController *walletMangeVC = [[WalletManageViewController alloc]init];
            [self.navigationController pushViewController:walletMangeVC animated:YES];
            
        }
    }
    
    if (indexPath.section ==1) {
        if (indexPath.row == 0) {
            ConnectionViewController *vc = [[ConnectionViewController alloc]init];
//            vc.navView.title = self.labelArry[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
    
    if (indexPath.section == 1&&indexPath.row == 1) {
        
        SetAboutViewController *vc = [[SetAboutViewController alloc]init];
//         vc.navView.title = self.labelArry[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}


@end
