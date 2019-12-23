




//
//  BaseTabBar.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/1.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "BaseTabBar.h"
#import "CreateWalletViewController.h"

@implementation BaseTabBar

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.delegate = self;
//    }
//    return self;
//}

//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    if ([tabBar.items indexOfObject:item] && ![MoneyPacketManager moneyAcctountManager].isLogin) {
//        UITabBarController * rootVc = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
//        UINavigationController * firstNa =  [rootVc.viewControllers objectAtIndex:0];
//        CreateWalletViewController * create = [[CreateWalletViewController alloc] init];
//        [firstNa pushViewController:create animated:YES];
//    }
//}


//- (void)setSelectedItem:(UITabBarItem *)selectedItem {
//
//    NSInteger index = [self.items indexOfObject:selectedItem];
//    if ([MoneyPacketManager moneyAcctountManager].isLogin || !index) {
//
//        [super setSelectedItem:selectedItem];
//    }else {
//        UITabBarController * rootVc = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
//        UINavigationController * firstNa =  [rootVc.viewControllers objectAtIndex:0];
//        [firstNa pushViewController:[[CreateWalletViewController alloc] init] animated:YES];
//    }
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
