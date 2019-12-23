//
//  OrederViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/11/21.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "OrederViewController.h"
#import "UploadParams.h"
#import "UploadBaseModel.h"
#import "CallBackModel.h"
#import "BitsharesWalletObject.h"
#import "UploadBaseModel.h"
#import "RoomAccount.h"
#import "ObjectId.h"
@interface OrederViewController ()

@property (nonatomic,strong) BitsharesWalletObject *wallet;

@property (nonatomic,assign) BOOL connected;

@end

@implementation OrederViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    _wallet = [[BitsharesWalletObject alloc]initWithChainId:@"cea4fdf4f5c2278f139b22e782b308928f04008b0fc2c79970a58974a2a28f91" prefix:@"SEER"];
    
    [self needConnect];
    
    __weak typeof(self) weakSelf = self;
    
    _wallet.connectStatusChange = ^(WebsocketConnectStatus status) {
        weakSelf.connected = status == WebsocketConnectStatusConnected;
        NSLog(@"status change");
    };
    
    
    UIButton *button = [[UIButton alloc]init];

    button.frame = CGRectMake(50, 100, 50, 50);

    button.backgroundColor = [UIColor yellowColor];

    [button setTitle:@"点击" forState:UIControlStateNormal];

    [self.view addSubview:button];

    [button addTarget:self action:@selector(testFunction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 阻塞当前方法，使方法进入等待
        while (!self.connected) {}
        // 当连接成功后发送消息
//        [self testFunction];
    });
    
}

- (void)needConnect {
    [_wallet connectUrl:@"ws://39.105.189.224/ws" timeOut:10 connectedError:^(NSError *error) {
        [self needConnect];
    }];
}


-(void)clicked{
//    if (_connected) {

//
//    }
//
    
    
//    [self.wallet getPlatform:@"get_houses" unploadParamsTotalParams:@[@"1.14.5",@"1.14.3",@"1.14.4"] success:^(PlatAccount* result) {
//
//        NSLog(@"---%@-----",result.owner);
//
//    } error:^(NSError *error) {
//
//    }];
    
//    [self testFunction];
}




- (void)testFunction {
    [self.wallet getSeerRoom:@"get_seer_room" fristString:@"1.15.861" nLimint:1 secondInt:100 success:^(RoomAccount *result) {
        
        
          NSLog(@"^^^%@^^^^",result.identifier);
    } error:^(NSError *error) {
        
    }];
    
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
