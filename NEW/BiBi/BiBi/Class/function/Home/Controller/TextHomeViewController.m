//
//  TextHomeViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/18.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "TextHomeViewController.h"
#import "SDCycleScrollView.h"
#import "DetailsTableViewCell.h"
#import "DetailsModel.h"
#import "BitsharesWalletObject.h"
#import "PredictViewController.h"
#import "NewestViewController.h"
#import "CurrencyViewController.h"
#import "HotIssueViewController.h"
#import "HotViewController.h"
#import "SportsViewController.h"
#import "JZLoadingViewPacket.h"
#import "XLCycleCollectionView.h"
#import "WuLoadingView.h"
#import "RegisterView.h"
#import "LoginViewController.h"
#import "MJRefresh.h"
#import "NumberLabel.h"
#import "XDUpdateManager.h"
@interface TextHomeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,CPColltionViewboardProtocol,RegisterViewDelegate>

@property(nonatomic,strong)UITableView * referralTableView;
@property(nonatomic,strong)UIView *whiteView;

@property (nonatomic,strong) BitsharesWalletObject *wallet;

@property (nonatomic,assign) BOOL connected;

//显示内容的数组
@property(nonatomic,strong)NSMutableArray *dataArray;

// 存第一个的数组
@property(nonatomic,strong)NSMutableDictionary *fristDic;

//存第二个的数组
@property(nonatomic,strong)NSMutableDictionary *secondDic;

@property(nonatomic,strong)NSMutableArray *secondArray;

@property(nonatomic,strong)NSMutableArray *titleArry;
@property(nonatomic,strong)UIView *viewVC;

@property(nonatomic,strong)WuLoadingView *loadingView;

@property(nonatomic,strong)RegisterView *registerView;


@property (nonatomic, assign) BOOL isNeedRefesh;

//@property(nonatomic,strong) NumberLabel *dataLabel;
@end

@implementation TextHomeViewController



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//
//    [[BitsharesWalletObject BitsharesWalletObjectManager] needConnect];
//
//    [BitsharesWalletObject BitsharesWalletObjectManager].connectStatusChange = ^(WebsocketConnectStatus status) {
//
//        self.connected = status == WebsocketConnectStatusConnected;
//
//        NSLog(@"status change");
//        if (status ==WebsocketConnectStatusClosed) {
//
//            [[BitsharesWalletObject BitsharesWalletObjectManager] needConnect];
////            [self clicked];
//
//        }
//    };
//
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.cw.pub/z9ke"]];


}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
        if ([BitsharesWalletObject BitsharesWalletObjectManager].connected) {
            [self clicked];
        }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [XDUpdateManager CheckVersionUpadateWithForce:NO];
    _isNeedRefesh = YES;
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.referralTableView];
//    self.dataLabel = [[NumberLabel alloc]initWithFrame:CGRectMake(kScreenW/2, kScreenH/2, 70, 30)];
//    self.dataLabel.centerX = self.view.centerX;
//    [self.view addSubview:self.dataLabel];
     self.referralTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        [[BitsharesWalletObject BitsharesWalletObjectManager] needConnect];
        [BitsharesWalletObject BitsharesWalletObjectManager].connectStatusChange = ^(WebsocketConnectStatus status) {
            NSLog(@"status change");
            if (status ==WebsocketConnectStatusClosed) {
                [[BitsharesWalletObject BitsharesWalletObjectManager] needConnect];
            }else if (status == WebsocketConnectStatusConnected) {
                [self clicked];
            }
        };

//
    
//       dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        //        // 阻塞当前方法，使方法进入等待
//                while (!self.connected) {}
//        //        // 当连接成功后发送消息
//                    [self clicked];
//           NSLog(@"走到这里");
//
//        //
//            });
    

//        [self clicked];
    
