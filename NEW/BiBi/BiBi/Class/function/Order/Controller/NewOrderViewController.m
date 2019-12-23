//
//  NewOrderViewController.m
//  BiBi
//
//  Created by 武建斌 on 2019/4/10.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "NewOrderViewController.h"
#import "NewOrderHeaderView.h"
#import "NewOrderCell.h"
#import "BitsharesWalletObject.h"
#import "MJExtension.h"
#import "OrederTableViewCell.h"
#import "OrderModel.h"
#import "PredictViewController.h"
#import "WuLoadingView.h"
@interface NewOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
//tableView
@property(nonatomic,strong)UITableView *orederTabelView;
//总金额
@property(nonatomic,assign)NSInteger allRmb;

//胜场
@property(nonatomic,assign)NSInteger winNub;

@property(nonatomic,assign)NSInteger total_Nuber;

@property(nonatomic,strong)NSArray *total_arry;

@property(nonatomic,strong)NSMutableArray *mrArry;

//累计收益数组
@property(nonatomic,strong)NSArray *winArry_Rmb;

//累计订单数据
@property(nonatomic,strong)NSArray *total_orderCount;

//中奖的订单数
@property(nonatomic,strong)NSArray *winArry_Number;

//切换的标识符
@property(nonatomic,assign)NSInteger flag;

//切换进行中订单的标识

@property(nonatomic,assign)NSInteger topFlag;


//定义一个可变数据 进行中
@property(nonatomic,strong)NSMutableArray *ongoingOrder;

//待结算
@property(nonatomic,strong)NSMutableArray *weiOrder;

//已完成
@property(nonatomic,strong)NSMutableArray *finendOrder;

//loading
@property(nonatomic,strong)WuLoadingView *loadingView;

//总共金额
@property(nonatomic,assign)float jinerLbel;


//显示图片
@property(nonatomic,strong)UIImageView *iamgeViewIcon;

@property(nonatomic,strong)UIView *imageViewColor;

//存放itemarry
@property(nonatomic,strong)NSMutableArray *itemarry;



@end

@implementation NewOrderViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self setPaly];
//    [self setPaly1];
//    [self setPaly2];
   
    self.flag = 0;
    self.topFlag = 0;
    [self getAccountName:M_userName];
//    [self setpalyInfo];
    [self setHideenImageColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopView];
//    [[BitsharesWalletObject BitsharesWalletObjectManager] needConnect];
    [BitsharesWalletObject BitsharesWalletObjectManager].connectStatusChange = ^(WebsocketConnectStatus status) {
        NSLog(@"status change");
        if (status ==WebsocketConnectStatusClosed) {
            [self.loadingView cancelView];
            [[BitsharesWalletObject BitsharesWalletObjectManager] needConnect];
        }else if (status == WebsocketConnectStatusConnected) {
//            [self clicked];
        }
    };

    [self.view addSubview:self.orederTabelView];
//    [self.orederTabelView reloadData];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     self.imageViewColor.hidden = YES;
}

#pragma mark ----NAV-----
-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    
    self.navigationController.navigationBarHidden = YES;
    
    self.navView.title = NSLocalizedStringFromTable(@"order",@"Internation", nil);
    
}



