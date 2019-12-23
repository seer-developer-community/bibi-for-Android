//
//  RechargeViewController.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/14.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "RechargeViewController.h"
#import "WuLoadingView.h"
#import "WINCopyLabel.h"
@interface RechargeViewController ()

@property(nonatomic,strong)NSString *eth_addressStr;

@property(nonatomic,strong)UILabel *eth_addressLabel;

@property(nonatomic,strong)WuLoadingView *loadingView;

@property(nonatomic,strong)UIButton *address_button;
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WuLoadingView *loadingView = [[WuLoadingView alloc]init];
    self.loadingView = loadingView;
    [loadingView showLoadingView];
    [self logningfuncktext];
    [self setupUI];
    [self setTopView];
   
    
}

//查询id
-(void)logningfuncktext{
    [[BitsharesWalletObject BitsharesWalletObjectManager]getAccount:M_userName success:^(AccountObject *result) {
        [MoneyPacketManager moneyAcctountManager].identifier = [NSString stringWithFormat:@"%@",result.identifier];
    } error:^(NSError *error) {
        
    }];
    
}

-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    self.navigationController.navigationBarHidden = YES;
    self.navView.title = NSLocalizedStringFromTable(@"Recharge",@"Internation", nil);
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick)
                         forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
    
    
    if ([self.recharge_model.ass_id isEqualToString:@"1.3.5"]) {
        [self getUsdt];
    }else{
        [self get];
    }
    
  
}


-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}






- (void)get {
    NSString *seer_acccount_id = [MoneyPacketManager moneyAcctountManager].identifier;
//    NSString *seer_acccount_name = [MoneyPacketManager moneyAcctountManager].userName;
    NSString *strUrl = [NSString stringWithFormat:@"https://www.seerapi.com/api/v1/seer_eth/query?seer_account_id=%@",seer_acccount_id];
    
    // 对汉字进行转义
    strUrl = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"%@", strUrl);
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
         
         if (connectionError) {
             
             [self.loadingView cancelView];
             NSLog(@"连接错误 %@", connectionError);
             return;
         }
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
         if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304) {
             // 解析数据
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             NSLog(@"%@",[[dict valueForKey:@"data"] valueForKey:@"eth_address"]);
             self.eth_addressStr = [[dict valueForKey:@"data"] valueForKey:@"eth_address"];
             if (self.eth_addressStr) {
                 [self.loadingView cancelView];
                 
                 [self revolution];
             }else{
                  [self postUrl];
                 
             }
         } else {
             
             [self.loadingView cancelView];
             NSLog(@"服务器内部错误");
         }
     }];
}




- (void)getUsdt{
    NSString *seer_acccount_id = [MoneyPacketManager moneyAcctountManager].identifier;
    //    NSString *seer_acccount_name = [MoneyPacketManager moneyAcctountManager].userName;
    NSString *strUrl = [NSString stringWithFormat:@"https://www.seerapi.com/api/v1/seer_omni/query?seer_account_id=%@",seer_acccount_id];
    
    // 对汉字进行转义
    strUrl = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"%@", strUrl);
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
         if (connectionError) {
             NSLog(@"连接错误 %@", connectionError);
             [self.loadingView cancelView];
             return;
         }
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
         if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304) {
             // 解析数据
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             NSLog(@"%@",[[dict valueForKey:@"data"] valueForKey:@"omni_address"]);
             self.eth_addressStr = [[dict valueForKey:@"data"] valueForKey:@"omni_address"];
             if (self.eth_addressStr) {
                 [self.loadingView cancelView];
                 
                 [self revolution];
             }else{
                [self SeerOmniURL];
             }
            
         } else {
             [self.loadingView cancelView];
             NSLog(@"服务器内部错误");
         }
     }];
}

//绑定ETC
-(void)postUrl{
    
    NSString *urlString =@"https://www.seerapi.com/api/v1/seer_eth/bind";
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"测试的这个ID是多少%@",[MoneyPacketManager moneyAcctountManager].identifier);
    
    //2. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //2.1设置请求方法
    request.HTTPMethod = @"POST";
    NSData *data = [NSJSONSerialization dataWithJSONObject: @{
                                                              @"seer_account_id":[MoneyPacketManager moneyAcctountManager].identifier,
                                                              @"seer_account_name":M_userName
                                                              }
                                                   options:NSJSONWritingPrettyPrinted error:nil];
    //
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    
    //    Prompt" = "提示";
    //    "Only one user" ="五分钟之内只允许注册一位用户";
    //    "Bound ETH address failed" = "绑定ETH地址失败";
    request.HTTPBody = data;
    
    //3.建立连接发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        
        if(connectionError) {
            
            NSLog(@"这个是错误");
            
        }else {
            
            //4. 解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            NSString * errorMsg = [dict objectForKey:@"error"];
            NSLog(@"这个字典是多少%@",dict);
            if (errorMsg) {
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Prompt",@"Internation", nil) message:NSLocalizedStringFromTable(@"Bound ETH address failed",@"Internation", nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"BUttonsure",@"Internation", nil) otherButtonTitles:nil];
                //新加代码
                [[MoneyPacketManager moneyAcctountManager]logout];
                [self.loadingView cancelView];
                [alert show];
                return;
            }
            
            [self get];
        }
        
    }];
    
    
}

