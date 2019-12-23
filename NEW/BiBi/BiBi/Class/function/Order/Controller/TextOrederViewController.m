//
//  TextOrederViewController.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/7.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "TextOrederViewController.h"
#import "BitsharesWalletObject.h"
#import "OrederTableViewCell.h"
#import "OrderHeaderView.h"
#import "OrderFirstTableViewCell.h"
#import "OrderHeaderFootView.h"
#import "OrderModel.h"
#import "OrederTwoTabelViewCell.h"
#import "PredictViewController.h"
#import "CPTopAnimationView.h"
#import "WuLoadingView.h"
#import "UITableView+Placeholder.h"
#import "PlaceholderView.h"

#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define StrongSelf(strongSelf) __strong __typeof(self)strongSelf = weakSelf;
@interface TextOrederViewController ()<UITableViewDelegate,UITableViewDataSource>

//tableView
@property(nonatomic,strong)UITableView *orederTabelView;
//数据问题
@property(nonatomic,strong)NSMutableArray *orederArry;

//@property (nonatomic,strong) BitsharesWalletObject *wallet;

@property(nonatomic,strong)NSMutableArray *roomArry;

@property(nonatomic,strong) NSArray *parArray;

@property (nonatomic,assign) BOOL connected;

@property(nonatomic,strong)NSMutableArray *myArry;

@property(nonatomic,strong)NSMutableArray *weiArry;

@property(nonatomic,strong)NSMutableArray *sendenArry;

//总金额
@property(nonatomic,assign)NSInteger allRmb;

//胜场
@property(nonatomic,assign)NSInteger seccendNub;

@property(nonatomic,assign)NSInteger gongNuber;

//
@property(nonatomic,strong)UIView *viewVC;


//头

@property(nonatomic,strong)CPTopAnimationView *headerView;

@property(nonatomic,assign)NSInteger flag;

//loading
@property(nonatomic,strong)WuLoadingView *loadingView;

@property(nonatomic,strong)UIImageView *iamgeViewIcon;

@property(nonatomic,strong)UIView *imageViewColor;

@end

@implementation TextOrederViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    self.myArry =[NSMutableArray array];
//    self.weiArry=[NSMutableArray array];
   
    self.flag = 1;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // 阻塞当前方法，使方法进入等待
//        while (!self.connected) {}
//        // 当连接成功后发送消息
//
////        [self logningfunck];
////        [self clicked];
////        [self clickfinsed];
//        [self clickedfunk];
////        [self clickfinsed];
//        [self clickfinsedFunk];
//
//    });
     [self clickedfunk];
    [self clickfinsedFunk];
    [self setHideenImageColor];
}


-(void)setHideenImageColor{
    self.imageViewColor = [[UIView alloc]init];
    self.imageViewColor.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.imageViewColor];
    [self.imageViewColor mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_iPhoneX) {
            make.top.mas_equalTo(352);
        }else{
            make.top.mas_equalTo(328);
        }
        
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(300);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = UIColorFromHexValue(0xe0e0e0);
    [self.imageViewColor addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(2);
        make.height.mas_equalTo(0.8);
        make.right.mas_equalTo(0);
    }];
    UIImageView *imageView = [[UIImageView alloc]init];
    self.iamgeViewIcon = imageView;
    
    imageView.image = [UIImage imageNamed:NSLocalizedStringFromTable(@"DateIcon",@"Internation", nil)];
    [self.imageViewColor addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.size.mas_equalTo(CGSizeMake(200, 191));
        make.centerX.mas_equalTo(0);
    }];
    
    self.imageViewColor.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
//    [self setupURL];
    [self setTopView];
    [self.view addSubview:self.orederTabelView];
    
    [self.orederTabelView reloadData];
    _flag = 1;
    
   
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
      self.imageViewColor.hidden = YES;
}

-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    
    self.navigationController.navigationBarHidden = YES;
    
    self.navView.title = NSLocalizedStringFromTable(@"order",@"Internation", nil);

}

