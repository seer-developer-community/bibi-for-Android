//
//  JBMTabBarController.m
//  BiBi
//
//  Created by 武建斌 on 2018/11/21.
//  Copyright © 2018 武建斌. All rights reserved.
//


//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                           O\  =  /O
//                        ____/`---'\____
//                      .'  \\|     |//  `.
//                     /  \\|||  :  |||//  \
//                    /  _||||| -:- |||||-  \
//                    |   | \\\  -  /// |   |
//                    | \_|  ''\---/''  |   |
//                    \  .-\__  `-`  ___/-. /
//                   ___`. .'  /--.--\  `. . __
//                ."" '<  `.___\_<|>_/___.'  >'"".
//              | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//              \  \ `-.   \_ __\ /__ _/   .-` /  /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

#import "JBMTabBarController.h"
#import "BYBaseNavigationController.h"
#import "CreateWalletViewController.h"
#import "BaseTabBar.h"
@interface JBMTabBarController ()<UITabBarControllerDelegate>

@end

@implementation JBMTabBarController







- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setViewControllers:[self getTabRootViewController]];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification1) name:@"wujianbin" object:nil];
}

//TextHomeViewController
- (NSArray*)getTabRootViewController {
    NSArray * vcNameArray = @[@"TextHomeViewController",@"NewOrderViewController",@"AccountViewController",@"TestMineViewController"];
//    "home"=@"HOME"
//    "order" = @"Orders";
//    "Balance" =@"Balance";
//    "Profile" = @"Profile";
//    "home" ="首页"
//    "order" = @"订单";
//    "Balance" =@"账户";
//    "Profile" = @"我的";
    NSString *homeStr= NSLocalizedStringFromTable(@"home",@"Internation", nil);
    NSString *orderStr= NSLocalizedStringFromTable(@"order",@"Internation", nil);
    NSString *BalanceStr= NSLocalizedStringFromTable(@"Balance",@"Internation", nil);
    NSString *ProfileStr=NSLocalizedStringFromTable(@"Profile",@"Internation", nil);

    NSArray * titleArray = @[homeStr,orderStr,BalanceStr,ProfileStr];
    NSArray * normalArray = @[@"home_N",@"order_N",@"wallet_N",@"Mine_N"];
    NSArray * selectedArray = @[@"home_S",@"order_S",@"wallet_S",@"Mine_S"];
    NSMutableArray * mnVC = [NSMutableArray array];
    [vcNameArray enumerateObjectsUsingBlock:^(NSString * vcName, NSUInteger idx, BOOL * _Nonnull stop) {
        Class vcClass = NSClassFromString(vcName);
        BYBaseNavigationController * ysvc = [[BYBaseNavigationController alloc] initWithRootViewController:[vcClass class].new];
        ysvc.tabBarItem.title = titleArray[idx];
        ysvc.tabBarItem.image = [UIImage imageNamed:normalArray[idx]];
        ysvc.tabBarItem.selectedImage = [UIImage imageNamed:selectedArray[idx]];
        [mnVC addObject:ysvc];
    }];
    return mnVC;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController  {
    BOOL isOk = YES;
    if ([self.viewControllers indexOfObject:viewController] && ![MoneyPacketManager moneyAcctountManager].isLogin) {
        isOk = NO;
            UINavigationController * firstNa =  [self.viewControllers objectAtIndex:0];
            [firstNa pushViewController:[[CreateWalletViewController alloc] init] animated:YES];
    }

    return isOk;
 
//
//    if ([viewController.tabBarItem.title isEqualToString:@"我的"]||[viewController.tabBarItem.title isEqualToString:@"订单"]||[viewController.tabBarItem.title isEqualToString:@"账户"]) {
//        //如果用户ID存在的话，说明已登陆
//        if ([MoneyPacketManager moneyAcctountManager].isLogin) {
//            return YES;
//        }
//        else
//        {
//            //跳到登录页面
//            CreateWalletViewController *login = [[CreateWalletViewController alloc] init];
//            //隐藏tabbar
//            login.hidesBottomBarWhenPushed = YES;
//            [((UINavigationController *)tabBarController.selectedViewController) pushViewController:login animated:YES];
//
//            return NO;
//        }
//    }
//    else
//        return YES;
//

  
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

////实现方法
//-(void)notification1{
//    NSLog(@"接收 不带参数的消息");
//}

@end