//绑定BTC
-(void)SeerOmniURL{
    
    NSString *urlString =@"https://www.seerapi.com/api/v1/seer_omni/bind";
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"测试的这个ID是多少%@",[MoneyPacketManager moneyAcctountManager].identifier);
    
    //2. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //2.1设置请求方法
    request.HTTPMethod = @"POST";
    NSData *data = [NSJSONSerialization dataWithJSONObject: @{
                                                              @"seer_account_id":[MoneyPacketManager moneyAcctountManager].identifier,
                                                              @"seer_account_name":M_userName
                                                              }
                                                   options:NSJSONWritingPrettyPrinted error:nil];
    //
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    
    //    Prompt" = "提示";
    //    "Only one user" ="五分钟之内只允许注册一位用户";
    //    "Bound ETH address failed" = "绑定ETH地址失败";
    request.HTTPBody = data;
    
    //3.建立连接发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if(connectionError) {
            
            NSLog(@"这个是错误");
            
        }else {
            
            //4. 解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            NSString * errorMsg = [dict objectForKey:@"error"];
            NSLog(@"这个字典是多少%@",dict);
            if (errorMsg) {
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Prompt",@"Internation", nil) message:NSLocalizedStringFromTable(@"Bound ETH address failed",@"Internation", nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"BUttonsure",@"Internation", nil) otherButtonTitles:nil];
                //新加代码
                [[MoneyPacketManager moneyAcctountManager]logout];
                [self.loadingView cancelView];
                [alert show];
                return;
            }
            
            [self getUsdt];
        }
        
    }];
}


-(void)clickaddress:(UIButton *)sender{
        if ([self.recharge_model.ass_id isEqualToString:@"1.3.5"]) {
            [self getUsdt];
        }else{
            [self get];
        }
    
}

//UI编辑

-(void)setupUI{
    UILabel *label1 = [[UILabel alloc]init];
    label1.text =NSLocalizedStringFromTable(@"How are the tokens",@"Internation", nil);
    label1.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.navView.mas_bottom).offset(10);
    }];
    
    UILabel *label2 = [[UILabel alloc]init];
    if ([self.recharge_model.ass_id isEqualToString:@"1.3.0"]) {
       label2.text =NSLocalizedStringFromTable(@"The exchanges",@"Internation", nil);
    }else if ([self.recharge_model.ass_id isEqualToString:@"1.3.2"]){
         label2.text =NSLocalizedStringFromTable(@"The PFCexchanges",@"Internation", nil);
    }else{
         label2.text =NSLocalizedStringFromTable(@"The USDTexchanges",@"Internation", nil);
    }
//    label2.text =NSLocalizedStringFromTable(@"The exchanges",@"Internation", nil);
    label2.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_left);
        make.top.mas_equalTo(label1.mas_bottom).offset(10);
    }];
    
    UILabel *label3 = [[UILabel alloc]init];
    if ([self.recharge_model.ass_id isEqualToString:@"1.3.0"]) {
        label3.text =NSLocalizedStringFromTable(@"Exchange your",@"Internation", nil);
    }else if ([self.recharge_model.ass_id isEqualToString:@"1.3.2"]){
        label3.text =NSLocalizedStringFromTable(@"PFCExchange your",@"Internation", nil);
    }else{
        label3.text =NSLocalizedStringFromTable(@"USDTExchange your",@"Internation", nil);
    }
//    label3.text = NSLocalizedStringFromTable(@"Exchange your",@"Internation", nil);
    label3.numberOfLines = 0;
    label3.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:label3];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_left);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(label2.mas_bottom).offset(10);
    }];
    
    UILabel *label4 = [[UILabel alloc]init];
    if ([self.recharge_model.ass_id isEqualToString:@"1.3.5"]) {
        label4.text =NSLocalizedStringFromTable(@"BTC Address",@"Internation", nil);
    }else{
        label4.text =NSLocalizedStringFromTable(@"ETH Address",@"Internation", nil);
    }