-(void)setupUI{
    
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
//        if (status == WebsocketConnectStatusClosed) {
//            [weakSelf needConnect];
//
//        }
//    };
//
//}
//
//
//- (void)needConnect {
//    [_wallet connectUrl:@"ws://39.105.189.224/ws" timeOut:10 connectedError:^(NSError *error) {
//        [self needConnect];
//    }];
//}


//查询id
-(void)logningfunck{
    [[BitsharesWalletObject BitsharesWalletObjectManager] getAccount:M_userName success:^(AccountObject *result) {
        [MoneyPacketManager moneyAcctountManager].identifier = [NSString stringWithFormat:@"%@",result.identifier];
    } error:^(NSError *error) {
        NSLog(@"ffffff");
        
    }];
}


-(void)clickfinsedFunk{
  
    dispatch_async(dispatch_get_main_queue(), ^{
        WuLoadingView *loadingView = [[WuLoadingView alloc]init];
        self.loadingView = loadingView;
        [loadingView showLoadingView];
    });
    
    self.seccendNub = 0;
    self.allRmb = 0;
    NSString *oneStr = NSLocalizedStringFromTable(@"Sports",@"Internation", nil);
    NSString *twoStr =NSLocalizedStringFromTable(@"bibiquan",@"Internation", nil);
    NSString *thirsStr = NSLocalizedStringFromTable(@"hot top",@"Internation", nil);
    self.weiArry = [NSMutableArray arrayWithCapacity:200];
    for (int i = 0; i<3; i++) {
        [[BitsharesWalletObject BitsharesWalletObjectManager] getPlatform:@"get_houses" unploadParamsTotalParams:@[oneStr,twoStr,thirsStr] paltNum:i success:^(PlatAccount *result) {
            
            [self getFinsedRoomsInfo:result.finished_rooms platformIndex:i];
            
            NSLog(@"这个平台的数量是多少%ld",result.finished_rooms.count);
        } error:^(NSError *error) {
//             [self getFinsedRoomsInfo:result.finished_rooms platformIndex:i];
        }];
    }
}

//records
- (void)getFinsedRoomsInfo:(NSArray*)rooms platformIndex:(int)index{
    __block int finCount = 0;
    for (int j = 0; j<rooms.count; j++) {
        NSLog(@"%d我擦jjjjjjj",j);
        [[BitsharesWalletObject BitsharesWalletObjectManager] getSeerRoom:@"get_seer_room" fristString:rooms[j] nLimint:0 secondInt:100 success:^(RoomAccount *roomresult) {
            finCount++;
            for (int g = 0; g<roomresult.running_option.participators.count; g++) {
                
                if (roomresult.running_option.participators[g]) {
                    NSArray *parArray = roomresult.running_option.participators[g];
                    if (parArray.count>0) {
                        for (int h = 0; h<parArray.count; h++) {
                            Participators *partin =  [Participators mj_objectWithKeyValues:parArray[h]];
                            if ([partin.player isEqualToString:[MoneyPacketManager moneyAcctountManager].identifier]) {
                                
                                OrderModel *orderM = [[OrderModel alloc]init];
                                orderM.contentStr = roomresult.description_des;
                                orderM.timeOutStr = partin.when;
                                orderM.timeOutStrEN = partin.when;
                                NSLog(@"^^^^^^^^标题是多少%@^^^^^^^^^^",orderM.chooseStr);
                                NSLog(@"^^^^^^^^时间是多少%@^^^^^^^^^^",orderM.timeOutStr);
                                orderM.chooseStr = roomresult.running_option.selection_description[g];
                                orderM.choosenumber = g;
                                orderM.amount = partin.amount;
                                orderM.paid = partin.paid;
                                orderM.totalmoneyaCount = roomresult.running_option.total_shares/100000;
                                orderM.totalpeople = roomresult.running_option.total_player_count;
                                orderM.percent = roomresult.option.result_owner_percent/100;
                                orderM.choseButcount = roomresult.running_option.selection_description;
                                orderM.minNub = roomresult.option.minimum /100000;
                                orderM.maxNub = roomresult.option.maximum/100000;
                                orderM.total_shares = roomresult.running_option.total_shares;
                                orderM.proportion =[roomresult.running_option.pvp_running valueForKey:@"total_participate"];
                                orderM.room_type = roomresult.room_type;
                                orderM.pool = roomresult.running_option.advanced.pool;
                                orderM.awards = roomresult.running_option.advanced.awards;
                                //固定赔付金额和投注金额
                                orderM.total_participate = roomresult.running_option.advanced_running.total_participate;
                                //份数选项
                                orderM.items_countNum = roomresult.running_option.lmsr_running.items_countNum;
                                //那个L
                                orderM.lmsr_number = roomresult.running_option.lmsr.lmsr_number;
                                
                                if (partin.reward) {
                                    orderM.reward = partin.reward;
                                    self.seccendNub ++;
                                    self.allRmb += orderM.reward;
                                }
                                
                                //                                        orderM.hight = 0;
                                orderM.timeStop = roomresult.option.stop;
                                orderM.timeStopEN = roomresult.option.stop;
                                if (roomresult.final_result != nil && ![roomresult.final_result isKindOfClass:[NSNull class]] && roomresult.final_result.count != 0){
                                    
                                    orderM.winnerLabel = [NSString stringWithFormat:@"%@",roomresult.final_result.firstObject];
                                    
                                }
                                
                                [self.weiArry addObject:orderM];
                                NSLog(@"这个总共是多少个数%ld",self.weiArry.count);
                                
                                
                            }
//                            NSArray * soertArray = [self.weiArry sortedArrayUsingComparator:^NSComparisonResult(OrderModel *  _Nonnull modle1, OrderModel*  _Nonnull modle2) {
//                                NSComparisonResult result2 = [modle1.timeOutStr compare:modle2.timeOutStr];
//                                return result2 == NSOrderedAscending; // 升序
//                            }];
//                            [self.weiArry removeAllObjects];
//                            self.weiArry = [NSMutableArray arrayWithArray:soertArray];
                        }
                    }
                    
                    
                }
                
            }
            
                        if (finCount ==rooms.count) {
                        [self refreshCurrentViewWith:self.weiArry andPlatForm:index andOrderCount:index];
                    }
            
            
            
        } error:^(NSError *error) {
            
        }];
        
    }
    

}


- (void)refreshCurrentViewWith:(NSMutableArray*)tempArray andPlatForm:(int)index andOrderCount:(int)orderCount {
    NSArray * soertArray = [tempArray sortedArrayUsingComparator:^NSInteger(OrderModel *  _Nonnull modle1, OrderModel*  _Nonnull modle2) {
        NSInteger result = [modle1.timeOutStr compare: modle2.timeOutStr];
        return result == NSOrderedAscending; // 升序
    }];
    self.weiArry = [NSMutableArray arrayWithArray:soertArray];
    
    NSLog(@"这个tempArray%ld",soertArray.count);
    
    if (index==2) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //                        //刷新完成
            //                        self.viewVC.hidden = YES;
            [self.orederTabelView reloadData];
            
            self.gongNuber = self.seccendNub;
            [self.loadingView cancelView];
            NSLog(@"这个房间的数量是多少%ld",self.weiArry.count);
        });
        
    }
    
    
}




