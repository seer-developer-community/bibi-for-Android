//
//  RecordsViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/18.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "RecordsViewController.h"
#import "RecordsTableViewCell.h"
#import "TranAccountViewController.h"
#import "NewTranAccountViewController.h"
#import "RechargeViewController.h"
#import "BitsharesWalletObject.h"
#import "OPModel.h"
#import "TrAccountModel.h"
#import "WuLoadingView.h"
#import "CashOutViewController.h"
@interface RecordsViewController ()
<UITableViewDataSource,UITableViewDelegate,RecordsViewDelegate,CashOutDelegate>

@property(nonatomic,strong)UITableView *recordsTableView;

@property(nonatomic,strong)UIView *bannerWhiteView;

//@property (nonatomic,strong) BitsharesWalletObject *wallet;

@property (nonatomic,assign) BOOL connected;

@property(nonatomic,strong)NSMutableArray *dataArry;

@property(nonatomic,strong)NSMutableArray *opModelArry;

@property (assign,  nonatomic) bool isPop;

//loading
@property(nonatomic,strong)WuLoadingView *loadingView;

//记录打印多少次
@property(nonatomic,assign)NSInteger countnumber;

//记录2
@property(nonatomic,assign)NSInteger gongnumber;

//记录没有转账记录的
@property(nonatomic,assign)NSInteger noNumber;



@end

@implementation RecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupURL];
    [self setTopView];
    [self setupUI];
    _isPop=NO;
    NSLog(@"-----%@-----",[MoneyPacketManager moneyAcctountManager].userName);
    [self clicked];

    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // 阻塞当前方法，使方法进入等待
//        while (!self.connected) {}
//        // 当连接成功后发送消息
//        [self clicked];
//    });
//     [self clicked];
}




-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    self.navigationController.navigationBarHidden = YES;
    if ([_records_model.ass_id isEqualToString:@"1.3.0"]) {
        self.navView.title = @"SEER";
    }else if ([_records_model.ass_id isEqualToString:@"1.3.5"]){
         self.navView.title = @"USDT";
    }else if ([_records_model.ass_id isEqualToString:@"1.3.2"]){
        self.navView.title = @"PFC";
    }
    
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
}


-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}




//-(void)setupURL{
//    _wallet = [[BitsharesWalletObject alloc]initWithChainId:@"cea4fdf4f5c2278f139b22e782b308928f04008b0fc2c79970a58974a2a28f91" prefix:@"SEER"];
//
//    [self needConnect];
//
//    __weak typeof(self) weakSelf = self;
//
//    _wallet.connectStatusChange = ^(WebsocketConnectStatus status) {
//        weakSelf.connected = status == WebsocketConnectStatusConnected;
//        NSLog(@"status change");
//    };
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // 阻塞当前方法，使方法进入等待
//        while (!self.connected) {}
//        // 当连接成功后发送消息
//                [self clicked];
//    });
//
//
//    //    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
//
//
//}
//
//
//
//- (void)needConnect {
//    [_wallet connectUrl:@"ws://39.105.189.224/ws" timeOut:10 connectedError:^(NSError *error) {
//        NSLog(@"%@",error.description);
//        [self needConnect];
//    }];
//}



-(void)clicked{
    dispatch_async(dispatch_get_main_queue(), ^{
        WuLoadingView *loadingView = [[WuLoadingView alloc]init];
        self.loadingView = loadingView;
        [loadingView showLoadingView];
    });
     __weak typeof(self) _self = self;
    self.dataArry = [NSMutableArray arrayWithCapacity:100];
    self.opModelArry = [NSMutableArray arrayWithCapacity:200];
    [[BitsharesWalletObject BitsharesWalletObjectManager] getAccount:M_userName success:^(AccountObject *user_result) {
        NSString *identifier = [NSString stringWithFormat:@"%@",user_result.identifier];
        [[BitsharesWalletObject BitsharesWalletObjectManager] getHistroyAccount:identifier success:^(NSArray<AccountHistoryModle *> *result) {
            
            if (result.count<=0) {
                [self.loadingView cancelView];
                
                return;
            }
            _self.countnumber = 0;
            _self.gongnumber =0;
            _self.noNumber = 0;
            for (AccountHistoryModle *model in result) {
                
                if ([(model.op.firstObject)intValue] ==0) {
                    
                    OPModel *opModel = [OPModel generateFromObject:model.op.lastObject];
                    if ([[opModel.amount valueForKey:@"asset_id"]isEqualToString:_self.records_model.ass_id]) {
                        _self.countnumber++;
                        
                    }else{
                        NSLog(@"进来2次");
                        [self kong:result.count];
                        
                    }
                }else{
                    NSLog(@"进来1次");
                    [self kong:result.count];
                  
                }
            }
            
            
            for (AccountHistoryModle *model in result) {
                if ([(model.op.firstObject) intValue] ==0){
                    OPModel *opModel = [OPModel generateFromObject:model.op.lastObject];
                    NSLog(@"------------%@---------",model.block_num);
                    __block TrAccountModel *trmodel = [[TrAccountModel alloc]init];
                    trmodel.feerCount = [[opModel.fee valueForKey:@"amount"] doubleValue];
                    
                    trmodel.jinerCount = [[opModel.amount valueForKey:@"amount"] doubleValue];
                    if ([[opModel.amount valueForKey:@"asset_id"]isEqualToString:_self.records_model.ass_id]) {
                       
                        trmodel.ass_id =_self.records_model.ass_id;
                        [_self initDataWith:trmodel and:model and:opModel];
                        
                    }
                }
            }
        } error:^(NSError *error) {
            
        }];
        
    } error:^(NSError *error) {
        
    }];
    
}