//    label4.text = NSLocalizedStringFromTable(@"ETH Address",@"Internation", nil);
    label4.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label4];
    
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label3.mas_left);
        make.top.mas_equalTo(label3.mas_bottom).offset(10);
    }];
    UIView *whiteView = [[UIView alloc]init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label4.mas_left);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(label4.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    
    
    WINCopyLabel *label5 = [[WINCopyLabel alloc]init];
    label5.font = [UIFont systemFontOfSize:10];
    label5.text = @"";
    label5.backgroundColor = [UIColor whiteColor];
    self.eth_addressLabel = label5;
    label5.enabled = YES;
    [whiteView addSubview:label5];
    
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
    }];
    
    //生成地址
//    UIButton *address_button = [[UIButton alloc]init];
//    [address_button setTitle:@"生成地址" forState:UIControlStateNormal];
//    [address_button setBackgroundColor:[UIColor blueColor]];
//    self.address_button = address_button;
//    [whiteView addSubview:address_button];
//
//    [address_button addTarget:self action:@selector(clickaddress:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [address_button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(label5.mas_centerX);
//        make.centerY.mas_equalTo(label5.mas_centerY);
//    }];
    
    UILabel *label6 = [[UILabel alloc]init];
    label6.font = [UIFont systemFontOfSize:13];
    if ([self.recharge_model.ass_id isEqualToString:@"1.3.0"]) {
        label6.text = NSLocalizedStringFromTable(@"Bitshares Asset",@"Internation", nil);
    }else{
        label6.text =@"";
    }
    
    [self.view addSubview:label6];
    
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label4.mas_left);
        make.top.mas_equalTo(whiteView.mas_bottom).offset(10);
    }];
    
    UILabel *label7 =[[UILabel alloc]init];
    label7.font = [UIFont systemFontOfSize: 11];
    label7.numberOfLines = 0;
    if ([self.recharge_model.ass_id isEqualToString:@"1.3.0"]) {
        label7.text = NSLocalizedStringFromTable(@"Transfer the Bitshares asset",@"Internation", nil);
    }else{
        label7.text =@"";
    }
//    label7.text = NSLocalizedStringFromTable(@"Transfer the Bitshares asset",@"Internation", nil);
    [self.view addSubview:label7];
    
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label6.mas_left);
        make.top.mas_equalTo(label6.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
    }];
    
    UILabel *label8 = [[UILabel alloc]init];
    label8.font = [UIFont systemFontOfSize:13];
    if ([self.recharge_model.ass_id isEqualToString:@"1.3.0"]) {
        label8.text =NSLocalizedStringFromTable(@"Third party exchange",@"Internation", nil);
    }else{
         label8.text =NSLocalizedStringFromTable(@"Third party exchange2",@"Internation", nil);
    }
   
    [self.view addSubview:label8];
    
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label7.mas_left);
        make.top.mas_equalTo(label7.mas_bottom).offset(10);
    }];
   
    UILabel *label9 = [[UILabel alloc]init];
    label9.font = [UIFont systemFontOfSize:11];
    label9.text =NSLocalizedStringFromTable(@"Please contact",@"Internation", nil);
    label9.numberOfLines = 0;
    [self.view addSubview:label9];
    
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label8.mas_left);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(label8.mas_bottom).offset(10);
    }];
    
//    UILabel *lable10 = [[UILabel alloc]init];
    UIView *whiteView2 = [[UIView alloc]init];
    whiteView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView2];
    
    [whiteView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label9.left);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(label9.mas_bottom).offset(10);
        make.height.mas_equalTo(50);
    }];
    
    UIImageView *imageView_icon = [[UIImageView alloc]init];
    imageView_icon.image = [UIImage imageNamed:@"weichat_icon"];
    [whiteView2 addSubview:imageView_icon];
    
    [imageView_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    WINCopyLabel *label11 = [[WINCopyLabel alloc]init];
    label11.text = NSLocalizedStringFromTable(@"Wechat hongshaorouwanzi",@"Internation", nil);
    label11.font = [UIFont systemFontOfSize:12];
    [whiteView2 addSubview:label11];
    
    [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView_icon.mas_right).offset(20);
        make.centerY.mas_equalTo(imageView_icon.mas_centerY);
    }];
    
}

-(void)revolution{
    [self.eth_addressLabel setText:self.eth_addressStr];
}


@end