-(void)clickfinsed{
     __block int finCount = 0;
//    int indexfinsed = 0;
    dispatch_async(dispatch_get_main_queue(), ^{
        WuLoadingView *loadingView = [[WuLoadingView alloc]init];
        self.loadingView = loadingView;
        [loadingView showLoadingView];
        });
    self.seccendNub = 0;
    self.allRmb = 0;
    NSString *oneStr = NSLocalizedStringFromTable(@"Sports",@"Internation", nil);
    NSString *twoStr =NSLocalizedStringFromTable(@"bibiquan",@"Internation", nil);
    NSString *thirsStr = NSLocalizedStringFromTable(@"hot top",@"Internation", nil);
    self.weiArry = [NSMutableArray arrayWithCapacity:200];
    for (int i = 0; i<3; i++) {
        [[BitsharesWalletObject BitsharesWalletObjectManager] getPlatform:@"get_houses" unploadParamsTotalParams:@[oneStr,twoStr,thirsStr] paltNum:i success:^(PlatAccount *result) {
            finCount++;
            NSLog(@"%@",result.finished_rooms);
            
            for (NSString *str in result.finished_rooms) {
                [self.roomArry addObject:str];
            }
            for (int j = 0; j<result.finished_rooms.count; j++) {
                NSLog(@"%d我擦jjjjjjj",j);
                [[BitsharesWalletObject BitsharesWalletObjectManager] getSeerRoom:@"get_seer_room" fristString:result.finished_rooms[j] nLimint:0 secondInt:100 success:^(RoomAccount *roomresult) {

                    for (int g = 0; g<roomresult.running_option.participators.count; g++) {

                        if (roomresult.running_option.participators[g]) {
                            NSArray *parArray = roomresult.running_option.participators[g];
                            if (parArray.count>0) {
                                for (int h = 0; h<parArray.count; h++) {
                                    Participators *partin =  [Participators mj_objectWithKeyValues:parArray[h]];
                                    if ([partin.player isEqualToString:[MoneyPacketManager moneyAcctountManager].identifier]) {

                                        OrderModel *orderM = [[OrderModel alloc]init];
                                        orderM.contentStr = roomresult.description_des;
                                        orderM.timeOutStr = partin.when;
                                        orderM.timeOutStrEN = partin.when;
                                        NSLog(@"^^^^^^^^标题是多少%@^^^^^^^^^^",orderM.chooseStr);
                                        NSLog(@"^^^^^^^^时间是多少%@^^^^^^^^^^",orderM.timeOutStr);
                                        orderM.chooseStr = roomresult.running_option.selection_description[g];
                                        orderM.choosenumber = g;
                                        orderM.amount = partin.amount;
                                        orderM.paid = partin.paid;
                                        orderM.totalmoneyaCount = roomresult.running_option.total_shares/100000;
                                        orderM.totalpeople = roomresult.running_option.total_player_count;
                                        orderM.percent = roomresult.option.result_owner_percent/100;
                                        orderM.accept_asset =roomresult.option.accept_asset;
                                        orderM.choseButcount = roomresult.running_option.selection_description;
                                        orderM.minNub = roomresult.option.minimum /100000;
                                        orderM.maxNub = roomresult.option.maximum/100000;
                                        orderM.total_shares = roomresult.running_option.total_shares;
                                        orderM.proportion =[roomresult.running_option.pvp_running valueForKey:@"total_participate"];
                                        orderM.room_type = roomresult.room_type;
                                        orderM.pool = roomresult.running_option.advanced.pool;
                                        orderM.awards = roomresult.running_option.advanced.awards;
                                        //固定赔付金额和投注金额
                                        orderM.total_participate = roomresult.running_option.advanced_running.total_participate;
                                        //份数选项
                                        orderM.items_countNum = roomresult.running_option.lmsr_running.items_countNum;
                                        //那个L
                                        orderM.lmsr_number = roomresult.running_option.lmsr.lmsr_number;

                                        if (partin.reward) {
                                             orderM.reward = partin.reward;
                                            self.seccendNub ++;
                                            self.allRmb += orderM.reward;
                                        }

//                                        orderM.hight = 0;
                                        orderM.timeStop = roomresult.option.stop;
                                        orderM.timeStopEN = roomresult.option.stop;
                                        if (roomresult.final_result != nil && ![roomresult.final_result isKindOfClass:[NSNull class]] && roomresult.final_result.count != 0){

                                            orderM.winnerLabel = [NSString stringWithFormat:@"%@",roomresult.final_result.firstObject];

                                        }

                                         [self.weiArry addObject:orderM];
                                          NSLog(@"这个总共是多少个数%ld",self.weiArry.count);
                                        

                                    }
                                    NSArray * soertArray = [self.weiArry sortedArrayUsingComparator:^NSComparisonResult(OrderModel *  _Nonnull modle1, OrderModel*  _Nonnull modle2) {
                                        NSComparisonResult result2 = [modle1.timeOutStr compare:modle2.timeOutStr];
                                        return result2 == NSOrderedAscending; // 升序
                                    }];
                                    [self.weiArry removeAllObjects];
                                    self.weiArry = [NSMutableArray arrayWithArray:soertArray];
                                }
                            }


                        }

                    }


//                    if (finCount == result.finished_rooms.count) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            //                        //刷新完成
//                            //                        self.viewVC.hidden = YES;
//                            [self.orederTabelView reloadData];
//
//                            self.gongNuber = self.seccendNub;
//                            [self.loadingView cancelView];
//                            NSLog(@"这个房间的数量是多少%ld",result.finished_rooms.count);
//                            NSLog(@"这个fincount的数量%d",finCount);
//                        });
//                         }

//
                    dispatch_async(dispatch_get_main_queue(), ^{
//                        //刷新完成
//                        self.viewVC.hidden = YES;
                        [self.orederTabelView reloadData];
                         NSLog(@"这个数量是多少%ld",self.weiArry.count);

                        self.gongNuber = self.seccendNub;

                    });


                } error:^(NSError *error) {

                }];

            }

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(17 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.loadingView cancelView];
                NSLog(@"这个数量是多少%ld",self.weiArry.count);
            });
        } error:^(NSError *error) {

        }];
    }

}








