//
//  BYBaseNavigationController.m
//  BiBi
//
//  Created by 武建斌 on 2018/11/21.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "BYBaseNavigationController.h"

@interface BYBaseNavigationController ()

@end

@implementation BYBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed =  self.viewControllers.count > 0 ? YES : NO;
    [super pushViewController:viewController animated:animated];
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
