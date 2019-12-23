//
//  HotViewController.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/3.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "HotViewController.h"
#import "BitsharesWalletObject.h"
#import "DetailsModel.h"
#import "DetailsTableViewCell.h"
#import "PredictViewController.h"
#import "WuLoadingView.h"
#import "NumberLabel.h"
@interface HotViewController ()<UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic,strong) BitsharesWalletObject *wallet;

@property (nonatomic,assign) BOOL connected;

@property(nonatomic,strong)UITableView * hotTableView;

//存数据
@property(nonatomic,strong)NSMutableArray * mrDataArry;

//存room的数组
@property(nonatomic,strong)NSMutableArray *mybArry;

@property(nonatomic,strong)NSMutableArray *wodearry;

// 存模型的id
@property(nonatomic,strong)NSMutableArray *moxinarry;

// 存第一个的数组
@property(nonatomic,strong)NSMutableArray *fristArry;

@property(nonatomic,strong)WuLoadingView *loadingView;

@property(nonatomic,strong) NumberLabel *dataLabel;



@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupUI];
    [self setTopView];
    [self.view addSubview:self.hotTableView];
    
    //添加没数据
    self.dataLabel = [[NumberLabel alloc]initWithFrame:CGRectMake(kScreenW/2, kScreenH/2, 70, 30)];
    self.dataLabel.centerX = self.view.centerX;
    [self.view addSubview:self.dataLabel];
    
    self.dataLabel.hidden = YES;
    
    [self clickfunk];
}


-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    self.navigationController.navigationBarHidden = YES;
    self.navView.title = NSLocalizedStringFromTable(@"Hot_Predictions",@"Internation", nil);
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
}


-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}


//-(void)setupUI{
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
//        [self clickfunk];
//    });
//
//
//}
//
//
//
//
//
//
//
//
//- (void)needConnect {
//
//    [_wallet connectUrl:@"ws://39.105.189.224/ws" timeOut:2 connectedError:^(NSError *error) {
//        NSLog(@"%@",error.description);
//
//        [self needConnect];
//    }];
//}


-(void)clickfunk{
    dispatch_async(dispatch_get_main_queue(), ^{
        WuLoadingView *loadingView = [[WuLoadingView alloc]init];
        self.loadingView = loadingView;
        [loadingView showLoadingView];
    });
    self.wodearry = [NSMutableArray arrayWithCapacity:100];
    NSString *oneStr = NSLocalizedStringFromTable(@"Sports",@"Internation", nil);
    NSString *twoStr =NSLocalizedStringFromTable(@"bibiquan",@"Internation", nil);
    NSString *thirsStr = NSLocalizedStringFromTable(@"hot top",@"Internation", nil);
    for (int i = 0; i<3; i++) {
        [[BitsharesWalletObject BitsharesWalletObjectManager] getPlatform:@"get_houses" unploadParamsTotalParams:@[oneStr,twoStr,thirsStr] paltNum:i success:^(PlatAccount *result) {
            [self getRoomsInfo:result.rooms platformIndex:i];
        } error:^(NSError *error) {
            
        }];
    }
}


