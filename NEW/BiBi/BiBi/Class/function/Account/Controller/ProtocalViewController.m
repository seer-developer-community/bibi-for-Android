//
//  ProtocalViewController.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/10.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "ProtocalViewController.h"

@interface ProtocalViewController ()

@end

@implementation ProtocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTopView];
    
}


-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    
    self.navigationController.navigationBarHidden = YES;
    self.navView.title = @"用户协议";
    //    self.navView.backgroundColor = [UIColor redColor];
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick)
                         forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
    
    [self setupUI];
}


-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)setupUI{
    UIWebView *web=[[UIWebView alloc]initWithFrame:CGRectMake(0, self.navView.bottom, kScreenW, kScreenH-self.navView.height)];
//    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"backGroundColor"]];
    [self.view addSubview:web];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"user" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [web loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    
    
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