-(void)clickedfunk{
    self.myArry = [NSMutableArray arrayWithCapacity:100];
    self.sendenArry = [NSMutableArray arrayWithCapacity:100];
    NSString *oneStr = NSLocalizedStringFromTable(@"Sports",@"Internation", nil);
    NSString *twoStr =NSLocalizedStringFromTable(@"bibiquan",@"Internation", nil);
    NSString *thirsStr = NSLocalizedStringFromTable(@"hot top",@"Internation", nil);
    for (int i =0 ; i<3; i++) {
        [[BitsharesWalletObject BitsharesWalletObjectManager] getPlatform:@"get_houses" unploadParamsTotalParams:@[oneStr,twoStr,thirsStr] paltNum:i success:^(PlatAccount *result) {
            [self getRoomsInfo:result.rooms platformIndex:i];
        } error:^(NSError *error) {

        }];
    }

}

- (void)getRoomsInfo:(NSArray*)rooms platformIndex:(int)index{
//    __block int finCount = 0;
    for (int j =0; j<rooms.count; j++) {
        [[BitsharesWalletObject BitsharesWalletObjectManager] getSeerRoom:@"get_seer_room" fristString:rooms[j] nLimint:0 secondInt:100 success:^(RoomAccount *roomresult) {

            for (int g = 0; g<roomresult.running_option.participators.count; g++) {
                if (roomresult.running_option.participators[g]) {
                    NSArray *parArray = roomresult.running_option.participators[g];
                    if (parArray.count>0) {
                        for (int h = 0; h<parArray.count; h++) {
                            Participators *partin =  [Participators mj_objectWithKeyValues:parArray[h]];
                            if ([partin.player isEqualToString:[MoneyPacketManager moneyAcctountManager].identifier]) {
//                                 finCount++;
                                OrderModel *orderM = [[OrderModel alloc]init];
                                orderM.contentStr = roomresult.description_des;
                                orderM.timeOutStr = partin.when;
                                orderM.timeOutStrEN = partin.when;
                                NSLog(@"^^^^^^^^标题是多少%@^^^^^^^^^^",orderM.chooseStr);
                                NSLog(@"^^^^^^^^时间是多少%@^^^^^^^^^^",orderM.timeOutStr);
                                orderM.roomId =rooms[j];
                                orderM.chooseStr = roomresult.running_option.selection_description[g];
                                orderM.choosenumber = g;
                                orderM.amount = partin.amount;
                                orderM.paid = partin.paid;
                                orderM.totalmoneyaCount = roomresult.running_option.total_shares/100000;
                                orderM.totalpeople = roomresult.running_option.total_player_count;
                                orderM.percent = roomresult.option.result_owner_percent/100;
                                orderM.accept_asset =roomresult.option.accept_asset;
                                orderM.choseButcount = roomresult.running_option.selection_description;
                                orderM.minNub = roomresult.option.minimum /100000;
                                orderM.maxNub = roomresult.option.maximum/100000;
                                orderM.hight = 0;
                                orderM.total_shares = roomresult.running_option.total_shares;
                                orderM.proportion =[roomresult.running_option.pvp_running valueForKey:@"total_participate"];
                                orderM.timeStop = roomresult.option.stop;
                                orderM.timeStopEN = roomresult.option.stop;
                                orderM.room_type = roomresult.room_type;
                                //固定金额
                                orderM.pool = roomresult.running_option.advanced.pool;
                                orderM.awards = roomresult.running_option.advanced.awards;
                                //固定赔付金额和投注金额
                                orderM.total_participate = roomresult.running_option.advanced_running.total_participate;
                                //份数选项
                                orderM.items_countNum = roomresult.running_option.lmsr_running.items_countNum;
                                //那个L
                                orderM.lmsr_number = roomresult.running_option.lmsr.lmsr_number;
                                NSComparisonResult result8 = [[self getCurrentTimes] compare:orderM.timeStop];
                                if (result8 ==NSOrderedAscending ) {
                                    [self.myArry addObject:orderM];
                                }
                                
                                NSComparisonResult result9 = [orderM.timeStop compare:[self getCurrentTimes]];
                                if (result9 == NSOrderedAscending) {
                                    [self.sendenArry addObject:orderM];
                                }
                            }
                            
                            NSArray * soertArray = [self.myArry sortedArrayUsingComparator:^NSComparisonResult(OrderModel *  _Nonnull modle1, OrderModel*  _Nonnull modle2) {
                                NSComparisonResult result = [modle1.timeOutStr compare:modle2.timeOutStr];
                                return result == NSOrderedAscending; // 升序
                            }];
                            [self.myArry removeAllObjects];
                            self.myArry = [NSMutableArray arrayWithArray:soertArray];
                            
                            NSArray * soertArray2 = [self.sendenArry sortedArrayUsingComparator:^NSComparisonResult(OrderModel *  _Nonnull modle1, OrderModel*  _Nonnull modle2) {
                                NSComparisonResult result = [modle1.timeOutStr compare:modle2.timeOutStr];
                                return result == NSOrderedAscending; // 升序
                            }];
                            [self.sendenArry removeAllObjects];
                            self.sendenArry = [NSMutableArray arrayWithArray:soertArray2];
                            
                            
                            
                        }
                    }
                    
                    
                }
                
            }
            

            
        } error:^(NSError *error) {

        }];
    }

}