-(void)setHideenImageColor{
    self.imageViewColor = [[UIView alloc]init];
    self.imageViewColor.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.imageViewColor];
    [self.imageViewColor mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_iPhoneX) {
            make.top.mas_equalTo(348);
        }else{
            make.top.mas_equalTo(324);
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


#pragma mark----------切换币种------------

-(void)setPaly:(NSString *)asset andisfisrt:(BOOL)isok{
    
    if (!isok) {
            dispatch_async(dispatch_get_main_queue(), ^{
                WuLoadingView *loadingView = [[WuLoadingView alloc]init];
                self.loadingView = loadingView;
                [loadingView showLoadingView];
            });
        
    }

      NSLog(@"一共走2次");
    self.ongoingOrder = [NSMutableArray arrayWithCapacity:200];
    
    if ([asset isEqualToString:@"SEER"]) {
        asset = @"1.3.0";
    }else if ([asset isEqualToString:@"USDT"]){
        asset = @"1.3.5";
        //                jarry = @"PFC";
    }else if ([asset isEqualToString:@"PFC"]){
        //                 jarry = @"PFC";
        asset = @"1.3.2";
    }
    __block NSInteger finCount = 0;
//    __block int tow = 0;
    
    [[BitsharesWalletObject BitsharesWalletObjectManager]getHistoryOrder:M_ID andAsset:asset andStatus:1 unixTimeStr:2592000 withPaage:1000 success:^(NSArray<OrderContention*> *result) {
        
        if (result.count == 0) {
            [self.orederTabelView reloadData];
            [self.loadingView cancelView];
            return ;
        }
        for (OrderContention *orderCont in result) {
            [[BitsharesWalletObject BitsharesWalletObjectManager]getSeerRoom:@"get_seer_room" fristString:(ObjectId*)orderCont.room nLimint:0 secondInt:2 success:^(RoomAccount *roomoder) {
                finCount++;
                OrderModel *model = [[OrderModel alloc]init];
                //房间类型
                model.room_type = roomoder.room_type;
                //房间号
                model.roomId = roomoder.identifier;
                //房间内容
                model.contentStr = roomoder.description_des;
                //币种
                model.accept_asset = asset;
                //币id
                model.ass_id = asset;
                //房间选项
                model.chooseStr = roomoder.running_option.selection_description[orderCont.input];
                //房间选项第几个
                model.choosenumber = orderCont.input;
                //收入支出实际花费
                model.paid = orderCont.paid;
                //投注时间
                model.timeOutStr = orderCont.when;
                //固定赔率
                model.awards = roomoder.running_option.advanced.awards;
                //投注金额
                if (model.room_type == 0) {
                    model.amount = orderCont.amount;
                }else{
                    //注意此处有坑
                    model.amount =model.paid;
                }
                
                //订单里面的东西
                //固定金额
                model.pool = roomoder.running_option.advanced.pool;
                model.awards = roomoder.running_option.advanced.awards;
                //固定赔付金额和投注金额
                model.total_participate = roomoder.running_option.advanced_running.total_participate;
                //份数选项
                model.items_countNum = roomoder.running_option.lmsr_running.items_countNum;
                //那个L
                model.lmsr_number = roomoder.running_option.lmsr.lmsr_number;
                model.proportion =[roomoder.running_option.pvp_running valueForKey:@"total_participate"];
                //截止时间
                model.timeStop = roomoder.option.stop;
                //选项
                model.choseButcount = roomoder.running_option.selection_description;
                //参与人数 金额 显示的币种
                model.total_shares = roomoder.running_option.total_shares;
                model.totalpeople = roomoder.running_option.total_player_count;
                model.percent = roomoder.option.result_owner_percent/100;
                model.timeStopEN = roomoder.option.stop;
                model.accept_asset =roomoder.option.accept_asset;
                //金额
                if ([model.accept_asset isEqualToString:@"SEER"]) {
                    model.totalmoneyaCount = roomoder.running_option.total_shares/100000;
                    model.minNub = roomoder.option.minimum/100000;
                    model.maxNub = roomoder.option.maximum/100000;
                }else if ([model.accept_asset isEqualToString:@"USDT"]){
                    model.totalmoneyaCount = roomoder.running_option.total_shares/100;
                    model.minNub = roomoder.option.minimum/100;
                    model.maxNub = roomoder.option.maximum/100;
                }else if ([model.accept_asset isEqualToString:@"PFC"]){
                    model.totalmoneyaCount = roomoder.running_option.total_shares/100000;
                    model.minNub = roomoder.option.minimum/100000;
                    model.maxNub = roomoder.option.maximum/100000;
                }
                
                NSString *oneStr = NSLocalizedStringFromTable(@"Sports",@"Internation", nil);
                NSString *twoStr =NSLocalizedStringFromTable(@"bibiquan",@"Internation", nil);
                NSString *thirsStr = NSLocalizedStringFromTable(@"hot top",@"Internation", nil);
                if ([roomoder.house_id isEqualToString:oneStr]||[roomoder.house_id isEqualToString:twoStr]||[roomoder.house_id isEqualToString:thirsStr]) {
                    [self.ongoingOrder addObject:model];
                }
                
                NSArray * soertArray = [self.ongoingOrder sortedArrayUsingComparator:^NSComparisonResult(OrderModel *  _Nonnull modle1, OrderModel*  _Nonnull modle2) {
                    NSComparisonResult result = [modle1.timeOutStr compare:modle2.timeOutStr];
                    return result == NSOrderedAscending; // 升序
                }];
                [self.ongoingOrder removeAllObjects];
                self.ongoingOrder = [NSMutableArray arrayWithArray:soertArray];
                if (finCount == result.count) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.orederTabelView reloadData];
                        [self.loadingView cancelView];
                        NSLog(@"一共走几次-------");
                    });
                }


            } error:^(NSError *error) {
                
            }];
        }

        
    } error:^(NSError *error) {
        
        
    }];
    
    
    
    
    
    
    
}