//        if ([BitsharesWalletObject BitsharesWalletObjectManager].Click) {
//
//
//            [self clicked];
//            [BitsharesWalletObject BitsharesWalletObjectManager].Click = NO;
//        }

}
//
//-(void)setupUI{
////    WuLoadingView *loadingView = [[WuLoadingView alloc]init];
////    self.loadingView = loadingView;
////    [loadingView showLoadingView];
//    _wallet = [[BitsharesWalletObject alloc]initWithChainId:@"cea4fdf4f5c2278f139b22e782b308928f04008b0fc2c79970a58974a2a28f91" prefix:@"SEER"];
//    [self needConnect];
//
//    __weak typeof(self) weakSelf = self;
//
//    _wallet.connectStatusChange = ^(WebsocketConnectStatus status) {
//        weakSelf.connected = status == WebsocketConnectStatusConnected;
//        NSLog(@"status change");
//        if (status ==WebsocketConnectStatusClosed) {
//
//            [weakSelf needConnect];
//        }
//    };
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // 阻塞当前方法，使方法进入等待
//        while (!self.connected) {}
//        // 当连接成功后发送消息
//            [self clicked];
//
//    });
//
//}


//- (void)needConnect {
//    [_wallet connectUrl:@"ws://39.105.189.224/ws" timeOut:10 connectedError:^(NSError *error) {
//        NSLog(@"%@",error.description);
//        if (error.code == 50) {
////            Check the network
//            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Prompt",@"Internation", nil) message:NSLocalizedStringFromTable(@"Check the network",@"Internation", nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"Buttonsure",@"Internation", nil) otherButtonTitles:nil];
//            [alert show];
//            return;
//        }
//        [self needConnect];
//    }];
//}

- (void)getRoomsInfo:(NSArray*)rooms platformIndex:(int)index{
    NSMutableArray * tempArray = [NSMutableArray array];
    __weak typeof(self) _self = self;
    __block int finisCount = 0;
    __block int orderCount = 0;
    if (rooms.count == 0) {
        [self refreshCurrentViewWith:tempArray andPlatForm:index andOrderCount:orderCount];
    }else{
        for (int room = 0; room < rooms.count; room++){
            [[BitsharesWalletObject BitsharesWalletObjectManager] getSeerRoom:@"get_seer_room"  fristString:rooms[room] nLimint:0 secondInt:100 success:^(RoomAccount *result2) {
                
                finisCount ++;
                DetailsModel *modle = [[DetailsModel alloc]init];
                modle.roomId = result2.identifier;
                modle.time = result2.option.stop;
                modle.time1 = result2.option.stop;
                modle.startTimer = result2.option.start;
                modle.title = result2.description_des;
//                if (result2.option.accept_asset isEqualToString:@"1.3.0") {
//                    <#statements#>
//                }
              
                modle.totalpeople = result2.running_option.total_player_count;
                modle.percent = result2.option.result_owner_percent/100;
                modle.accept_asset = result2.option.accept_asset;
                if ([modle.accept_asset isEqualToString:@"SEER"]||[modle.accept_asset isEqualToString:@"PFC"]){
                    
                    modle.totalmoneyaCount = result2.running_option.total_shares/100000;
                    modle.minNub = result2.option.minimum/100000;
                    modle.maxNub = result2.option.maximum/100000;
                }else if ([modle.accept_asset isEqualToString:@"USDT"]){
                    modle.totalmoneyaCount = result2.running_option.total_shares/100;
                    modle.minNub = result2.option.minimum/100;
                    modle.maxNub = result2.option.maximum/100;
                }
                modle.ass_id =result2.option.accept_asset;
                modle.choseButcount = result2.running_option.selection_description;
//                if ([result2.option.accept_asset isEqualToString:TextUSDT_room]) {
//                    modle.minNub = result2.option.minimum /100;
//                    modle.maxNub = result2.option.maximum/100;
//                }else{
//                    modle.minNub = result2.option.minimum /100000;
//                    modle.maxNub = result2.option.maximum/100000;
//                }
//                modle.minNub = result2.option.minimum ;
//                modle.maxNub = result2.option.maximum;
               
                modle.total_shares = result2.running_option.total_shares;
                modle.proportion =[result2.running_option.pvp_running valueForKey:@"total_participate"];
                modle.room_type = result2.room_type;
                //固定金额
                modle.pool = result2.running_option.advanced.pool;
                modle.awards = result2.running_option.advanced.awards;
                //固定赔付金额和投注金额
                modle.total_participate = result2.running_option.advanced_running.total_participate;
                //份数选项
                modle.items_countNum = result2.running_option.lmsr_running.items_countNum;
                //那个L
                modle.lmsr_number = result2.running_option.lmsr.lmsr_number;
                modle.hight = 0;
                NSComparisonResult result8 = [[_self getCurrentTimes] compare:modle.time];
                if (result8 == NSOrderedAscending) {
                    [tempArray addObject:modle];
                }
                if (finisCount == rooms.count) {
                    //                orderCount++;
                    [_self refreshCurrentViewWith:tempArray andPlatForm:index andOrderCount:orderCount];
                    NSLog(@"这个房间的数量是多少%ld",rooms.count);
                    NSLog(@"这个fincount的数量%d",finisCount);
                }
            } error:^(NSError *error) {
                finisCount ++;
                if (finisCount == rooms.count) {
                    [_self refreshCurrentViewWith:tempArray andPlatForm:index andOrderCount:orderCount];
                    
                }
            }];
        }
    }
  
   
}

