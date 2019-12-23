//
//  HomeViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/11/21.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "HomeViewController.h"
#import "WebsocketClient.h"
#import "UploadParams.h"
#import "UploadBaseModel.h"
#import "CallBackModel.h"
#import "SRWebSocket.h"
#import "BitsharesWalletObject.h"
#import "WebSocketNetwork.h"
#import "BaseConfig.h"
#import "BitsharesWallet.h"
#import "PrivateKey.h"
#import "PublicKey.h"
@interface HomeViewController ()

@property (nonatomic,strong) BitsharesWalletObject *wallet;

@property (nonatomic,assign) BOOL connected;

@property(nonatomic,strong)AccountObject *fromAccount;

@property(nonatomic,strong)AccountObject *toAccount;

@property(nonatomic,strong)AssetAmountObject *assetAmount;

@property(nonatomic,strong)AssetObject *feePayingAsset;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [BaseConfig setPrefix:@"SEER"];
    
    _wallet = [[BitsharesWalletObject alloc]initWithChainId:@"cea4fdf4f5c2278f139b22e782b308928f04008b0fc2c79970a58974a2a28f91" prefix:@"SEER"];
    
    [self needConnect];
    
    __weak typeof(self) weakSelf = self;
    
    _wallet.connectStatusChange = ^(WebsocketConnectStatus status) {
        weakSelf.connected = status == WebsocketConnectStatusConnected;
        NSLog(@"status change");
    };
    
    
    UIButton *button = [[UIButton alloc]init];
    
    button.frame = CGRectMake(50, 100, 50, 50);
    
    button.backgroundColor = [UIColor redColor];
    
    [button setTitle:@"点击" forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(dianji) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *button1 = [[UIButton alloc]init];
    
    button1.frame = CGRectMake(200, 100, 50, 50);
    
    button1.backgroundColor = [UIColor yellowColor];
    
    [button1 setTitle:@"点击" forState:UIControlStateNormal];
    
    [self.view addSubview:button1];
    
    [button1 addTarget:self action:@selector(testFunction) forControlEvents:UIControlEventTouchUpInside];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 阻塞当前方法，使方法进入等待
        while (!self.connected) {}
        // 当连接成功后发送消息
        [self testFunction];
    });
    
    
    
    
    
}


- (void)needConnect {
    
    [_wallet connectUrl:@"ws://39.105.189.224/ws" timeOut:10 connectedError:^(NSError *error) {
        [self needConnect];
        
    }];
}






//投注

-(void)dianjiw
{
    
    [_wallet getAccount:@"hairong001" success:^(AccountObject *tusowner) {
        __weak typeof(self) weakSelf = self;
        
        self.fromAccount = tusowner;
        
        BrainKey *brainkey = [[BrainKey alloc]init];

        brainkey= [weakSelf.wallet deriveKeyWithBrainKey:@"JHOW BALLOT CALLOUS HEADCAP AMNESIC TARSIER HELLUO SEEKER OPERAE CURLIKE PUTT HOOPOE RUSPONE JARRA ODORANT ACEPHAL"];

        
        NSString *str = [NSString stringWithFormat:@"%@",brainkey.priKey];
        NSLog(@"这个值是多少%@",str);
        NSError * error;
        [weakSelf.wallet importKey:[[PrivateKey alloc] initWithPrivateKey:str]forAccount:tusowner error:&error];
        [weakSelf.wallet getAsset:@"1.3.0" success:^(AssetObject *SEER) {
            [weakSelf.wallet roomActionFromAccount:tusowner baseAsset:SEER feePayingAsset:SEER room:[ObjectId generateFromObject:@"1.15.604"] type:0 input:@[@0] amount:500000 success:^(SignedTransaction *signedTransaction) {
                
            } error:^(NSError *err) {
                NSLog(@"这个崩溃是什么%@",err);
            }];
            
        } error:^(NSError *error) {
            NSLog(@"getAsset%@",error);
        }];
        
        
    } error:^(NSError *error) {
        NSLog(@"错误是多少%@",error);
        
    }];

    
    
    
}


