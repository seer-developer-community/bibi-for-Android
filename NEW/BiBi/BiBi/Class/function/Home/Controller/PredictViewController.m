//
//  PredictViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/27.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "PredictViewController.h"
#import "PredictTableView.h"
#import "CPToolView.h"
#import "BrainKey.h"
#import "BitsharesWalletObject.h"
#import "BitsharesWallet.h"
#import "PrivateKey.h"
#import "PublicKey.h"
#import "PredictHeaderModel.h"
#import "CreateWalletViewController.h"
#import "passWordView.h"
#import "QuizzesSucdViewController.h"
#import "RechargeViewController.h"
#import "TextOrederViewController.h"
#import "WuLoadingView.h"
@interface PredictViewController ()<SDChatTableViewDelegate,UITextViewDelegate,CPPassCPToolViewProtocol>
@property(nonatomic,strong)PredictTableView *predictTableView;
//@property (nonatomic,strong) BitsharesWalletObject *wallet;
@property (nonatomic,assign) BOOL connected;

@property(nonatomic,strong)NSMutableArray *arry;

@property(nonatomic,assign)NSInteger trnNum;

//loading
@property(nonatomic,strong)WuLoadingView *loadingView;

@end

@implementation PredictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self setTopView];
    [self setupUI];
    //    [self setupURL];
    
//    

}



//-(void)setupURL{
//    _wallet = [[BitsharesWalletObject alloc]initWithChainId:@"cea4fdf4f5c2278f139b22e782b308928f04008b0fc2c79970a58974a2a28f91" prefix:@"SEER"];
//    [self needConnect];
//    __weak typeof(self) weakSelf = self;
//    _wallet.connectStatusChange = ^(WebsocketConnectStatus status) {
//        weakSelf.connected = status == WebsocketConnectStatusConnected;
//        NSLog(@"status change");
//    };
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // 阻塞当前方法，使方法进入等待
//        while (!self.connected) {}
//        // 当连接成功后发送消息
//
//
//        [self clicked];
//    });
//
//
//}
//
//
//- (void)needConnect {
//
//    [_wallet connectUrl:@"ws://39.105.189.224/ws" timeOut:10 connectedError:^(NSError *error) {
//        [self needConnect];
//
//    }];
//}




-(void)clicked{
    if ([MoneyPacketManager moneyAcctountManager].isLogin) {
        __weak typeof(self) weakSelf = self;
        self.arry = [NSMutableArray arrayWithCapacity:100];
        [[BitsharesWalletObject BitsharesWalletObjectManager] getAccount:[MoneyPacketManager moneyAcctountManager].userName success:^(AccountObject *result) {
            [[BitsharesWalletObject BitsharesWalletObjectManager] listAccountBalance:result success:^(NSArray<AssetAmountObject *> * yuere) {
                for (AssetAmountObject *amountObject in yuere) {
                    PredictHeaderModel *model = [[PredictHeaderModel alloc]init];
                    if ([amountObject.assetId isEqual:@"1.3.0"]) {
                        model.ass_id = [NSString stringWithFormat:@"%@",amountObject.assetId];
                        model.minNub = amountObject.amount/100000.00;
                        [MoneyPacketManager moneyAcctountManager].surplus = model.minNub;
                    }else if ([amountObject.assetId isEqual:@"1.3.5"]){
                        model.minNub = amountObject.amount/100.00;
                        model.ass_id = [NSString stringWithFormat:@"%@",amountObject.assetId];
                        [MoneyPacketManager moneyAcctountManager].usdt_surplus =model.minNub;
                    }
                    else if([amountObject.assetId isEqual:@"1.3.2"]){
                        model.minNub = amountObject.amount/10000.00;
                        model.ass_id = [NSString stringWithFormat:@"%@",amountObject.assetId];
                        [MoneyPacketManager moneyAcctountManager].pdfc_surplus =model.minNub;
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.predictTableView reloadData];
                });
            } error:^(NSError *error) {
                
            }];
            
        } error:^(NSError *error) {
            
        }];
    }
}



-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    self.navigationController.navigationBarHidden = YES;
    self.navView.title = NSLocalizedStringFromTable(@"Predictions",@"Internation", nil);
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick)
                         forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
    
    
}