- (void)refreshCurrentViewWith:(NSMutableArray*)tempArray andPlatForm:(int)index andOrderCount:(int)orderCount {
      __weak typeof(self) _self = self;
    NSArray * soertArray = [tempArray sortedArrayUsingComparator:^NSInteger(DetailsModel *  _Nonnull modle1, DetailsModel*  _Nonnull modle2) {
        NSInteger result = [modle1.startTimer compare: modle2.startTimer];
        return result == NSOrderedAscending; // 升序
    }];
//    int sprtarry = 1;
//    int sprtarry2 = 1;
    if (soertArray.firstObject){
        [self.fristDic setObject:soertArray.firstObject forKey:[NSString stringWithFormat:@"%d",index]];
          NSLog(@"firstDic一共走了几次");
    }
    
    if (soertArray.count==1) {
         [self.secondDic setObject:@"" forKey:[NSString stringWithFormat:@"%d",index]];
//         sprtarry2++;
         NSLog(@"secondDic一共2几次");
    }
    
    if (soertArray.count > 1) {//在这娶第二个
        //        int sprtarry2 = 0;
        [self.secondDic setObject:soertArray[1] forKey:[NSString stringWithFormat:@"%d",index]];
    }
    
    
    if (soertArray.count ==0) {
         [self.fristDic setObject:@"" forKey:[NSString stringWithFormat:@"%d",index]];
         [self.secondDic setObject:@"" forKey:[NSString stringWithFormat:@"%d",index]];
     
    }

    if (self.fristDic.allKeys.count == 3) {
        for (NSString * key in self.fristDic.allKeys) {
            NSInteger  index = [key intValue];
            DetailsModel * detal =  self.fristDic[key];
            
            if ([detal isKindOfClass:[DetailsModel class]]) {
                switch (index) {
                    case 0:
                    {
                        [self.dataArray replaceObjectAtIndex:1 withObject:detal];
                    }
                        break;
                    case 1:
                    {
                        [self.dataArray replaceObjectAtIndex:0 withObject:detal];
                    }
                        break;
                    case 2:
                    {
                        [self.dataArray replaceObjectAtIndex:2 withObject:detal];
                        
                    }
                        break;
                        
                    default:
                        break;
                }
            }
            
        }
        NSMutableArray * mnTempArray = [NSMutableArray arrayWithArray:self.dataArray.copy];
        
//        int suoYin = 0;
        
        for (id subInfo in mnTempArray) {
            if (![subInfo isKindOfClass:[DetailsModel class]]) {
                [self.dataArray removeObject:subInfo];
            }
//            suoYin ++;
            
        }
        
        
        if (self.secondDic.allKeys.count == 3) {

            for (NSString *key1 in self.secondDic.allKeys) {
                NSInteger index1 = [key1 integerValue];
                DetailsModel *detal1 = self.secondDic[key1];
                if ([detal1 isKindOfClass:[DetailsModel class]]) {

                    switch (index1) {
                        case 0:
                        {
                            [self.secondArray replaceObjectAtIndex:1 withObject:detal1];

                        }
                            break;
                        case 1:
                        {
                            [self.secondArray replaceObjectAtIndex:0 withObject:detal1];
                        }
                            break;
                        case 2:
                        {

                            [self.secondArray replaceObjectAtIndex:2 withObject:detal1];


                        }
                            break;
                        default:
                            break;
                    }
                }

            }
        }

//
//

        NSMutableArray * wnTempArray = [NSMutableArray arrayWithArray:self.secondArray.copy];


        for (id subInfo in wnTempArray) {
            if (![subInfo isKindOfClass:[DetailsModel class]]) {
                [self.secondArray removeObject:subInfo];
              
               
            }
//            if (suoYin1 <=2) {
//                suoYin1 ++;
//            }
            
        }


        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"refresh table view platform:%d",index);
            [self.referralTableView reloadData];
            [self endRefresh];
            [self.loadingView cancelView];
            _self.isNeedRefesh = NO;
            if (![MoneyPacketManager moneyAcctountManager].isHiddenImage &&![MoneyPacketManager moneyAcctountManager].isLogin) {
                self.registerView = [[RegisterView alloc]init];
                self.registerView.delegate = self;
            }
        });
    }
}