-(void)dianji{
    
    NSString *str1 = @"wonky chevin pasquin paisa fondant aerobus dryadic gercrow torulus kidsman uramil enlodge miscoin ouenite tessara awreck";
    BrainKey *brainkey = [[BrainKey alloc]init];
    
    brainkey= [self.wallet deriveKeyWithBrainKey:str1];
    NSString *str = [NSString stringWithFormat:@"%@",brainkey.pubKey ];
    
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    uploadParams.methodName = @"get_key_references";
    
    uploadParams.totalParams = @[@[str]];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSDictionary * result) {
        NSLog(@"%@",result);
    };
    
    
     [_wallet sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
    
}




//// 转账
//-(void)dianji{
//
//    [_wallet getAccount:@"yansongchengt679" success:^(AccountObject *tusowner) {
//          __weak typeof(self) weakSelf = self;
//
//        self.fromAccount = tusowner;
//
//        BrainKey *brainkey = [[BrainKey alloc]init];
//
//        brainkey= [weakSelf.wallet deriveKeyWithBrainKey:@"DURIAN SIRREE VIREMIC FLUTING WORDED NICHE AW TORCH SAGATHY PHOCA SCABBY TOGUE JUDO FINNED CADDOW WAGGLE"];
//
//
//        NSString *str = [NSString stringWithFormat:@"%@",brainkey.priKey];
////        5JxSyAbzpTzjF2vnuFLSNnANNksarqL4N1uG7hbwHDLtryVVSz3
////        5JxSyAbzpTzjF2vnuFLSNnANNksarqL4N1uG7hbwHDLtryVVSz3
//        NSLog(@"这个值是多少%@",str);
//
//        NSError * error;
//
//        [weakSelf.wallet importKey:[[PrivateKey alloc] initWithPrivateKey:@"5JxSyAbzpTzjF2vnuFLSNnANNksarqL4N1uG7hbwHDLtryVVSz3"]forAccount:tusowner error:&error];
//
//        [ weakSelf.wallet getAccount:@"yansongbin23" success:^(AccountObject *tusowner1) {
//
//            NSLog(@"toAccount是多少%@",tusowner1.name);
//
//            self.toAccount = tusowner1;
//
//            [weakSelf.wallet getAsset:@"1.3.0" success:^(AssetObject *SEER) {
//
//                [weakSelf.wallet transferFromAccount:tusowner toAccount:tusowner1 assetAmount:[SEER getAmountFromNormalFloatString:@"1"] memo:@"" feePayingAsset:SEER success:^(SignedTransaction *signedTransaction) {
//                    NSLog(@"转账成功");
//                } error:^(NSError *error) {
//
//                }];
//
//
////                [weakSelf.wallet transferFromAccount1:self.fromAccount toAccount:@"1.15.602" assetAmount:[SEER getAmountFromNormalFloatString:@"1"] memo:@"" feePayingAsset:SEER success:^(SignedTransaction *signedTransaction) {
////                    NSLog(@"转账成功");
////                    NSLog(@"转账的功能%@",signedTransaction);
////                } error:^(NSError *error) {
////                    NSLog(@"----失败-----");
////                    NSLog(@"这个失败的%@",error);
////                }];
//
//
//
//            } error:^(NSError *error) {
//                NSLog(@"getAsset%@",error);
//            }];
//
//        } error:^(NSError *error) {
//
//            NSLog(@"toAccount是错误多少%@",error);
//
//        }];
//
//
//    } error:^(NSError *error) {
//        NSLog(@"错误是多少%@",error);
//
//    }];
//
//}

- (void)testFunction {
    
    
//    BrainKey *brainkey = [[BrainKey alloc]init];
//
//    brainkey= [self.wallet deriveKeyWithBrainKey:@"wonky chevin pasquin paisa fondant aerobus dryadic gercrow torulus kidsman uramil enlodge miscoin ouenite tessara awreck"];
//
////    [brainkey.pubKey initWithAllPubkeyString:brainkey.pubKey];
//
//    NSString *str = [NSString stringWithFormat:@"%@",brainkey.pubKey ];
    
        UploadParams *uploadParams = [[UploadParams alloc] init];
    
        uploadParams.methodName = @"get_account_history";
    
    uploadParams.totalParams = @[@"1.2.16371",@"1.9.0",@(100),@"1.9.0"];
    
        CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
        callBackModel.successResult = ^(NSDictionary * result) {
            NSLog(@"%@",result);
        };
    
        [_wallet sendWithChainApi:(WebsocketBlockChainApiHistory) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
    
    
    
    


    
}


@end

