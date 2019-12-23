//
//  BYBaseViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/11/21.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "BYBaseViewController.h"
#import "NumberLabel.h"
@interface BYBaseViewController ()
@property(nonatomic,strong) NumberLabel *dataLabel;
@end

@implementation BYBaseViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
//    {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView = [[JBMNavView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NAV_BAR_HEIGHT + STATUS_GAP)];
    [self.view addSubview:self.navView];
//    self.navView.lefBarButtonImage = [UIImage imageNamed:@"返回"];
//    [self.navView.leftBarButton addTarget:self action:@selector(poplastView) forControlEvents:UIControlEventTouchUpInside];
    
//    [[BitsharesWalletObject BitsharesWalletObjectManager] needConnect];
//
//    [BitsharesWalletObject BitsharesWalletObjectManager].connectStatusChange = ^(WebsocketConnectStatus status) {
//        NSLog(@"status change");
//        if (status ==WebsocketConnectStatusClosed) {
//            static dispatch_once_t disOnce;
//            dispatch_once(&disOnce,  ^ {
//                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Prompt",@"Internation", nil) message:NSLocalizedStringFromTable(@"Check the network",@"Internation", nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"Buttonsure",@"Internation", nil) otherButtonTitles:nil];
//                [alert show];
////                return;
//
//            });
//
//
//            [[BitsharesWalletObject BitsharesWalletObjectManager] needConnect];
//        }else if (status == WebsocketConnectStatusConnected) {
//
////            [self clicked];
//        }
//    };
//    
//        self.dataLabel = [[NumberLabel alloc]initWithFrame:CGRectMake(kScreenW/2, kScreenH/2, 70, 30)];
//        self.dataLabel.centerX = self.view.centerX;
//        self.dataLabel.backgroundColor = [UIColor blackColor];
//        self.dataLabel.textColor = [UIColor whiteColor];
//        self.dataLabel.layer.cornerRadius = 10;
//        self.dataLabel.hidden = YES;
//        [[UIApplication sharedApplication].keyWindow addSubview:self.dataLabel];
//    [BitsharesWalletObject BitsharesWalletObjectManager].connectStatusChange = ^(WebsocketConnectStatus status) {
//        NSLog(@"status change");
//        if (status ==WebsocketConnectStatusClosed) {
//                             self.dataLabel.hidden = NO;
//            [[BitsharesWalletObject BitsharesWalletObjectManager] needConnect];
//            
//        }else if (status == WebsocketConnectStatusConnected) {
//                            self.dataLabel.hidden = YES;
////            [self clicked];
//        }
//    };
//    
    
    
}

-(void)poplastView{
    
    [self.navigationController popViewControllerAnimated:YES];
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