-(void)goBackClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"wujianbin" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(PredictTableView *)predictTableView{
    if(!_predictTableView){
        _predictTableView = [[PredictTableView alloc]initWithFrame:CGRectMake(0, self.navView.bottom, kScreenW, kScreenH - self.navView.height) style:UITableViewStyleGrouped];
        _predictTableView.sd_delegate = self;
        
        if (self.preModel) {
            _predictTableView.tableprdModel = self.preModel;
        }else if (self.orderM){
            
            _predictTableView.orderM = self.orderM;
        }
        //传数据
        
        
        _predictTableView.separatorStyle =   UITableViewCellSeparatorStyleSingleLine;
        
        _predictTableView.backgroundColor = UIColorFromHexValue(0xf4f6fd);
        
    }
    
    return _predictTableView;
    
}


-(void)setupUI{
    
    [self.view addSubview:self.predictTableView];
    [self clicked];
    
}






//代理回调
-(void)SDChatTableView:(id)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([MoneyPacketManager moneyAcctountManager].isLogin) {
        
        //总感觉这一步有问题
        
        if (self.preModel) {
            CPToolView *cp = [[CPToolView alloc]initWithRoomtype:self.preModel.room_type];
            cp.delegate =self;
            [[UIApplication sharedApplication].keyWindow addSubview:cp ];
            cp .backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
            cp.indexpath = indexPath.row;
            cp.preModel = self.preModel;
            cp.choseStr = self.preModel.choseButcount[indexPath.row];
            self.trnNum = indexPath.row;
            
        }else if (self.orderM){
            
            CPToolView *cp = [[CPToolView alloc]initWithRoomtype:self.orderM.room_type];
            cp.delegate =self;
            [[UIApplication sharedApplication].keyWindow addSubview:cp ];
            cp .backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
            cp.indexpath = indexPath.row;
            cp.toolOrderM = self.orderM;
            cp.choseStr = self.orderM.choseButcount[indexPath.row];
            self.trnNum = indexPath.row;
        }
        
        
        
        
    }else{
        
        CreateWalletViewController * CV = [[CreateWalletViewController alloc]init];
        
        [self.navigationController pushViewController:CV animated:YES];
        //
        
    }
    
    
    //
    //    CPToolView *cp = [[CPToolView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //    cp.delegate =self;
    ////    [[UIApplication sharedApplication].keyWindow addSubview:cp ];
    //    cp.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
    //
    //    //总感觉这一步有问题
    //    cp.preModel = self.preModel;
    //    cp.choseStr = self.preModel.choseButcount[indexPath.row];
    //    self.trnNum = indexPath.row;
    //
    
    
}

-(void)pushnextVc{
    
    RechargeViewController *rechVc = [[RechargeViewController alloc]init];
    
    [self.navigationController pushViewController:rechVc animated:YES];
    
}