-(void)clicked{
//    WuLoadingView *loadingView = [[WuLoadingView alloc]init];
//    self.loadingView = loadingView;
//    [loadingView showLoadingView];
   
    [self.loadingView cancelView];
    if (!_isNeedRefesh) {
        return;
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        WuLoadingView *loadingView = [[WuLoadingView alloc]init];
        self.loadingView = loadingView;
        
        [loadingView showLoadingView];
    });
    
    self.dataArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
//    self.dataArray = [NSMutableArray array];
//    self.secondArray = [NSMutableArray array];
    self.fristDic= [NSMutableDictionary dictionary];
    self.secondArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",nil];
    self.secondDic = [NSMutableDictionary dictionary];
    __weak typeof(self) weakSelf = self;
//1.14.8  1.14.7  1.14.9
    NSString *oneStr = NSLocalizedStringFromTable(@"Sports",@"Internation", nil);
    NSString *twoStr =NSLocalizedStringFromTable(@"bibiquan",@"Internation", nil);
    NSString *thirsStr = NSLocalizedStringFromTable(@"hot top",@"Internation", nil);
    for (int i = 0; i<3; i++) {
        [[BitsharesWalletObject BitsharesWalletObjectManager] getPlatform:@"get_houses" unploadParamsTotalParams:@[oneStr,twoStr,thirsStr] paltNum:i success:^(PlatAccount *result) {
            
            [weakSelf getRoomsInfo:result.rooms platformIndex:i];
            
//             NSLog(@"firstObject一共走了几次");
//            return ;
//            __weak typeof(self) weakSelf = self;
//            for (int room = 0; room < result.rooms.count; room++)
//            {
//               NSMutableArray * tempArray = [NSMutableArray array];
//                [weakSelf.wallet getSeerRoom:@"get_seer_room"  fristString:result.rooms[room] nLimint:0 secondInt:100 success:^(RoomAccount *result2) {
//
//                    self.viewVC.hidden = YES;
////                    view.hidden = YES;
//                    if (result.rooms[room]) {
//                        DetailsModel *modle = [[DetailsModel alloc]init];
//                        modle.roomId = result2.identifier;
//                        modle.time = result2.option.stop;
//                        modle.startTimer = result2.option.start;
//                        modle.title = result2.description_des;
//                        modle.totalmoneyaCount = result2.running_option.total_shares/100000;
//                        modle.totalpeople = result2.running_option.total_player_count;
//                        modle.percent = result2.option.result_owner_percent/100;
//                        modle.choseButcount = result2.running_option.selection_description;
//                        modle.minNub = result2.option.minimum /100000;
//                        modle.maxNub = result2.option.maximum/100000;
//                        modle.total_shares = result2.running_option.total_shares;
//                        modle.proportion =[result2.running_option.pvp_running valueForKey:@"total_participate"];
//                        modle.room_type = result2.room_type;
//                        //固定金额
//                        modle.pool = result2.running_option.advanced.pool;
//                        modle.awards = result2.running_option.advanced.awards;
//                        //固定赔付金额和投注金额
//                        modle.total_participate = result2.running_option.advanced_running.total_participate;
//
//                        modle.hight = 0;
//                        NSComparisonResult result8 = [[self getCurrentTimes] compare:modle.time];
//                        if (result8 == NSOrderedAscending) {
//                            [tempArray addObject:modle];
//                        }
//
//                        NSArray * soertArray = [tempArray sortedArrayUsingComparator:^NSInteger(DetailsModel *  _Nonnull modle1, DetailsModel*  _Nonnull modle2) {
//                            NSInteger result = [modle1.time compare: modle2.time];
//                            return result == NSOrderedDescending; // 升序
//                        }];
//
//
//
//
//
////                        [weakSelf.dataArray removeAllObjects];
////                        weakSelf.dataArray= [NSMutableArray arrayWithArray:soertArray];
////                        [weakSelf.dataArray addObject:soertArray.firstObject];
//                        if (soertArray.firstObject) {
//                            [weakSelf.fristDic setObject:soertArray.firstObject forKey:[NSString stringWithFormat:@"%d",i]];
//                        }
//
////
//
//
//
//
////                        if (weakSelf.secondDic.allKeys.count == 3) {
////                            for (NSString *key1 in weakSelf.secondDic.allKeys) {
////                                NSInteger index1 = [key1 intValue];
////                                DetailsModel *detal1 = weakSelf.secondDic[key1];
////
////
////                                switch (index1) {
////                                    case 0:
////                                        [weakSelf.secondArray replaceObjectAtIndex:1 withObject:detal1];
////                                        break;
////                                    case 1:
////                                        [weakSelf.secondArray replaceObjectAtIndex:0 withObject:detal1];
////                                        break;
////                                    case 2:
////                                        [weakSelf.secondArray replaceObjectAtIndex:2 withObject:detal1];
////                                        break;
////
////                                    default:
////                                        break;
////                                }
////                            }
////                        }
//////
//
//
//
//                        if (weakSelf.fristDic.allKeys.count == 3) {
//                            for (NSString * key in weakSelf.fristDic.allKeys) {
//                                NSInteger  index = [key intValue];
//                                DetailsModel * detal =  weakSelf.fristDic[key];
////                                NSLog(@"detail Model --%@",detal.title);
////                                [weakSelf.dataArray replaceObjectAtIndex:index withObject:weakSelf.fristDic[key]];
//                                switch (index) {
//                                    case 0:
//                                    {
//                                        [weakSelf.dataArray replaceObjectAtIndex:1 withObject:detal];
//                                    }
//                                        break;
//                                    case 1:
//                                    {
//                                        [weakSelf.dataArray replaceObjectAtIndex:0 withObject:detal];
//                                    }
//                                        break;
//                                    case 2:
//                                    {
//                                        [weakSelf.dataArray replaceObjectAtIndex:2 withObject:detal];
//                                    }
//                                        break;
//
//                                    default:
//                                        break;
//                                }
//                            }
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                NSLog(@"refresh table view index:%d",room);
//                                [weakSelf.referralTableView reloadData];
//                                [self.loadingView cancelView];
//
//                            });
//                        }
//                    }
//
//
//
//                } error:^(NSError *error) {
//
//                }];
//
//
//            }
//
            
            
        } error:^(NSError *error) {
            [self.fristDic setObject:error.localizedDescription forKey:[NSString stringWithFormat:@"%d",i]];
            
           
        }];
    }
    
}