- (void)getRoomsInfo:(NSArray*)rooms platformIndex:(int)index{
     __block int finisCount = 0;
    if (rooms.count<1) {
        [self.loadingView cancelView];
        return;
    }
    for (int room = 0; room<rooms.count; room++) {
        [[BitsharesWalletObject BitsharesWalletObjectManager] getSeerRoom:@"get_seer_room"  fristString:rooms[room] nLimint:0 secondInt:100 success:^(RoomAccount *result2) {
              finisCount++;
            //                result2.identifier
            //                    for (DetailsModel * modle  in weakSelf.wodearry) {
            //                        if ([modle.roomId isEqualToString:result2.identifier]) {
            if (rooms[room]) {
                DetailsModel *modle = [[DetailsModel alloc]init];
                modle.time = result2.option.stop;
                modle.time1 = result2.option.stop;
                NSComparisonResult result8 = [[self getCurrentTimes] compare:modle.time];
                if (result8 ==NSOrderedAscending ) {
                    modle.title = result2.description_des;
                    
                    modle.roomId = result2.identifier;
                    modle.totalmoneyaCount = result2.running_option.total_shares/100000;
                    modle.totalpeople = result2.running_option.total_player_count;
                    modle.percent = result2.option.result_owner_percent/100;
                    //币种
                    modle.accept_asset = result2.option.accept_asset;
                    modle.ass_id =result2.option.accept_asset;
                    modle.choseButcount = result2.running_option.selection_description;
                    if ([modle.accept_asset isEqualToString:@"SEER"]||[modle.accept_asset isEqualToString:@"PFC"])  {
                        modle.totalmoneyaCount = result2.running_option.total_shares/100000;
                        modle.minNub = result2.option.minimum/100000;
                        modle.maxNub = result2.option.maximum/100000;
                    }else if ([modle.accept_asset isEqualToString:@"USDT"]){
                        modle.totalmoneyaCount = result2.running_option.total_shares/100;
                        modle.minNub = result2.option.minimum/100;
                        modle.maxNub = result2.option.maximum/100;
                    }
//                    if ([result2.option.accept_asset isEqualToString:@"1.3.5"]) {
//                        modle.minNub = result2.option.minimum /100;
//                        modle.maxNub = result2.option.maximum/100;
//                    }else{
//                        modle.minNub = result2.option.minimum;
//                        modle.maxNub = result2.option.maximum;
//                    }
                    modle.total_shares = result2.running_option.total_shares;
                    modle.proportion =[result2.running_option.pvp_running valueForKey:@"total_participate"];
                    modle.room_type =result2.room_type;
                    modle.hight = 0;
                    //固定金额
                    modle.pool = result2.running_option.advanced.pool;
                    modle.awards = result2.running_option.advanced.awards;
                    //固定赔付金额和投注金额
                    modle.total_participate = result2.running_option.advanced_running.total_participate;
                    
                    //份数选项
                    modle.items_countNum = result2.running_option.lmsr_running.items_countNum;
                    //那个L
                    modle.lmsr_number = result2.running_option.lmsr.lmsr_number;
                    [self.wodearry addObject:modle];
                    
                }
                NSArray * soertArray = [self.wodearry sortedArrayUsingComparator:^NSInteger(DetailsModel *  _Nonnull modle1, DetailsModel*  _Nonnull modle2) {
                    NSInteger result = modle1.totalmoneyaCount < modle2.totalmoneyaCount;
                    return result == NSOrderedDescending; // 升序
                }];
                
               [self.wodearry removeAllObjects];
               self.wodearry= [NSMutableArray arrayWithArray:soertArray];
            }
            
            if (finisCount == rooms.count &&index== 2) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.hotTableView reloadData];
                    [self.loadingView cancelView];
                     NSLog(@"hotTableView走多少次 是不是一次");
                });
               
            }
    
        } error:^(NSError *error) {
            if (finisCount== rooms.count &&index== 2) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.hotTableView reloadData];
//                     NSLog(@"走多少次 是不是一次");
                    [self.loadingView cancelView];
                });
            }
            
        }];
        
        
        
        
    }
}

