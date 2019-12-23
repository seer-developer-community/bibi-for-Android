//
//  LangueViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/17.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "LangueViewController.h"
#import "AppDelegate.h"
#import "SwichLanguage.h"
#import "JBMTabBarController.h"
#import "DAConfig.h"
#import "NSBundle+DAUtils.h"
#import "LanguageLoadingView.h"
@interface LangueViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *langueTableView;
@property(nonatomic,strong)NSArray *laguageArry;
@property(nonatomic,strong)LanguageLoadingView *languageView;
@end

@implementation LangueViewController



- (void)viewDidLoad {
    [super viewDidLoad];

   
    [self setTopView];
    
    [self.view addSubview:self.langueTableView];
}


-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    
    self.navigationController.navigationBarHidden = YES;
    self.laguageArry = @[NSLocalizedStringFromTable(@"System Default",@"Internation", nil),NSLocalizedStringFromTable(@"Chinese Simplified",@"Internation", nil),@"English"];
    self.navView.title = NSLocalizedStringFromTable(@"Language",@"Internation", nil);
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
}


-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(UITableView *)langueTableView{
    
    if (!_langueTableView) {
        
        _langueTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, self.navView.bottom, kScreenW, kScreenH - self.navView.height) style:UITableViewStyleGrouped];
        _langueTableView.delegate = self;
        _langueTableView.dataSource =self;
        
        _langueTableView.separatorStyle =   UITableViewCellSeparatorStyleSingleLine;
        
         _langueTableView.backgroundColor = UIColorFromHexValue(0xf4f6fd);
        
    }
    
    
    return _langueTableView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellindex = @"cellindex";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellindex];
  
//    NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:0];
//    [self tableView:self.langueTableView didSelectRowAtIndexPath:path];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellindex];
        if (![DAConfig userLanguage].length) {
            cell.accessoryType = indexPath.row == 0 ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        } else {
            if ([NSBundle isChineseLanguage]) {
                if (indexPath.row == 1) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            } else {
                if (indexPath.row == 2) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
        }
//        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
//        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.laguageArry[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7];
    cell.textLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    
    
    return cell;
    
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//
////    if (indexPath.row == 0) {
////
//////        LangueViewController *vc = [[LangueViewController alloc]init];
//////
//////        [self.navigationController pushViewController:vc animated:YES];
////        NSString *language = [SwichLanguage userLanguage];
////
////        if (![language isEqualToString:@"en"]) {
////
////
////
////            [SwichLanguage setUserlanguage:@"zh-Hans"];
////
////
////
////        }else{
////
////
////
////            [SwichLanguage setUserlanguage:@"en"];
////
////
////
////        }
////
////
////    }
////
//    [self resetRootViewController];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        return;
    }
    for (UITableViewCell *acell in tableView.visibleCells) {
        acell.accessoryType = acell == cell ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    if (indexPath.row == 0) {
        [DAConfig setUserLanguage:nil];
    } else if (indexPath.row == 1) {
        [DAConfig setUserLanguage:@"zh-Hans"];
        self.languageView = [[LanguageLoadingView alloc]init];
        [self.languageView showLoadingView];
    } else {
        [DAConfig setUserLanguage:@"en"];
        self.languageView = [[LanguageLoadingView alloc]init];
        [self.languageView showLoadingView];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.languageView cancelView];
        [self resetRootViewController];
    });
    
    
}




//重新设置
-(void)resetRootViewController
{
    
//    UITabBarController * rootVc = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
//    rootVc.selectedIndex = 0;
//    [self.navigationController popToRootViewControllerAnimated:NO];
                   self.tabBarController.viewControllers = nil;
//        [[BitsharesWalletObject BitsharesWalletObjectManager] attemptDealloc];
    // 这个是跳转到对应的哪个tabbar
//        [[BitsharesWalletObject BitsharesWalletObjectManager] needConnect];
                  self.tabBarController.viewControllers = [((JBMTabBarController *)self.tabBarController) getTabRootViewController];
                    JBMTabBarController *vc = [[JBMTabBarController alloc] init];
                    vc.view.backgroundColor = [UIColor whiteColor];
    
                    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    [BitsharesWalletObject BitsharesWalletObjectManager].Click = YES;
                    vc.view.backgroundColor = [UIColor whiteColor];
    

    
    
}


@end