#pragma mark --------切换订单---------------
-(void)setPaly2:(NSString*)asset andWithStatus:(NSInteger)Status withflag:(NSInteger)flag{
    self.itemarry = [NSMutableArray array];
    dispatch_async(dispatch_get_main_queue(), ^{
        WuLoadingView *loadingView = [[WuLoadingView alloc]init];
        self.loadingView = loadingView;
        [loadingView showLoadingView];
    });
    if ([asset isEqualToString:@"SEER"]) {
        asset = @"1.3.0";
    }else if ([asset isEqualToString:@"USDT"]){
        asset = @"1.3.5";
    }else if ([asset isEqualToString:@"PFC"]){
        asset = @"1.3.2";
    }
    if (Status == 0) {
        Status =1;
    }else if (Status == 1){
        Status = 2;
    }else if (Status ==2){
        Status = 4;
    }
    [self.ongoingOrder removeAllObjects];
    self.ongoingOrder = [NSMutableArray arrayWithCapacity:200];

    __block NSInteger finCount =0;
    [[BitsharesWalletObject BitsharesWalletObjectManager]getHistoryOrder:M_ID andAsset:asset andStatus:Status unixTimeStr:2592000 withPaage:1000 success:^(NSArray<OrderContention*> *result) {
        
        if (result.count == 0) {
            [self.loadingView cancelView];
            [self.orederTabelView reloadData];
            return;
        }
        for (OrderContention *orderCont in result) {
            [[BitsharesWalletObject BitsharesWalletObjectManager]getSeerRoom:@"get_seer_room" fristString:(ObjectId*)orderCont.room nLimint:0 secondInt:2 success:^(RoomAccount *roomoder) {
                finCount++;
                OrderModel *model = [[OrderModel alloc]init];
                //房间类型
                model.room_type = roomoder.room_type;
                //房间号
                model.roomId = roomoder.identifier;
                //房间内容
                model.contentStr = roomoder.description_des;
                //币种
                model.accept_asset = asset;
                //币id
                model.ass_id = asset;
                //房间选项
                model.chooseStr = roomoder.running_option.selection_description[orderCont.input];
                //房间选项第几个
                model.choosenumber = orderCont.input;
                //收入支出实际花费
                model.paid = orderCont.paid;
                //投注时间
                model.timeOutStr = orderCont.when;
                //固定赔率
                model.awards = roomoder.running_option.advanced.awards;
                //投注金额
                if (model.room_type == 0) {
                    model.amount = orderCont.amount;
                }else{
                    model.amount =model.paid;
                }
                
                //中奖金额
                
                
                //订单里面的东西
                //固定金额
                model.pool = roomoder.running_option.advanced.pool;
                model.awards = roomoder.running_option.advanced.awards;
                //固定赔付金额和投注金额
                model.total_participate = roomoder.running_option.advanced_running.total_participate;
                //份数选项
                model.items_countNum = roomoder.running_option.lmsr_running.items_countNum;
                //那个L
                model.lmsr_number = roomoder.running_option.lmsr.lmsr_number;
                model.proportion =[roomoder.running_option.pvp_running valueForKey:@"total_participate"];
                //截止时间
                model.timeStop = roomoder.option.stop;
                //选项
                model.choseButcount = roomoder.running_option.selection_description;
                //参与人数 金额 显示的币种
                model.total_shares = roomoder.running_option.total_shares;
                model.totalpeople = roomoder.running_option.total_player_count;
                model.percent = roomoder.option.result_owner_percent/100;
                model.timeStopEN = roomoder.option.stop;
                model.accept_asset =roomoder.option.accept_asset;
                if (orderCont.reward) {
                    model.reward = orderCont.reward;
                    model.orderIndex = flag;
                }else{
                    model.reward = 0;
                    model.orderIndex = flag;
                }
                
                //金额的倍数
                if ([model.accept_asset isEqualToString:@"SEER"]) {
                    model.totalmoneyaCount = roomoder.running_option.total_shares/100000;
                    model.minNub = roomoder.option.minimum/100000;
                    model.maxNub = roomoder.option.maximum/100000;
                }else if ([model.accept_asset isEqualToString:@"USDT"]){
                    model.totalmoneyaCount = roomoder.running_option.total_shares/100;
                    model.minNub = roomoder.option.minimum/100;
                    model.maxNub = roomoder.option.maximum/100;
                }else if ([model.accept_asset isEqualToString:@"PFC"]){
                    model.totalmoneyaCount = roomoder.running_option.total_shares/100000;
                    model.minNub = roomoder.option.minimum/100000;
                    model.maxNub = roomoder.option.maximum/100000;
                }
                //判断中奖选项
                if (roomoder.running_option.final_result != nil && ![roomoder.running_option.final_result isKindOfClass:[NSNull class]] && roomoder.running_option.final_result.count != 0){
                    model.winnerLabel = [NSString stringWithFormat:@"%@",roomoder.running_option.final_result.firstObject];
                }

                
                NSString *oneStr = NSLocalizedStringFromTable(@"Sports",@"Internation", nil);
                NSString *twoStr =NSLocalizedStringFromTable(@"bibiquan",@"Internation", nil);
                NSString *thirsStr = NSLocalizedStringFromTable(@"hot top",@"Internation", nil);
                if ([roomoder.house_id isEqualToString:oneStr]||[roomoder.house_id isEqualToString:twoStr]||[roomoder.house_id isEqualToString:thirsStr]) {
                    [self.ongoingOrder addObject:model];
                }
                
//                NSArray * soertArray = [self.ongoingOrder sortedArrayUsingComparator:^NSComparisonResult(OrderModel *  _Nonnull modle1, OrderModel*  _Nonnull modle2) {
//                    NSComparisonResult result = [modle1.timeOutStr compare:modle2.timeOutStr];
//                    return result == NSOrderedAscending; // 升序
//                }];
//                [self.ongoingOrder removeAllObjects];
//                self.ongoingOrder = [NSMutableArray arrayWithArray:soertArray];
                if (finCount == result.count) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.orederTabelView reloadData];
                        [self.loadingView cancelView];
                        NSLog(@"一共走几次-------");
                    });
                }
                
                
            } error:^(NSError *error) {
                
            }];
        }
        