-(void)kong:(NSInteger)reultCount{
     NSLog(@"进来2次");
    self.noNumber ++;
    if ((self.noNumber == reultCount)) {
        [self.loadingView cancelView];
        return;
    }
    
}

- (void)initDataWith:(TrAccountModel*)trmodel and:(AccountHistoryModle*)model and:(OPModel*)opModel{
    
    NSLog(@"------%lld=------",trmodel.feerCount);
    
    dispatch_group_t downloadGroup = dispatch_group_create();
    dispatch_group_enter(downloadGroup);
    [[BitsharesWalletObject BitsharesWalletObjectManager] getBlockNum:model.block_num success:^(NSDictionary *result) {
        trmodel.dataTime = [result valueForKey:@"timestamp"];
        NSLog(@"这个时间是多少%@",trmodel.dataTime);
        dispatch_group_leave(downloadGroup);
        
    } error:^(NSError *error) {
        dispatch_group_leave(downloadGroup);
    }];
    dispatch_group_enter(downloadGroup);
    [[BitsharesWalletObject BitsharesWalletObjectManager] getAccount:opModel.from success:^(AccountObject *result) {
        trmodel.fromnName = result.name;
        dispatch_group_leave(downloadGroup);
        NSLog(@"转账人的名字是谁%@",trmodel.fromnName);
    } error:^(NSError *error) {
        dispatch_group_leave(downloadGroup);
    }];
    dispatch_group_enter(downloadGroup);
    [[BitsharesWalletObject BitsharesWalletObjectManager] getAccount:opModel.to success:^(AccountObject *result) {
        trmodel.tooName = result.name;
        NSLog(@"收款人的姓名是谁%@",trmodel.tooName);
        NSLog(@"收款人的姓名是谁%@",[[self.dataArry firstObject] mj_JSONObject]);
        dispatch_group_leave(downloadGroup);

    } error:^(NSError *error) {
        dispatch_group_leave(downloadGroup);
    }];
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
         [self.dataArry addObject:trmodel];
        NSArray * soertArray = [self.dataArry sortedArrayUsingComparator:^NSInteger(TrAccountModel *  _Nonnull modle1, TrAccountModel*  _Nonnull modle2) {
            NSInteger result = [modle1.dataTime compare: modle2.dataTime];
            return result == NSOrderedAscending; // 降序
        }];
        [self.dataArry removeAllObjects];
        self.dataArry= [NSMutableArray arrayWithArray:soertArray];
        self.gongnumber ++;
        if (self.countnumber == self.gongnumber ) {
            [self.recordsTableView reloadData];
            NSLog(@"打印几次");
            [self.loadingView cancelView];
        }
    });
}