-(void)puttool:(NSString *)assid withRoomId:(NSString *)roomID andIndexNumber:(NSInteger)idnexNmuber andTrnumber:(NSInteger)trnumber{
    dispatch_async(dispatch_get_main_queue(), ^{
        WuLoadingView *loadingView = [[WuLoadingView alloc]init];
        self.loadingView = loadingView;
        [loadingView showLoadingView];
    });
    NSInteger putNumber = 0;
    if ([assid isEqualToString:@"1.3.0"]) {
        putNumber = idnexNmuber *100000;
    }else if ([assid isEqualToString:@"1.3.5"]){
        putNumber = idnexNmuber*100;
    }else if ([assid isEqualToString:@"1.3.2"]){
        putNumber = idnexNmuber*100000;
    }
    
    [[BitsharesWalletObject BitsharesWalletObjectManager] getAccount:M_userName success:^(AccountObject *tusowner) {
        
        NSError *error;
        [[BitsharesWalletObject BitsharesWalletObjectManager]importKey:[[PrivateKey alloc]initWithPrivateKey:[MoneyPacketManager moneyAcctountManager].priveKeyStr] forAccount:tusowner error:&error];
        
        [[BitsharesWalletObject BitsharesWalletObjectManager]getAsset:assid success:^(AssetObject *SEER) {
            
            [[BitsharesWalletObject BitsharesWalletObjectManager]roomActionFromAccount:tusowner baseAsset:SEER feePayingAsset:SEER room:[ObjectId generateFromObject:roomID] type:0 input:@[@(trnumber)] amount:putNumber success:^(SignedTransaction *signedTransaction) {
                
                [[BitsharesWalletObject BitsharesWalletObjectManager]listAccountBalance:tusowner success:^(NSArray<AssetAmountObject *> *amount) {
                    for (AssetAmountObject *amountObject in amount) {
                        if ([amountObject.assetId isEqual:@"1.3.0"]) {
                            [MoneyPacketManager moneyAcctountManager].surplus = amountObject.amount/100000.00;;
                        }else if ([amountObject.assetId isEqual:@"1.3.5"]){
                            [MoneyPacketManager moneyAcctountManager].usdt_surplus =amountObject.amount/100.00;
                        }
//                        else if([amountObject.assetId isEqual:@"1.3.2"]){
//                            [MoneyPacketManager moneyAcctountManager].pdfc_surplus =amountObject.amount/10000.00;
//                        }
                        
                    }
                } error:^(NSError *error) {
                    
                }];
                
                //取消loding
                [self.loadingView cancelView];
                
                QuizzesSucdViewController *vc = [[QuizzesSucdViewController alloc]init];
                
                if (self.preModel) {
                    vc.preModel = self.preModel;
                    vc.trNmber = idnexNmuber;
                    vc.chooseCount = self.trnNum;
                    
                }else if (self.orderM){
                    vc.orderM = self.orderM;
                    vc.trNmber = idnexNmuber;
                    vc.chooseCount =self.trnNum;
                }
                
                [self.navigationController pushViewController:vc animated:YES];
                
            } error:^(NSError *error) {
                [self.loadingView cancelView];
                if (error.code == 9) {
                    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Prompt",@"Internation", nil) message:NSLocalizedStringFromTable(@"Selling amount",@"Internation", nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"Buttonsure",@"Internation", nil) otherButtonTitles:nil];
                    [alert show];
                    return;
                }

                
            }];
            
        } error:^(NSError *error) {
            
        }];
        
        
    } error:^(NSError *error) {
        
    }];
    
}


