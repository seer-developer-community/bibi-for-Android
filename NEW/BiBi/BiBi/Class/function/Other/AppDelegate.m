//
//  AppDelegate.m
//  BiBi
//
//  Created by 武建斌 on 2018/11/16.
//  Copyright © 2018年 武建斌. All rights reserved.
//

#import "AppDelegate.h"
#import "MSLaunchView.h"
#import "JBMTabBarController.h"
#import "JBProtocol.h"
#import "MoneyPacketManager.h"
#import "BitsharesWalletObject.h"
#import "HcdGuideView.h"
#import "CZGuideCollectionController.h"
#import "Reachability.h"

#define MSScreenW   [UIScreen mainScreen].bounds.size.width
#define MSScreenH   [UIScreen mainScreen].bounds.size.height
@interface AppDelegate (){
    
    MSLaunchView *_launchView;
    
}

@property (nonatomic,strong) BitsharesWalletObject *wallet;

@property (nonatomic,assign) BOOL connected;

@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//     [NSURLProtocol registerClass:[JBProtocol class]];
//    [[BitsharesWalletObject BitsharesWalletObjectManager] needConnect];
//    [BitsharesWalletObject BitsharesWalletObjectManager].connectStatusChange = ^(WebsocketConnectStatus status) {
//        self.connected = status == WebsocketConnectStatusConnected;
//        NSLog(@"status change");
//        if (status ==WebsocketConnectStatusClosed) {
//
//            [[BitsharesWalletObject BitsharesWalletObjectManager] needConnect];
//        }
//    };
//
   

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [UIColor whiteColor];
//    JBMTabBarController *vc = [[JBMTabBarController alloc] init];
//    vc.view.backgroundColor = [UIColor whiteColor];
//    self.window.rootViewController = vc;
    [self checkGuide];
    [self.window makeKeyAndVisible];
    
    
//    NSMutableArray *images = [NSMutableArray new];
//    [images addObject:[UIImage imageNamed:@"Guide1"]];
//    [images addObject:[UIImage imageNamed:@"Guide2"]];
//    [images addObject:[UIImage imageNamed:@"Guide3"]];
//    HcdGuideView *guideView = [HcdGuideView sharedInstance];
//    guideView.window = self.window;
//    [guideView showGuideViewWithImages:images
//                        andButtonTitle:@"立即体验"
//                   andButtonTitleColor:[UIColor whiteColor]
//                      andButtonBGColor:[UIColor blueColor]
//                  andButtonBorderColor:[UIColor whiteColor]];
    
    [[BitsharesWalletObject BitsharesWalletObjectManager] needConnect];

    [BitsharesWalletObject BitsharesWalletObjectManager].connectStatusChange = ^(WebsocketConnectStatus status) {

        self.connected = status == WebsocketConnectStatusConnected;
        //        if (self.connected ) {
        //             [self clicked];
        //        }
        NSLog(@"status change");
        if (status ==WebsocketConnectStatusClosed) {
           
            [[BitsharesWalletObject BitsharesWalletObjectManager] needConnect];
     

        }
    };
    
    


    [[MoneyPacketManager moneyAcctountManager] getUserData];
    //tabbar 页面向左上方向刷新
    [[UITabBar appearance] setTranslucent:NO];
    
    
//    __weak typeof(self) weakSelf = self;
//    [BitsharesWalletObject BitsharesWalletObjectManager].connectStatusChange = ^(WebsocketConnectStatus status) {
//        weakSelf.connected = status == WebsocketConnectStatusConnected;
//        NSLog(@"status change");
//    };
//    [self needConnect];
    
//        _wallet = [[BitsharesWalletObject alloc]initWithChainId:@"cea4fdf4f5c2278f139b22e782b308928f04008b0fc2c79970a58974a2a28f91" prefix:@"SEER"];
    
//           __weak typeof(self) weakSelf = self;
//        _wallet.connectStatusChange = ^(WebsocketConnectStatus status) {
//            weakSelf.connected = status == WebsocketConnectStatusConnected;
//            NSLog(@"status change");
//
//        };

    return YES;
}


- (void)checkGuide
{
    //版本号 新特性界面 是否应该加载
    
    //1.获取你app的版本号
    NSString *locaVerson = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    //2.获取 你保存在沙盒中的版本号
    
    NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
    NSString *saveVersion = [defauts objectForKey:@"saveVerion"];
    
    
    //3.判断  只要是不一致 就加载 新特性界面
    if([saveVersion isEqualToString:locaVerson]){//两者一致
        
        //2.创建TabBarVc
        JBMTabBarController *vc = [[JBMTabBarController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        self.window.rootViewController = vc;
    }else{//加载的新特性
        
        //       1.把最新的版本号保存下来
        
        
        [defauts setObject:locaVerson forKey:@"saveVerion"];
        
        [defauts synchronize];
        
        //2.加载新特性界面
        CZGuideCollectionController *guideVc = [[CZGuideCollectionController alloc]init];
        
        self.window.rootViewController = guideVc;
        
        
        
    }
    
    
    
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [self needConnect];
//    
//    __weak typeof(self) weakSelf = self;
//    
//    _wallet.connectStatusChange = ^(WebsocketConnectStatus status) {
//        weakSelf.connected = status == WebsocketConnectStatusConnected;
//        NSLog(@"status change");
//    };
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    _wallet = [[BitsharesWalletObject alloc]initWithChainId:@"cea4fdf4f5c2278f139b22e782b308928f04008b0fc2c79970a58974a2a28f91" prefix:@"SEER"];
//       [self needConnect];
//       __weak typeof(self) weakSelf = self;
//    _wallet.connectStatusChange = ^(WebsocketConnectStatus status) {
//        weakSelf.connected = status == WebsocketConnectStatusConnected;
//        NSLog(@"status change");
//
//    };
    
    
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[url scheme] isEqualToString:@"h5bibitrans"]) {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor whiteColor];
        JBMTabBarController *vc = [[JBMTabBarController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        self.window.rootViewController = vc;
        [self.window makeKeyAndVisible];
    }
    return YES;
}




//-(void)listenNetWorkingStatus{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
//    // 设置网络检测的站点
//    NSString *remoteHostName = @"www.apple.com";
//    
//    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
//    [self.hostReachability startNotifier];
//    [self updateInterfaceWithReachability:self.hostReachability];
//    
//    self.internetReachability = [Reachability reachabilityForInternetConnection];
//    [self.internetReachability startNotifier];
//    [self updateInterfaceWithReachability:self.internetReachability];
//}
//
//- (void) reachabilityChanged:(NSNotification *)note
//{
//    Reachability* curReach = [note object];
//    [self updateInterfaceWithReachability:curReach];
//}
//
//- (void)updateInterfaceWithReachability:(Reachability *)reachability
//{
//    
//    NetworkStatus netStatus = [reachability currentReachabilityStatus];
//    switch (netStatus) {
//        case 0:
//            NSLog(@"NotReachable----无网络");
//            break;
//            
//        case 1:
//            NSLog(@"ReachableViaWiFi----WIFI");
//            break;
//            
//        case 2:
//            NSLog(@"ReachableViaWWAN----蜂窝网络");
//            break;
//            
//        default:
//            break;
//    }
//    
//}



@end
