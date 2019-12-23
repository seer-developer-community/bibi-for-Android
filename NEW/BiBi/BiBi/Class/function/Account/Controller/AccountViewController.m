//
//  AccountViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/11/21.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "AccountViewController.h"
#import "walletView.h"
#import "AccountTableViewCell.h"
#import "RecordsViewController.h"
#import "BitsharesWalletObject.h"
#import "PredictHeaderModel.h"
#import "WuLoadingView.h"

@interface AccountViewController ()
<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) walletView *WalletView;

@property(nonatomic,strong)UITableView *accountTableView;

//@property (nonatomic,strong) BitsharesWalletObject *wallet;

@property(nonatomic,assign)float ammonunt;

@property(nonatomic,copy)NSString *name;

@property (nonatomic,assign) BOOL connected;

@property(nonatomic,strong)NSMutableArray *arry;

@property(nonatomic,strong)WuLoadingView *loadingView;

@end

@implementation AccountViewController




//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    while (self.view.subviews.count) {
//        [self.view.subviews performSelector:@selector(removeFromSuperview)];
//    }
//    if ([MoneyPacketManager moneyAcctountManager].isLogin) {
//        [self setTopView];
//        [self.view addSubview:self.accountTableView];
//    }else {
//
//    }
//}






-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [self setupUI];
//      [self.accountTableView reloadData];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // 阻塞当前方法，使方法进入等待
//        while (!self.connected) {}
//        // 当连接成功后发送消息
//        [self clicked];
//    });
    
    [self clicked];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopView];
//     [self setupUI];
    [self.view addSubview:self.accountTableView];
 
   
}


//-(void)setupUI{
//    _wallet = [[BitsharesWalletObject alloc]initWithChainId:@"cea4fdf4f5c2278f139b22e782b308928f04008b0fc2c79970a58974a2a28f91" prefix:@"SEER"];
//      [self needConnect];
//    __weak typeof(self) weakSelf = self;
//    _wallet.connectStatusChange = ^(WebsocketConnectStatus status) {
//        weakSelf.connected = status == WebsocketConnectStatusConnected;
//        NSLog(@"status change");
//        if (status ==WebsocketConnectStatusClosed) {
//
//            [weakSelf needConnect];
//        }
//    };
//
//
//}
//
//
//
//
//- (void)needConnect {
//    [_wallet connectUrl:@"ws://39.105.189.224/ws" timeOut:10 connectedError:^(NSError *error) {
//        NSLog(@"%@",error.description);
//
//        [self needConnect];
//    }];
//}



-(void)clicked{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        WuLoadingView *loadingView = [[WuLoadingView alloc]init];
        self.loadingView = loadingView;
        
        [loadingView showLoadingView];
    });
//    self.wallet
      __weak typeof(self) weakSelf = self;
    self.arry = [NSMutableArray arrayWithCapacity:100];
    __block int fined =0;
    [[BitsharesWalletObject BitsharesWalletObjectManager] getAccount:[MoneyPacketManager moneyAcctountManager].userName success:^(AccountObject *result) {
        [[BitsharesWalletObject BitsharesWalletObjectManager] listAccountBalance:result success:^(NSArray<AssetAmountObject *> * yuere) {
//            AssetAmountObject *amountObject = yuere.firstObject;
//
//            for ( AssetAmountObject *amountObject in yuere) {
//                PredictHeaderModel *model = [[PredictHeaderModel alloc]init];
//                if ([amountObject.assetId isEqual:@"1.3.0"]) {
//                    model.minNub = amountObject.amount/100000.00;
//                    [self.arry addObject:model];
//                }
//
//            }
//            [MoneyPacketManager moneyAcctountManager].surplus = amountObject.amount/100000.00;
//            NSLog(@"account surplus:%f",[MoneyPacketManager moneyAcctountManager].surplus);
            for (AssetAmountObject *amountObject in yuere) {
                fined++;
                PredictHeaderModel *model = [[PredictHeaderModel alloc]init];
                if ([amountObject.assetId isEqual:@"1.3.0"]) {
                    model.ass_id = [NSString stringWithFormat:@"%@",amountObject.assetId];
                    model.minNub = amountObject.amount/100000.00;
                    [MoneyPacketManager moneyAcctountManager].surplus = model.minNub;
                    [self.arry addObject:model];
                }else if ([amountObject.assetId isEqual:@"1.3.5"]){
                    model.minNub = amountObject.amount/100.00;
                    model.ass_id = [NSString stringWithFormat:@"%@",amountObject.assetId];
                    [MoneyPacketManager moneyAcctountManager].usdt_surplus =model.minNub;
                    [self.arry addObject:model];
                }
                else if([amountObject.assetId isEqual:@"1.3.2"]){
                    model.minNub = amountObject.amount/100000.00;
                    model.ass_id = [NSString stringWithFormat:@"%@",amountObject.assetId];
                     [MoneyPacketManager moneyAcctountManager].pdfc_surplus =model.minNub;
                    [self.arry addObject:model];
                }
            }
            if (fined == yuere.count) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.loadingView cancelView];
                    [weakSelf.accountTableView reloadData];
                    NSLog(@"走几遍");
                });
                
            }

           
        } error:^(NSError *error) {
            
        }];
        
    } error:^(NSError *error) {
        
    }];
    
    
   

}