//初始化tableview
-(UITableView *)referralTableView{
    
    if (!_referralTableView) {
        
        _referralTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_GAP, kScreenW, kScreenH- TOOLBAR_HEIGHT) style:UITableViewStyleGrouped];
        _referralTableView.delegate = self;
        _referralTableView.dataSource =self;
    
           _referralTableView.estimatedRowHeight = 180;
        
        [ _referralTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        _referralTableView.backgroundColor = UIColorFromHexValue(0xf4f6fd);
        
    }
    
    
    return _referralTableView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailsModel * model = _dataArray[indexPath.row];
//    NSLog(@"height ---%f----%d",model.hight,indexPath.row);
    return model.hight;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DetailsTableViewCell *cell = [DetailsTableViewCell cellWithTableView:tableView];
    
    cell.model = _dataArray[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PredictViewController *vc = [[PredictViewController alloc]init];
        vc.preModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


#pragma mark ----  TabViewdelegate代理
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    
    return 290*kHeightScale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}






-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc]init];
////    NSLog(@"走了几次");
    
//   XLCycleCollectionView *cyleView = [[XLCycleCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 162*kHeightScale)];
//    cyleView.delegate = self;
//    if (self.secondArray.count<1) {
//        cyleView.HeadModelArry = self.dataArray;
//    }
//    else{
//       cyleView.HeadModelArry = self.secondArray;
//    }
//      [headView addSubview:cyleView];
    
    UIView * backcellView = [[UIView alloc]init];
    backcellView.frame =CGRectMake(0, 0, self.view.bounds.size.width, 162*kHeightScale);
    
    [headView addSubview:backcellView];
    
    if (self.secondArray.count>0) {
        XLCycleCollectionView *cyleView = [[XLCycleCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, backcellView.height)];
        cyleView.delegate = self;
        cyleView.HeadModelArry = self.secondArray;
        [backcellView addSubview:cyleView];
    }else{
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = backcellView.frame;
        imageView.image  = [UIImage imageNamed:@"Home_banner2"];
        [backcellView addSubview:imageView];
        
    }
    
    

    UIView *whiteView = [[UIView alloc]init];

    whiteView.frame = CGRectMake(0, backcellView.bottom, kScreenW, 88*kHeightScale);

    whiteView.backgroundColor = [UIColor whiteColor];

    self.whiteView = whiteView;

    [headView addSubview:whiteView];

    //多语言