//        @property(nonatomic,copy)NSString *identifier;
//        //投注的选手
//        @property(nonatomic,copy)NSString *player;
//        //投注的房间
//        @property(nonatomic,copy)NSString *room;
//        //选项
//        @property(nonatomic,assign)int input;
//        //投注的总金额
//        @property(nonatomic,assign)NSInteger amount;
//        //reward
//        @property(nonatomic,assign)NSInteger reward;
//        //status
//        @property(nonatomic,assign)NSInteger status;
//        //paid
//        @property(nonatomic,assign)NSInteger paid;
//        for (OrderContention *orderCont in result) {
//            for (OrderToclass *orderClass in orderCont.items_order) {
//                 OrderModel *model = [[OrderModel alloc]init];
//                //房间
//                model.room = orderCont.room;
//                //选项
//                model.input = orderCont.input;
//                //投注人
//                model.player = orderCont.player;
//                //投注总金额
//                model.amount = orderCont.amount;
//                //reward
//                model.reward = orderCont.reward;
//                //paid
//                model.paid = orderCont.paid;
//                //
//                
//            }
//        }
        
//        for (OrderContention *orderCont in result) {
        
//            [self.itemarry addObject:orderCont];
//
//             finCount+=orderCont.items_order.count;
//            NSLog(@"这个fincount是多少%ld",(long)finCount);
//
//            for (OrderToclass *orderClass in orderCont.items_order) {
//                tow++;
//                NSLog(@"第一次刷新了几次%ld",tow);
//
//                [[BitsharesWalletObject BitsharesWalletObjectManager]getSeerRoom:@"get_seer_room" fristString:(ObjectId*)orderCont.room nLimint:0 secondInt:1 success:^(RoomAccount *roomoder) {
//
//                    NSLog(@"这个数量是多少%ld",finCount);
//                    NSLog(@"这个房间是多少%ld",roomoder.room_type);
//                    NSLog(@"这个选项是多少%f",orderClass.amount);
//                    NSLog(@"这个中奖的数量是多少%f",orderClass.paid);
//                    OrderModel *model = [[OrderModel alloc]init];
//
//                    //房间类型
//                    model.room_type = roomoder.room_type;
//                    //房间号
//                    model.roomId = roomoder.identifier;
//                    //房间的内容
//                    model.contentStr = roomoder.description_des;
//                    //币种
//                    model.accept_asset = asset;
//                    model.ass_id = asset;
//                    //房间选项
//                    model.chooseStr = roomoder.running_option.selection_description[orderCont.input];
//                    model.choosenumber = orderCont.input;
//                    //收入或者支出金额
//                    model.paid = orderClass.paid;
//                    //固定赔率
//                    model.awards = roomoder.running_option.advanced.awards;
//                    //投注时间
//                    model.timeOutStr = orderClass.when;
//                    //投注金额
//                    if (model.room_type == 0) {
//                        model.amount = orderClass.amount;
//                    }else{
//                        model.amount = orderClass.paid;
//                    }
//
//
//                    //订单里面的东西
//                    //截止时间
//                    //固定金额
//                    model.pool = roomoder.running_option.advanced.pool;
//                    model.awards = roomoder.running_option.advanced.awards;
//                    //固定赔付金额和投注金额
//                    model.total_participate = roomoder.running_option.advanced_running.total_participate;
//                    //份数选项
//                    model.items_countNum = roomoder.running_option.lmsr_running.items_countNum;
//                    //那个L
//                    model.lmsr_number = roomoder.running_option.lmsr.lmsr_number;
//
//
//                    model.proportion =[roomoder.running_option.pvp_running valueForKey:@"total_participate"];
//
//                    model.timeStop = roomoder.option.stop;
//                    //选项
//                    model.choseButcount = roomoder.running_option.selection_description;
//                    model.total_shares = roomoder.running_option.total_shares;
////                    model.totalmoneyaCount = roomoder.running_option.total_shares/100000;
//                    model.totalpeople = roomoder.running_option.total_player_count;
//                    model.percent = roomoder.option.result_owner_percent/100;
//                    model.timeStopEN = roomoder.option.stop;
//                    model.accept_asset =roomoder.option.accept_asset;
//                    if ([model.accept_asset isEqualToString:@"SEER"]) {
//                        model.totalmoneyaCount = roomoder.running_option.total_shares/100000;
//                        model.minNub = roomoder.option.minimum/100000;
//                        model.maxNub = roomoder.option.maximum/100000;
//                    }else if ([model.accept_asset isEqualToString:@"USDT"]){
//                        model.totalmoneyaCount = roomoder.running_option.total_shares/100;\
//                        model.minNub = roomoder.option.minimum/100;
//                        model.maxNub = roomoder.option.maximum/100;
//                    }else if ([model.accept_asset isEqualToString:@"PFC"]){
//                        model.totalmoneyaCount = roomoder.running_option.total_shares/100000;
//                        model.minNub = roomoder.option.minimum/100000;
//                        model.maxNub = roomoder.option.maximum/100000;
//
//                    }
//
//
//                    model.totalmoneyaCount = roomoder.running_option.total_shares;
//
//
//
//                    //pvp房间的房间的总金额
//                    if (orderCont.reward) {
//                        model.status_int = orderCont.input;
//                        model.total_shares = roomoder.running_option.total_shares;
//                        model.proportion = [roomoder.running_option.pvp_running valueForKey:@"total_participate"];
//                        NSLog(@"----%.2f----",model.total_shares/[model.proportion[orderCont.input] floatValue] );
//                        model.orderIndex = Status;
//
//                        if (roomoder.room_type ==1) {
//                            model.reward = (model.total_shares/[model.proportion[orderCont.input] floatValue] )*orderClass.paid;
//                        }else if(roomoder.room_type ==2) {
//                            model.reward = orderClass.amount;
//                        }else{
//                             model.reward = orderClass.paid;
//                        }
//                    }else{
//                        model.reward = 0.0;
//                        model.orderIndex = Status;
//                        NSLog(@"----这个数是多少%f-----",model.reward);
//                    }
//                    //判断正确选项
//                    if (roomoder.running_option.final_result != nil && ![roomoder.running_option.final_result isKindOfClass:[NSNull class]] && roomoder.running_option.final_result.count != 0){
//                        model.winnerLabel = [NSString stringWithFormat:@"%@",roomoder.running_option.final_result.firstObject];
//                    }
//                    NSString *oneStr = NSLocalizedStringFromTable(@"Sports",@"Internation", nil);
//                    NSString *twoStr =NSLocalizedStringFromTable(@"bibiquan",@"Internation", nil);
//                    NSString *thirsStr = NSLocalizedStringFromTable(@"hot top",@"Internation", nil);
//                    if ([roomoder.house_id isEqualToString:oneStr]||[roomoder.house_id isEqualToString:twoStr]||[roomoder.house_id isEqualToString:thirsStr]) {
//                        [self.ongoingOrder addObject:model];
//
//                    }
//
//                    NSArray * soertArray = [self.ongoingOrder sortedArrayUsingComparator:^NSComparisonResult(OrderModel *  _Nonnull modle1, OrderModel*  _Nonnull modle2) {
//                        NSComparisonResult result = [modle1.timeOutStr compare:modle2.timeOutStr];
//                        return result == NSOrderedAscending; // 升序
//                    }];
//                    [self.ongoingOrder removeAllObjects];
//                    self.ongoingOrder = [NSMutableArray arrayWithArray:soertArray];
//                    if (tow == finCount) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self.loadingView cancelView];
//                            [self.orederTabelView reloadData];
//
//                            NSLog(@"%@",self.ongoingOrder);
//
//                            NSLog(@"刷新了几次%ld",tow);
//                        });
//                    }
//
//
//                } error:^(NSError *error) {
//
//                }];
//            }
//        }
       
        
        
        
    } error:^(NSError *error) {
        
    }];
    
}