-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    self.navigationController.navigationBarHidden = YES;
    self.navView.title =  NSLocalizedStringFromTable(@"Balance",@"Internation", nil);
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
}


-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(UITableView *)accountTableView{
    
    if (!_accountTableView) {
        
        _accountTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, self.navView.bottom, kScreenW, kScreenH - self.navView.height) style:UITableViewStylePlain];
        _accountTableView.delegate = self;
        _accountTableView.dataSource =self;
        
        [ _accountTableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        _accountTableView.backgroundColor = UIColorFromHexValue(0xf4f6fd);
        
    }
    
    
    return _accountTableView;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccountTableViewCell *cell = [AccountTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row ==0) {
        cell.cellimageView.image =[UIImage imageNamed:@"account_back"];
        cell.bizhongimageView.image =[UIImage imageNamed:@"account_seer"];
        cell.bizhongtextcount.text =@"SEER";
        cell.cellLabel.text = [NSString stringWithFormat:@"%.5f",[MoneyPacketManager moneyAcctountManager].surplus];
    }else if (indexPath.row ==1){
        cell.cellimageView.image =[UIImage imageNamed:@"account_pfc_iocn"];
        cell.bizhongimageView.image =[UIImage imageNamed:@"account_pfc"];
        cell.bizhongtextcount.text =@"PFC";
        cell.cellLabel.text = [NSString stringWithFormat:@"%.5f",[MoneyPacketManager moneyAcctountManager].pdfc_surplus];
        
    }else if (indexPath.row == 2){
        cell.cellimageView.image =[UIImage imageNamed:@"account_usdt_iocn"];
        cell.bizhongimageView.image =[UIImage imageNamed:@"account_usdt"];
        cell.bizhongtextcount.text =@"USDT";
        cell.cellLabel.text = [NSString stringWithFormat:@"%.5f",[MoneyPacketManager moneyAcctountManager].usdt_surplus];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 93*kHeightScale;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {

        RecordsViewController * vc = [[RecordsViewController alloc]init];
         PredictHeaderModel *model = [[PredictHeaderModel alloc]init];
         model.ass_id = @"1.3.0";
        vc.records_model = model;
        [self.navigationController pushViewController:vc animated:YES];

    }else if (indexPath.row ==1){
        RecordsViewController * vc = [[RecordsViewController alloc]init];
        PredictHeaderModel *model = [[PredictHeaderModel alloc]init];
        model.ass_id = @"1.3.2";
        vc.records_model = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 2){
        RecordsViewController * vc = [[RecordsViewController alloc]init];
        PredictHeaderModel *model = [[PredictHeaderModel alloc]init];
        model.ass_id = @"1.3.5";
        vc.records_model = model;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
//    PredictHeaderModel *model = [[PredictHeaderModel alloc]init];
//    model = self.arry[indexPath.row];
    
    
    
//    RecordsViewController * vc = [[RecordsViewController alloc]init];
//    vc.records_model = self.arry[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
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