//    "New_Predictions" ="最新预测";
//    "Hot_Predictions" ="热门预测";
//    "Crypto_Topics" ="币圈专题";
//    "HOT_Topics" ="热点事件";
//    "Sport_Events" = "体育赛事";
    NSString *New_PredictionsStr= NSLocalizedStringFromTable(@"New_Predictions",@"Internation", nil);
    NSString *Hot_PredictionsStr= NSLocalizedStringFromTable(@"Hot_Predictions",@"Internation", nil);
    NSString *Crypto_TopicsStr= NSLocalizedStringFromTable(@"Crypto_Topics",@"Internation", nil);
    NSString *HOT_TopicsStr=NSLocalizedStringFromTable(@"HOT_Topics",@"Internation", nil);
    NSString *Sport_EventsStr=NSLocalizedStringFromTable(@"Sport_Events",@"Internation", nil);

    NSArray *arr = @[New_PredictionsStr,Hot_PredictionsStr,Crypto_TopicsStr,HOT_TopicsStr,Sport_EventsStr];
    NSArray *imgArr = @[@"Home_news",@"Home_hot",@"Home_project",@"Home_hot_action",@"Home_sports"];
    CGFloat btnW = kScreenWidth / arr.count;
    for (int i = 0; i < arr.count; i ++) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(5+i*btnW, 0, 85, (92+30+24)/2);
//        button.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        [button setTitleColor:UIColorFromHexValue(0x333333)   forState:UIControlStateNormal];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.titleLabel.numberOfLines = 0;
        [button setImage:[UIImage imageNamed:imgArr[i]]forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Light" size:12];
        [button addTarget:self action:@selector(functionClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+2000;
        //            //注意就是这个方法,把我们的普通按钮转成我们需要的按钮
        [self initButton:button];
        [whiteView addSubview:button];
    }

    UIView *lineview = [[UIView alloc] init];
    lineview.backgroundColor = [UIColor colorWithRed:42/255.0 green:125/255.0 blue:223/255.0 alpha:1.0];
    lineview.layer.cornerRadius = 1.7;
    [headView addSubview:lineview];

    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(whiteView.mas_bottom).offset(20);
        make.left.mas_equalTo(13*kWidthScale);
//        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(3*kWidthScale, 13*kHeightScale));

    }];

    UILabel * rlabel = [[UILabel alloc]init];
    rlabel.numberOfLines = 0;
    rlabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 12.7];
    rlabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    rlabel.text = NSLocalizedStringFromTable(@"Recommended_Predictions",@"Internation", nil);
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


//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
//{
//    NSLog(@"---点击了第%ld张图片", (long)index);
//}






-(void)initButton:(UIButton*)btn{
    //使图片和文字水平居中显示
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height +25,-btn.imageView.frame.size.width, 0.0,20)];
    
    //图片距离右边框距离减少图片的宽度，其它不边
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-10, 6,0.0, -btn.titleLabel.bounds.size.width)];
}