-(void)setupItem:(OrderContention *)orderCont{
//    for (OrderToclass *orderClass in orderCont.items_order) {
//        [self.itemarry addObject:orderClass];
//    }
    
}


#pragma mark -------初始化加载-------------
-(void)setpalyInfo{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        WuLoadingView *loadingView = [[WuLoadingView alloc]init];
        self.loadingView = loadingView;
        [loadingView showLoadingView];
    });
    __block int finsed = 0;

    [[BitsharesWalletObject BitsharesWalletObjectManager] getplayInfo:M_ID success:^(OrderAccount *result) {
        finsed++;
        if (result.count_total<=0) {
            [self.loadingView cancelView];
            return;
        }
        self.total_arry= result.share_total;
        self.total_orderCount = result.count_total;
        self.winArry_Rmb = result.share_wins;
        self.winArry_Number = result.count_wins;
        
        NSString * jarry;
        self.mrArry = [NSMutableArray arrayWithCapacity:10];
        self.weiOrder = [NSMutableArray arrayWithCapacity:10];
        for (int i =0; i<self.total_orderCount.count; i++) {
            jarry = self.total_arry[i][0];
            if ([jarry isEqualToString:@"1.3.0"]) {
                jarry = @"SEER";
            }else if ([jarry isEqualToString:@"1.3.5"]){
                jarry = @"USDT";
//                jarry = @"PFC";
            }else if ([jarry isEqualToString:@"1.3.2"]){
//                 jarry = @"PFC";
                 jarry = @"PFC";
            }
            [self.weiOrder addObject:self.total_arry[i][0]];
            [self.mrArry addObject:jarry];
            
        }
        //这块固定值显示
        //判断完在第几个选项里面
        if (self.total_arry.count>0) {
            if ([MoneyPacketManager moneyAcctountManager].assorder_id.length>0) {
                [self setPaly:[MoneyPacketManager moneyAcctountManager].assorder_id andisfisrt:YES];
                for (int i =0; i<self.weiOrder.count; i++) {
                    if ([self.weiOrder[i] isEqualToString:[MoneyPacketManager moneyAcctountManager].assorder_id]) {
                        self.flag = i;
                    }
                }
                [MoneyPacketManager moneyAcctountManager].assorder_id = @"";
            }else{
                [self setPaly:self.total_arry[0][0] andisfisrt:YES];
                
            }
        }else{
            [self.loadingView cancelView];
             [self.ongoingOrder removeAllObjects];
            [self.orederTabelView reloadData];
            return;
        }
       
       
    } error:^(NSError *error) {
        
        
    }];
    
}