//-(void)clicked{
//    self.myArry = [NSMutableArray arrayWithCapacity:100];
//    NSString *oneStr = NSLocalizedStringFromTable(@"Sports",@"Internation", nil);
//    NSString *twoStr =NSLocalizedStringFromTable(@"bibiquan",@"Internation", nil);
//    NSString *thirsStr = NSLocalizedStringFromTable(@"hot top",@"Internation", nil);
//    for (int i = 0; i<3; i++) {
//        [self.wallet getPlatform:@"get_houses" unploadParamsTotalParams:@[oneStr,twoStr,thirsStr] paltNum:i success:^(PlatAccount *result) {
//            NSLog(@"%@",result.rooms);
////            for (NSString *str in result.rooms) {
////                [self.roomArry addObject:str];
////            }
//            for (int j = 0; j<result.rooms.count; j++) {
//                   NSLog(@"%d我擦jjjjjjj",j);
//                [self.wallet getSeerRoom:@"get_seer_room" fristString:result.rooms[j] nLimint:0 secondInt:100 success:^(RoomAccount *roomresult) {
//                        for (int g = 0; g<roomresult.running_option.participators.count; g++) {
//                            if (roomresult.running_option.participators[g]) {
//                                NSArray *parArray = roomresult.running_option.participators[g];
//                                if (parArray.count>0) {
//                                    for (int h = 0; h<parArray.count; h++) {
//                                        Participators *partin =  [Participators mj_objectWithKeyValues:parArray[h]];
//                                        if ([partin.player isEqualToString:[MoneyPacketManager moneyAcctountManager].identifier]) {
//                                            OrderModel *orderM = [[OrderModel alloc]init];
//                                            orderM.contentStr = roomresult.description_des;
//                                            orderM.timeOutStr = partin.when;
//                                            orderM.timeOutStrEN = partin.when;
//                                            NSLog(@"^^^^^^^^标题是多少%@^^^^^^^^^^",orderM.chooseStr);
//                                            NSLog(@"^^^^^^^^时间是多少%@^^^^^^^^^^",orderM.timeOutStr);
//                                            orderM.roomId =result.rooms[j];
//                                            orderM.chooseStr = roomresult.running_option.selection_description[g];
//                                            orderM.choosenumber = g;
//                                            orderM.amount = partin.amount;
//                                            orderM.paid = partin.paid;
//                                            orderM.totalmoneyaCount = roomresult.running_option.total_shares/100000;
//                                            orderM.totalpeople = roomresult.running_option.total_player_count;
//                                            orderM.percent = roomresult.option.result_owner_percent/100;
//                                            orderM.choseButcount = roomresult.running_option.selection_description;
//                                            orderM.minNub = roomresult.option.minimum /100000;
//                                            orderM.maxNub = roomresult.option.maximum/100000;
//                                            orderM.hight = 0;
//
//                                            orderM.total_shares = roomresult.running_option.total_shares;
//                                            orderM.proportion =[roomresult.running_option.pvp_running valueForKey:@"total_participate"];
//                                            orderM.timeStop = roomresult.option.stop;
//                                            orderM.timeStopEN = roomresult.option.stop;
//                                            orderM.room_type = roomresult.room_type;
//                                            //固定金额
//                                            orderM.pool = roomresult.running_option.advanced.pool;
//                                            orderM.awards = roomresult.running_option.advanced.awards;
//                                            //固定赔付金额和投注金额
//                                            orderM.total_participate = roomresult.running_option.advanced_running.total_participate;
//                                            //份数选项
//                                            orderM.items_countNum = roomresult.running_option.lmsr_running.items_countNum;
//                                            //那个L
//                                            orderM.lmsr_number = roomresult.running_option.lmsr.lmsr_number;
//                                            NSComparisonResult result8 = [[self getCurrentTimes] compare:orderM.timeStop];
//                                            if (result8 ==NSOrderedAscending ) {
//                                                 [self.myArry addObject:orderM];
//                                            }
//
//                                        }
//
//                                        NSArray * soertArray = [self.myArry sortedArrayUsingComparator:^NSComparisonResult(OrderModel *  _Nonnull modle1, OrderModel*  _Nonnull modle2) {
//                                            NSComparisonResult result = [modle1.timeOutStr compare:modle2.timeOutStr];
//                                            return result == NSOrderedAscending; // 升序
//                                        }];
//                                        [self.myArry removeAllObjects];
//                                        self.myArry = [NSMutableArray arrayWithArray:soertArray];
//
//                                    }
//                                }
//
//
//                            }
//
//                        }
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                    });
//
//                } error:^(NSError *error) {
//
//                }];
//            }
//
//        } error:^(NSError *error) {
//
//        }];
//    }
//}