-(void)setupUI{
    
    UIView *bannerWhiteView = [[UIView alloc]init];
    
    bannerWhiteView.backgroundColor = [UIColor whiteColor];
    
    bannerWhiteView.frame = CGRectMake(0, self.navView.bottom, kScreenW, 75*kHeightScale);
    
    self.bannerWhiteView = bannerWhiteView;
    [self.view addSubview:bannerWhiteView];
    
    //充值button
    UIButton *rechargeButton = [[UIButton alloc]init];
    
    [rechargeButton setBackgroundImage:[UIImage imageNamed:NSLocalizedStringFromTable(@"Recharge2",@"Internation", nil)] forState:UIControlStateNormal];
    
    rechargeButton.frame = CGRectMake(7*kWidthScale, 0, 120*kWidthScale, 62*kHeightScale);
    
    [rechargeButton addTarget:self action:@selector(rechargerClick) forControlEvents:UIControlEventTouchUpInside];
    
    [bannerWhiteView addSubview:rechargeButton];
    
    //转账button
    
    UIButton *tranButton = [[UIButton alloc]init];
    
    [tranButton setBackgroundImage:[UIImage imageNamed:NSLocalizedStringFromTable(@"Transfer2",@"Internation", nil)] forState:UIControlStateNormal];
    
    tranButton.frame = CGRectMake(7*kWidthScale + rechargeButton.width, 0, 120*kWidthScale, 62*kHeightScale);
    
    [tranButton addTarget:self action:@selector(tranCliclk) forControlEvents:UIControlEventTouchUpInside];
    
    [bannerWhiteView addSubview:tranButton];
    
    
    UIButton *cash_out = [[UIButton alloc]init];
    
    [cash_out setBackgroundImage:[UIImage imageNamed:NSLocalizedStringFromTable(@"Cashouticon",@"Internation", nil)] forState:UIControlStateNormal ];
    cash_out.frame = CGRectMake(7*kWidthScale + rechargeButton.width*2, 0, 120*kWidthScale, 62*kHeightScale);
    
     [bannerWhiteView addSubview:cash_out];
    [cash_out addTarget:self action:@selector(cashoutClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.recordsTableView];
    
}

//
-(void)cashoutClick{
    CashOutViewController *Cvc = [[CashOutViewController alloc]init];
    Cvc.cashOutDelegate =self;
    Cvc.cash_model = self.records_model;
   
    [self.navigationController pushViewController:Cvc animated:YES];
    
}


//转账跳转

-(void)tranCliclk{
    
    NewTranAccountViewController *tvc = [[NewTranAccountViewController alloc]init];
    tvc.trans_model = self.records_model;
    tvc.recordsViewDelegate =self;
    
    [self.navigationController pushViewController:tvc animated:YES];
    
    
}

//充值
-(void)rechargerClick{
    RechargeViewController *reVc = [[RechargeViewController alloc]init];
    reVc.recharge_model = self.records_model;
    [self.navigationController pushViewController:reVc animated:YES];
}


//提现代理刷新
-(void)RecordsViewReload{
    
    [self clicked];
    [self.recordsTableView reloadData];
}


//代理
-(void)CashOutReload{
//    if (self.connected) {
        [self clicked];
     [self.recordsTableView reloadData];
//    }
}





//初始化tableview
-(UITableView *)recordsTableView{
    
    if (!_recordsTableView) {
        
        _recordsTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, self.bannerWhiteView.bottom, kScreenW, kScreenH - self.navView.height-TOOLBAR_BASICHEIGHT*2) style:UITableViewStyleGrouped];
        _recordsTableView.delegate = self;
        _recordsTableView.dataSource =self;
        
//        [ _recordsTableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        _recordsTableView.backgroundColor = UIColorFromHexValue(0xf4f6fd);
     
    }
    
    
    return _recordsTableView;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArry.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecordsTableViewCell *cell = [RecordsTableViewCell cellWithTableView:tableView];
    
    cell.historyModel = self.dataArry[indexPath.row];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 93*kHeightScale;
}







#pragma mark ----  TabViewdelegate代理
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc]init];
    
    UIView *lineview = [[UIView alloc] init];
    lineview.backgroundColor = [UIColor colorWithRed:42/255.0 green:125/255.0 blue:223/255.0 alpha:1.0];
    lineview.layer.cornerRadius = 1.7;
    [headView addSubview:lineview];
    
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(13*kWidthScale);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(3*kWidthScale, 13*kHeightScale));
        
    }];
    
    UILabel * rlabel = [[UILabel alloc]init];
    rlabel.numberOfLines = 0;
    rlabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 12.7];
    rlabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    rlabel.text = NSLocalizedStringFromTable(@"Transaction Records",@"Internation", nil);
    [headView addSubview:rlabel];
    
    [rlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineview.mas_right).offset(7*kWidthScale);
        make.centerY.mas_equalTo(lineview.mas_centerY);
    }];
    
    return headView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectZero];
}


-(void)dealloc{
      NSLog(@"页面销毁");
}

@end