-(void)selectedIndex:(NSInteger)index{
    
    //    self.trnNum = index;
//    NSLog(@"%ld",self.trnNum);
//
//    NSLog(@"%ld",index);
    
    passWordView *wordView = [[passWordView alloc]initWithTitleImage];
    
    NSString *roomID ;
    NSString *ass_id;
    if (self.preModel) {
        roomID = self.preModel.roomId;
        ass_id = self.preModel.ass_id;
    }
    else if (self.orderM){
        
        roomID = self.orderM.roomId;
        ass_id = self.orderM.ass_id;
        
        
    }
    
//    if ([ass_id isEqualToString:@"1.3.0"]) {
//        index = index *100000;
//    }else if ([ass_id isEqualToString:TextUSDT_room]){
//        index = index *100;
//    }
    
    
    //    __weak typeof(self) weakSelf = self;
    [wordView withSureClick:^(NSString *string) {
        [self puttool:ass_id withRoomId:roomID andIndexNumber:index andTrnumber:self.trnNum];
        
//        [[BitsharesWalletObject BitsharesWalletObjectManager] getAccount:M_userName success:^(AccountObject *tusowner) {
//
////            __weak typeof(self) weakSelf = self;
//            NSError *error;
//            [[BitsharesWalletObject BitsharesWalletObjectManager] importKey:[[PrivateKey alloc]
//                                                                             initWithPrivateKey:[MoneyPacketManager moneyAcctountManager].priveKeyStr]
//                                                                 forAccount:tusowner error:&error];
//
//            [[BitsharesWalletObject BitsharesWalletObjectManager] getAsset:ass_id success:^(AssetObject *SEER) {
//
//                [[BitsharesWalletObject BitsharesWalletObjectManager] roomActionFromAccount:tusowner baseAsset:SEER feePayingAsset:SEER room:[ObjectId generateFromObject:roomID] type:0 input:@[@(self.trnNum)] amount:index success:^(SignedTransaction *signedTransaction) {
//
//                    [[BitsharesWalletObject BitsharesWalletObjectManager] listAccountBalance:tusowner
//                                                                                     success:
//                     ^(NSArray<AssetAmountObject *> *amount){
//                         AssetAmountObject *amountObject = amount.firstObject;
//                         [MoneyPacketManager moneyAcctountManager].surplus =amountObject.amount/100000.00;
//
//                     } error:^(NSError *error) {
//
//                     }];
//
//
//                    //                        NSLog(@"成功");
//                    //                        QuizzesSucdViewController *vc = [[QuizzesSucdViewController alloc]init];
//                    //                        [self.navigationController pushViewController:vc animated:YES];
//                    //                    TextOrederViewController *orvc = [[TextOrederViewController alloc]init];
//                    //                    orvc.block = ^{
//                    //
//                    //                    };
//                    QuizzesSucdViewController *vc = [[QuizzesSucdViewController alloc]init];
//
//                    if (self.preModel) {
//                        vc.preModel = self.preModel;
//                        vc.trNmber = index;
//                        vc.chooseCount = self.trnNum;
//
//                    }else if (self.orderM){
//
//                        vc.orderM = self.orderM;
//                        vc.trNmber = index;
//                        vc.chooseCount =self.trnNum;
//
//                    }
//
//                    [self.navigationController pushViewController:vc animated:YES];
//
//                } error:^(NSError *error) {
//
//                    NSLog(@"失败");
//                    NSLog(@"这个error是多少%@",error);
//                    if (error.code == 9) {
//                        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Prompt",@"Internation", nil) message:NSLocalizedStringFromTable(@"Selling amount",@"Internation", nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"Buttonsure",@"Internation", nil) otherButtonTitles:nil];
//                        [alert show];
//                        return;
//                    }
//                    [[BitsharesWalletObject BitsharesWalletObjectManager] getAccount:M_userName success:^(AccountObject *tusowner) {
//                        //                        __weak typeof(self) weakSelf = self;
//
//                        NSError *error;
//                        [[BitsharesWalletObject BitsharesWalletObjectManager] importKey:[[PrivateKey alloc]
//                                                                                         initWithPrivateKey:[MoneyPacketManager moneyAcctountManager].ownpriveKeyStr]
//                                                                             forAccount:tusowner error:&error];
//
//                        [[BitsharesWalletObject BitsharesWalletObjectManager] getAsset:@"1.3.0" success:^(AssetObject *SEER) {
//
//                            [[BitsharesWalletObject BitsharesWalletObjectManager] roomActionFromAccount:tusowner baseAsset:SEER feePayingAsset:SEER room:[ObjectId generateFromObject:roomID] type:0 input:@[@(self.trnNum)] amount:index*100000 success:^(SignedTransaction *signedTransaction) {
//
//                                [[BitsharesWalletObject BitsharesWalletObjectManager] listAccountBalance:tusowner
//                                                                                                 success:
//                                 ^(NSArray<AssetAmountObject *> *amount){
//                                     AssetAmountObject *amountObject = amount.firstObject;
//                                     [MoneyPacketManager moneyAcctountManager].surplus =amountObject.amount/100000.00;
//
//                                 } error:^(NSError *error) {
//
//                                 }];
//
//
//                                //                        NSLog(@"成功");
//                                //                        QuizzesSucdViewController *vc = [[QuizzesSucdViewController alloc]init];
//                                //                        [self.navigationController pushViewController:vc animated:YES];
//                                //                    TextOrederViewController *orvc = [[TextOrederViewController alloc]init];
//                                //                    orvc.block = ^{
//                                //
//                                //                    };
//                                QuizzesSucdViewController *vc = [[QuizzesSucdViewController alloc]init];
//
//                                if (self.preModel) {
//                                    vc.preModel = self.preModel;
//                                    vc.trNmber = index;
//                                    vc.chooseCount = self.trnNum;
//
//                                }else if (self.orderM){
//
//                                    vc.orderM = self.orderM;
//                                    vc.trNmber = index;
//                                    vc.chooseCount =self.trnNum;
//
//                                }
//
//                                //                    self.block = ^{
//                                //
//                                //                    }
//
//                                [self.navigationController pushViewController:vc animated:YES];
//
//                            } error:^(NSError *error) {
//
//                                NSLog(@"失败");
//                                NSLog(@"这个error是多少%@",error);
//                                if (error.code == 9) {
//                                    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Prompt",@"Internation", nil) message:NSLocalizedStringFromTable(@"Selling amount",@"Internation", nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"Buttonsure",@"Internation", nil) otherButtonTitles:nil];
//                                    [alert show];
//                                    return;
//                                }
//
//                            }];
//
//                        } error:^(NSError *error) {
//
//
//                        }];
//
//
//
//
//                    } error:^(NSError *error) {
//
//                    }];
//
//
//
//
//
//                }];
//
//            } error:^(NSError *error) {
//
//
//            }];
//
//
//
//
//        } error:^(NSError *error) {
//
//        }];


        
    }];
    
}



@end