-(void)functionClick:(UIButton*)sender{
    
    NSLog(@"这个按钮点击是多少%ld",(long)sender.tag);
    switch (sender.tag) {
        case 2000:
            
           [self.navigationController pushViewController:[[NewestViewController alloc]init] animated:YES];
            break;
        case 2001:
            
            
             [self.navigationController pushViewController:[[HotViewController alloc]init] animated:YES];
            break;
        case 2002:
           
            [self.navigationController pushViewController: [[CurrencyViewController alloc]init] animated:YES];
            
            break;
        case 2003:
            
             [self.navigationController pushViewController: [[HotIssueViewController alloc]init] animated:YES];
            
            break;
        case 2004:
            
            [self.navigationController pushViewController: [[SportsViewController alloc]init] animated:YES];
            break;
            
        default:
            break;
    }
    
    
}



-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:28800]];
   [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss z"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
//
//    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
//    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//    [formatter1 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss z"];
////    NSDate *datenow = [NSDate date];
//    NSDate *dateEN = [[NSDate alloc] init];
//    NSString *currentTimeString1 = [formatter1 stringFromDate:dateEN];
//    NSLog(@"currentTimeString =  %@",currentTimeString1);
    
    
    
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //现在时间,你可以输出来看下是什么格式
    
  
//    NSDate *date = [[NSDate alloc] init];
//    //----------将nsdate按formatter格式转成nsstring
////    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:0];
////     long seStr = [date timeIntervalSince1970];
//    NSString *currentTimeString1 = [formatter stringFromDate:date];
   
//    NSString * currentTimeString1
//    NSLog(@"currentTimeString1 =  %@",currentTimeString1);
    
//     NSString * tempTime = [currentTimeString stringByReplacingOccurrencesOfString:@"GMT+8" withString:@" "];
  
    return currentTimeString;
    
}




-(NSString*)getCurrentTimes1{
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//
//    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:28800]];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss z"];
//    NSDate *datenow = [NSDate date];
//    NSString *currentTimeString = [formatter stringFromDate:datenow];
//    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter1 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss z"];
    //    NSDate *datenow = [NSDate date];
    NSDate *dateEN = [[NSDate alloc] init];
    NSString *currentTimeString1 = [formatter1 stringFromDate:dateEN];
    NSLog(@"currentTimeString =  %@",currentTimeString1);
    
    
    
    //    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //现在时间,你可以输出来看下是什么格式
    
    
    //    NSDate *date = [[NSDate alloc] init];
    //    //----------将nsdate按formatter格式转成nsstring
    ////    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:0];
    ////     long seStr = [date timeIntervalSince1970];
    //    NSString *currentTimeString1 = [formatter stringFromDate:date];
    
    //    NSString * currentTimeString1
    //    NSLog(@"currentTimeString1 =  %@",currentTimeString1);
    
    //     NSString * tempTime = [currentTimeString stringByReplacingOccurrencesOfString:@"GMT+8" withString:@" "];
    
    return currentTimeString1;
    
}



-(void)selectedIndex:(NSInteger)index{
    
    PredictViewController *vc = [[PredictViewController alloc]init];
    
    NSLog(@"这个数是多少%ld",index);
    if (index== 4||index==0) {
        return;
    }
    if (self.secondArray.count ==1) {
        vc.preModel =self.secondArray[0];
    }
    vc.preModel = self.secondArray[index-1];
    
    //    DetailsModel * detailModel = self.dataArray[indexPath.row];
    //    PredictHeaderModel * model = [PredictHeaderModel new];
    //    model.title = detailModel.title;
    //    model.time = detailModel.time;
    //    model.choseButcount = detailModel.choseButcount;
    //    mod
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void)registerPushlog{

    LoginViewController *creatVC = [[LoginViewController alloc]init];
    
    [self.navigationController pushViewController:creatVC animated:YES];
    
}


//下拉刷新方法

- (void)headerRefresh{
    _isNeedRefesh = YES;
    [self clicked];
}


//结束下拉刷新

#pragma mark - 结束下拉刷新和上拉加载
- (void)endRefresh{
    //当请求数据成功或失败后，如果你导入的MJRefresh库是最新的库，就用下面的方法结束下拉刷新和上拉加载事件
    [self.referralTableView.mj_header endRefreshing];
}


@end