-(UITableView *)orederTabelView{
    if (!_orederTabelView) {
        
        _orederTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navView.bottom, kScreenW, kScreenH -self.navView.height -TOOLBAR_HEIGHT) style:UITableViewStyleGrouped];
        
        _orederTabelView.delegate = self;
        _orederTabelView.dataSource = self;
//         WeakSelf(weakSelf);
//        _orederTabelView.placeHolderView = [[PlaceholderView alloc]initWithFrame:_orederTabelView.bounds onTapView:^{
//            StrongSelf(strongSelf);
//            [strongSelf.orederTabelView reloadData];
//        }];
        _orederTabelView.backgroundColor = UIColorFromHexValue(0xf4f6fd);
        [ _orederTabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
    }
    
    
    return _orederTabelView;
}

#pragma mark ------------UITableViewDelegate---------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        if (_flag == 1) {
            if (self.myArry.count ==0) {
                self.imageViewColor.hidden = NO;
                self.orederTabelView.scrollEnabled = NO;
            }else{
                self.imageViewColor.hidden = YES;
                 self.orederTabelView.scrollEnabled = YES;
            }
            
            return self.myArry.count;
        }else if (_flag ==2){
            if (self.sendenArry.count ==0) {
                self.imageViewColor.hidden = NO;
                 self.orederTabelView.scrollEnabled = NO;
            }else{
                self.imageViewColor.hidden = YES;
                 self.orederTabelView.scrollEnabled = YES;
            }
//


            return self.sendenArry.count;
        }else{
            
            if (self.weiArry.count ==0) {
                self.imageViewColor.hidden = NO;
                 self.orederTabelView.scrollEnabled = NO;
            }else{
                self.imageViewColor.hidden = YES;
                 self.orederTabelView.scrollEnabled = YES;
            }
            return self.weiArry.count;
        }
        
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        OrderFirstTableViewCell *cell = [OrderFirstTableViewCell cellWithTableView:tableView];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.countNmb = self.myArry.count +self.weiArry.count+self.sendenArry.count;
            cell.counRmb = self.allRmb;
            cell.suncedCount = self.gongNuber;
            if (!cell.countNmb || cell.countNmb == 0) {
                cell.prendStr = 0.0 ;
            }else {
                cell.prendStr = 1.0 * cell.suncedCount / cell.countNmb ;
            }
        });
        return cell;
    }
    
    else{
        
        
        
        OrederTableViewCell *cell = [OrederTableViewCell cellWithTableView:tableView];
        switch (_flag) {
            case 1:
                 cell.orderM = self.myArry[indexPath.row];
                break;
             case 2:
                cell.orderH =self.sendenArry[indexPath.row];
                break;
            case 3:
                cell.orderW = self.weiArry[indexPath.row];

            default:
                break;
        }
        
        return cell;
    }
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1&&_flag == 1) {
        
        PredictViewController *vc = [[PredictViewController alloc]init];
        vc.orderM = self.myArry[indexPath.row];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else if (indexPath.section == 1 &&_flag==3){
        PredictViewController *vc = [[PredictViewController alloc]init];
        vc.orderM = self.weiArry[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        

    }else if (indexPath.section == 1 &&_flag==2){
        
        PredictViewController *vc = [[PredictViewController alloc]init];
        vc.orderM = self.sendenArry[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}


#pragma mark ---------------UITableViewDataSource-------------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return 180;
    }else if(indexPath.section == 1){
        
        if (_flag == 1) {
            OrderModel *orderM = self.myArry[indexPath.row];
            if (orderM.room_type == 0) {
                
                return [orderM getroomtypeHeight];
            }

            return [orderM getHeight];
        }
        if (_flag == 3) {
            
            OrderModel *orderW = self.weiArry[indexPath.row];
            if (orderW.room_type == 0) {
                return [orderW getroomtypeHeight];
            }

            return [orderW getHeight];
        }
        
        if (_flag == 2) {
            OrderModel *orderM = self.sendenArry[indexPath.row];
            if (orderM.room_type == 0) {
                
                return [orderM getroomtypeHeight];
            }
            return [orderM getHeight];
        }
    }
   
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
         return 20;
    }else{
        
        return 40;
    }
    
   
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray * itemArray = @[NSLocalizedStringFromTable(@"Ongoing",@"Internation", nil),NSLocalizedStringFromTable(@"To Be Settled",@"Internation", nil),NSLocalizedStringFromTable(@"Ended",@"Internation", nil)];
    _headerView  =  [[CPTopAnimationView alloc] initWithFrame:CGRectMake(15, 0, kScreenW-30, 44) WithTitles:itemArray flag:self.flag-1];
    _headerView.backgroundColor = [UIColor clearColor];
    __weak typeof(self) _self = self;
    _headerView.swipe = ^(NSInteger index) {
        _self.flag = index;
        [_self.orederTabelView reloadData];
    };

    
    if (section == 0) {
        
         return UIView.new;
    }else{
        
        return _headerView;
    }
    
    
   
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return UIView.new;
}



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


-(void)reloading{
//    self.tableView.placeHolderView = [[GYNoDataView alloc] initWithFrame:self.view.bounds image:[UIImage imageNamed:@"no_data"] viewClick:^{
//        NSLog(@"点击了没有更多数据的图片");
//        
//    }];
    
    [self.orederTabelView reloadData];
}



@end