//-(void)clicked{
//
//    self.mybArry = [NSMutableArray array];
//    self.mrDataArry = [NSMutableArray array];
//    self.wodearry = [NSMutableArray array];
//    self.moxinarry = [NSMutableArray array];
//    self.fristArry = [NSMutableArray arrayWithCapacity:3];
//    NSString *oneStr = NSLocalizedStringFromTable(@"Sports",@"Internation", nil);
//    NSString *twoStr =NSLocalizedStringFromTable(@"bibiquan",@"Internation", nil);
//    NSString *thirsStr = NSLocalizedStringFromTable(@"hot top",@"Internation", nil);
//    for (int i = 0; i<3; i++) {
//        [self.wallet getPlatform:@"get_houses" unploadParamsTotalParams:@[oneStr,twoStr,thirsStr] paltNum:i success:^(PlatAccount *result) {
//            __weak typeof(self) weakSelf = self;
//            for (int room = 0; room < result.rooms.count; room++)
//            {
//                [weakSelf.wallet getSeerRoom:@"get_seer_room"  fristString:result.rooms[room] nLimint:0 secondInt:100 success:^(RoomAccount *result2) {
//                    //                result2.identifier
////                    for (DetailsModel * modle  in weakSelf.wodearry) {
////                        if ([modle.roomId isEqualToString:result2.identifier]) {
//                    if (result.rooms[room]) {
//                        DetailsModel *modle = [[DetailsModel alloc]init];
//                        modle.time = result2.option.stop;
//                        modle.time1 = result2.option.stop;
//                        NSComparisonResult result8 = [[self getCurrentTimes] compare:modle.time];
//                        if (result8 ==NSOrderedAscending ) {
//                            modle.title = result2.description_des;
//                            modle.roomId = result2.identifier;
//                            modle.totalmoneyaCount = result2.running_option.total_shares/100000;
//                            modle.totalpeople = result2.running_option.total_player_count;
//                            modle.percent = result2.option.result_owner_percent/100;
//                            modle.choseButcount = result2.running_option.selection_description;
//                            modle.minNub = result2.option.minimum /100000;
//
//                            modle.maxNub = result2.option.maximum/100000;
//                            modle.total_shares = result2.running_option.total_shares;
//                            modle.proportion =[result2.running_option.pvp_running valueForKey:@"total_participate"];
//                            modle.room_type =result2.room_type;
//                            modle.hight = 0;
//                            //固定金额
//                            modle.pool = result2.running_option.advanced.pool;
//                            modle.awards = result2.running_option.advanced.awards;
//                            //固定赔付金额和投注金额
//                            modle.total_participate = result2.running_option.advanced_running.total_participate;
//
//                            //份数选项
//                            modle.items_countNum = result2.running_option.lmsr_running.items_countNum;
//                            //那个L
//                            modle.lmsr_number = result2.running_option.lmsr.lmsr_number;
//                            [self.wodearry addObject:modle];
//
//                        }
//                        NSArray * soertArray = [weakSelf.wodearry sortedArrayUsingComparator:^NSInteger(DetailsModel *  _Nonnull modle1, DetailsModel*  _Nonnull modle2) {
//                            NSInteger result = modle1.totalmoneyaCount < modle2.totalmoneyaCount;
//                            return result == NSOrderedDescending; // 升序
//                        }];
//
//                        [weakSelf.wodearry removeAllObjects];
//                        weakSelf.wodearry= [NSMutableArray arrayWithArray:soertArray];
//                    }
//
////                        }
////                    }
//
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [weakSelf.hotTableView reloadData];
//                    });
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
//
//
//        } error:^(NSError *error) {
//
//        }];
//    }
//
//}


-(UITableView *)hotTableView{
    
    if (!_hotTableView) {
        self.hotTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navView.bottom, kScreenW, kScreenH- self.navView.height) style:UITableViewStyleGrouped];
        
        self.hotTableView.delegate = self;
        self.hotTableView.dataSource =self;
        
//        self.hotTableView.estimatedRowHeight = 180;
        
        [ self.hotTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
       self.hotTableView.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    }
    
    return _hotTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.wodearry.count == 0) {
        self.dataLabel.hidden =NO;
    }else{
        self.dataLabel.hidden =YES;
    }
    
    return self.wodearry.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DetailsTableViewCell *cell = [DetailsTableViewCell cellWithTableView:tableView];
    
    cell.model = _wodearry[indexPath.row];
    
    return cell;
    
    
 
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PredictViewController *vc = [[PredictViewController alloc]init];
    vc.preModel = self.wodearry[indexPath.row];
    
    //    DetailsModel * detailModel = self.dataArray[indexPath.row];
    //    PredictHeaderModel * model = [PredictHeaderModel new];
    //    model.title = detailModel.title;
    //    model.time = detailModel.time;
    //    model.choseButcount = detailModel.choseButcount;
    //    mod
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
    
}

#pragma mark ----  TabViewdelegate代理

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailsModel * model = _wodearry[indexPath.row];
    //    NSLog(@"height ---%f----%d",model.hight,indexPath.row);
    return model.hight;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    
    return 15*kHeightScale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 15*kHeightScale;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    
//    
//    return UIView.new;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//
//    return UIView.new;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}


-(void)dealloc{
    
    
}


@end