//查询id
-(void)getAccountName:(NSString *)identifier{
    [[BitsharesWalletObject BitsharesWalletObjectManager] getAccount:identifier success:^(AccountObject *result) {
        [MoneyPacketManager moneyAcctountManager].userName = result.name;
        [MoneyPacketManager moneyAcctountManager].identifier =[NSString stringWithFormat:@"%@",result.identifier];
        //查完名字调这个接口
        [self setpalyInfo];
    } error:^(NSError *error) {
        
    }];
}

-(UITableView *)orederTabelView{
    if (!_orederTabelView) {
        _orederTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navView.bottom, kScreenW, kScreenH -self.navView.height -TOOLBAR_HEIGHT) style:UITableViewStyleGrouped];
        _orederTabelView.delegate = self;
        _orederTabelView.dataSource = self;
        _orederTabelView.backgroundColor = UIColorFromHexValue(0xf4f6fd);
        [ _orederTabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
    }
    
    return _orederTabelView;
}


#pragma mark ----DataSource-------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (self.ongoingOrder.count<=0) {
        self.imageViewColor.hidden = NO;
        self.orederTabelView.scrollEnabled = NO;
    }else{
        self.imageViewColor.hidden = YES;
        self.orederTabelView.scrollEnabled = YES;
    }
    
    return self.ongoingOrder.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

     OrederTableViewCell *cell = [OrederTableViewCell cellWithTableView:tableView];
   
      cell.orderM = self.ongoingOrder[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PredictViewController *vc = [[PredictViewController alloc]init];
    vc.orderM = self.ongoingOrder[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}






#pragma mark--------UITableViewDelegate-------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     OrderModel *orderW = self.ongoingOrder[indexPath.row];
    if (orderW.room_type ==0) {
        return  [orderW getroomtypeHeight];
    }else{
        return [orderW getHeight];
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 260;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}




-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NewOrderHeaderView *newOrderHeaderView = [[NewOrderHeaderView alloc]initWith:self.mrArry.copy andFlag:self.flag andtopFlag:self.topFlag];
    __weak typeof(self) _self = self;
    newOrderHeaderView.seerTopView.seerpe = ^(NSInteger index) {
        
        NSLog(@"%ld",(long)index);
        _self.flag = index;
        _self.topFlag = 0;
        
        [_self setPaly:self.mrArry[_self.flag]andisfisrt:NO];
        
    };
    
    
    
//    if (self.flag ==0) {
        for (NSArray *marry in self.total_orderCount) {
            if ([self.weiOrder[_self.flag] isEqual:marry[0]]) {
                newOrderHeaderView.countNmb = [marry[1] integerValue];

            }
        }

        for (NSArray *marry in self.winArry_Rmb) {
            if ([self.weiOrder[_self.flag] isEqual:marry[0]]) {
                if ([marry[0] isEqual:@"1.3.0"]) {
                     newOrderHeaderView.counRmb = [marry[1] floatValue]/100000;
                    newOrderHeaderView.leiji = [NSString stringWithFormat:@"%.5f SEER",[marry[1] floatValue]/100000];
                }else if ([marry[0] isEqual:@"1.3.5"]){
                    newOrderHeaderView.counRmb = [marry[1] floatValue]/100;
                    newOrderHeaderView.leiji = [NSString stringWithFormat:@"%.5f USDT",[marry[1] floatValue]/100];
                }else if ([marry[0] isEqual:@"1.3.2"]){
                     newOrderHeaderView.counRmb = [marry[1] floatValue]/100000;
                    newOrderHeaderView.leiji = [NSString stringWithFormat:@"%.5f PFC",[marry[1] floatValue]/100];
                }

            }
        }
        for (NSArray *marry in self.winArry_Number) {
            if ([self.weiOrder[_self.flag] isEqual:marry[0]]) {
                newOrderHeaderView.suncedCount = [marry[1] integerValue];
            }
        }
        if (newOrderHeaderView.countNmb ==0||newOrderHeaderView.suncedCount == 0) {
            newOrderHeaderView.prendStr = 0.0 ;

        }else {
            newOrderHeaderView.prendStr = 1.0 *  newOrderHeaderView.suncedCount / newOrderHeaderView.countNmb;
        }
//
//    }
//    else if (self.flag ==1){
//        for (NSArray *marry in self.winArry_Rmb) {
//            if ([self.weiOrder[_self.flag] isEqual:marry[0]]) {
//                if ([marry[0] isEqual:@"1.3.0"]) {
//                    newOrderHeaderView.counRmb = [marry[1] floatValue]/100000;
//                }else if ([marry[0] isEqual:@"1.3.5"]){
//                    newOrderHeaderView.counRmb = [marry[1] floatValue]/100;
//                }else if ([marry[0] isEqual:@"1.3.2"]){
//                    newOrderHeaderView.counRmb = [marry[1] floatValue]/100000;
//                }
//            }
//        }
//
//        for (NSArray *marry in self.winArry_Number) {
//            if ([self.weiOrder[_self.flag] isEqual:marry[0]]) {
//                newOrderHeaderView.suncedCount = [marry[1] integerValue];
//            }
//        }
//
//        for (NSArray *marry in self.total_orderCount) {
//            if ([self.weiOrder[_self.flag] isEqual:marry[0]]) {
//                newOrderHeaderView.countNmb = [marry[1] integerValue];
//            }
//        }
//
//        if (newOrderHeaderView.countNmb ==0||newOrderHeaderView.suncedCount == 0) {
//            newOrderHeaderView.prendStr = 0.0 ;
//        }else {
//            newOrderHeaderView.prendStr = 1.0 *  newOrderHeaderView.countNmb / newOrderHeaderView.suncedCount;
//        }
//
//
//////        newOrderHeaderView.counRmb = [self.winArry_Rmb[1][1] floatValue];
//////        newOrderHeaderView.countNmb = [self.total_orderCount[1][1] integerValue];
//////        newOrderHeaderView.suncedCount = [self.winArry_Number[1][1] integerValue];
////        if (![self.total_orderCount[1][1] integerValue] ||[self.total_orderCount[1][1] integerValue] == 0) {
////            newOrderHeaderView.prendStr = 0.0 ;
////        }else {
////            newOrderHeaderView.prendStr = 1.0 *  [self.total_orderCount[1][1] integerValue] / [self.winArry_Number[1][1] integerValue];
////        }
////
//    }
//        else if (self.flag ==2){
//            for (NSArray *marry in self.winArry_Rmb) {
//                if ([self.weiOrder[_self.flag] isEqual:marry[0]]) {
//                    if ([marry[0] isEqual:@"1.3.0"]) {
//                        newOrderHeaderView.counRmb = [marry[1] floatValue]/100000;
//                    }else if ([marry[0] isEqual:@"1.3.5"]){
//                        newOrderHeaderView.counRmb = [marry[1] floatValue]/100;
//                    }else if ([marry[0] isEqual:@"1.3.2"]){
//                        newOrderHeaderView.counRmb = [marry[1] floatValue]/100000;
//                    }
//
//                }
//            }
//
//            for (NSArray *marry in self.winArry_Number) {
//                if ([self.weiOrder[_self.flag] isEqual:marry[0]]) {
//                    newOrderHeaderView.suncedCount = [marry[1] integerValue];
//                }
//            }
//
//            for (NSArray *marry in self.total_orderCount) {
//                if ([self.weiOrder[_self.flag] isEqual:marry[0]]) {
//                    newOrderHeaderView.countNmb = [marry[1] integerValue];
//                }
//            }
//
//            if (newOrderHeaderView.countNmb ==0||newOrderHeaderView.suncedCount == 0) {
//                newOrderHeaderView.prendStr = 0.0 ;
//            }else {
//                newOrderHeaderView.prendStr = 1.0 *  newOrderHeaderView.countNmb / newOrderHeaderView.suncedCount;
//            }
//
////
////        newOrderHeaderView.countNmb = [self.total_orderCount[2][1] integerValue];
//////        newOrderHeaderView.suncedCount = [self.winArry_Number[2][1] integerValue];
//////        newOrderHeaderView.counRmb = [self.winArry_Rmb[2][1] floatValue];
////        if (![self.total_orderCount[2][1] integerValue] ||[self.total_orderCount[2][1] integerValue] == 0) {
////            newOrderHeaderView.prendStr = 0.0 ;
////        }else {
//////            newOrderHeaderView.prendStr = 1.0 *  [self.total_orderCount[2][1] integerValue] / [self.winArry_Number[2][1] integerValue];
////        }
////
//    }
//
    newOrderHeaderView.headerView.swipe = ^(NSInteger index) {
        _self.topFlag = index;
        if (self.mrArry.count>0) {
            [_self setPaly2:self.mrArry[_self.flag] andWithStatus:_self.topFlag withflag:_self.topFlag];
        }else{
            
        }
    };
    
    return newOrderHeaderView;
}






-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return UIView.new;
}





@end
