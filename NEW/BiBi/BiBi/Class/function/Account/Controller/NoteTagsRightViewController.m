//
//  NoteTagsRightViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/31.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "NoteTagsRightViewController.h"
#import "BitsharesWalletObject.h"
#import "BrainKey.h"
#import "BaseConfig.h"
#import "MaskView.h"
#import "WuLoadingView.h"
#import "MLNetworkTool.h"

@interface NoteTagsRightViewController ()

@property (nonatomic,strong)UILabel *oneLabel;

@property(nonatomic,strong)UILabel *twoLabel;

@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIView *buttomView;

@property (nonatomic,strong)UIButton *confirmBtn;

@property (nonatomic,strong)UIButton *bottomBtn;

@property (nonatomic,strong)NSMutableArray *buttomArr;

@property (nonatomic,strong)NSMutableArray *bottomBtnArr;

@property(nonatomic,strong)UIButton *topBtn;

@property(nonatomic,strong)NSMutableArray *topArr;
@property (nonatomic,strong)NSMutableArray *topBtnArr;

//@property (nonatomic,strong) BitsharesWalletObject *wallet;

@property (nonatomic,assign) BOOL connected;

@property(nonatomic,strong) WuLoadingView *loadingView;

@end

@implementation NoteTagsRightViewController

{
    UIScrollView *scrollview;
    CGFloat W;
    CGFloat H;
    NSInteger rank;
    CGFloat rankMargin;
    CGFloat rowMargin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    _buttomArr =[NSMutableArray arrayWithArray: @[@"whant",@"二",@"三",@"四",@"五",@"六",@"七",@"8",@"9",@"ggtgkj",@"11",@"12",@"13",@"14",@"15",@"16"]];
    
    
//    打乱顺序
    NSArray *arry = [self randamArry:self.ciArry];
    
//    NSArray*arry = self.ciArry;
    
    _buttomArr = [NSMutableArray arrayWithArray:arry];
    
//    if ([self.ciArry isEqual:arry]) {
//        NSLog(@"对");
//    }else{
//
//        NSLog(@"不对");
//    }
    
    _bottomBtnArr = [NSMutableArray arrayWithCapacity:100];
    _topArr = [NSMutableArray arrayWithCapacity:100];
    _topBtnArr = [NSMutableArray arrayWithCapacity:100];
    
    
    W = 70;  H = 35;    //每个Item宽高
    rank = 4;    //每行列数
    rankMargin = (self.view.frame.size.width - rank * W) / (rank - 1)-20;  //每列间距
    rowMargin = 10; //每行间距
    [self setTopView];
    [self creatUI];
//    [self setupUI];
}




- (NSArray *)randamArry:(NSArray *)arry
{
    // 对数组乱序
    arry = [arry sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
   
    
    
    return arry;
    
    
}


-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    
    self.navigationController.navigationBarHidden = YES;
    self.navView.title = NSLocalizedStringFromTable(@"Back Up Mnemonic Words",@"Internation", nil);
    //    self.navView.backgroundColor = [UIColor redColor];
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick)
                         forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
    
    //    [self setupUI];
}


-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}



// 点击下面的button
- (void)clickButtomBtn:(UIButton*)sender {
    [_topArr addObject:sender.currentTitle];
    [_topBtnArr addObject:sender];
    
    [self reloadTopView:sender];
    
    [sender removeFromSuperview];
    [_buttomArr removeObject:sender.currentTitle];
    [_bottomBtnArr removeObject:sender];
    
    [self removeLoadButtomView];
    
    NSLog(@"%@",_topArr);
}


- (void)clickTopBtn:(UIButton*)sender {
    [_buttomArr addObject:sender.currentTitle];
    [_bottomBtnArr addObject:sender];
    
    [self reloadButtomView:sender];
    
    [sender removeFromSuperview];
    [_topArr removeObject:sender.currentTitle];
    [_topBtnArr removeObject:sender];
    
    [self removeLoadTopView];
}



- (void)reloadButtomView:(UIButton *)sender {
    //    [self reloadView:sender superView:_buttomView titleArr:_buttomArr btnArr:_bottomBtnArr btnTag:1000];
    for (int i = 0 ; i< _buttomArr.count; i++) {
        CGFloat X = (i % rank) * (W + rankMargin);//Item X轴
        NSUInteger Y = (i / rank) * (H +rowMargin); //Item Y轴
        CGFloat top =  10;     //Item top
        CGFloat left = 15;
        
        _bottomBtn = _bottomBtnArr[i];
        NSLog(@"%ld,%ld",sender.tag,_bottomBtn.tag);
        if (sender.tag == _bottomBtn.tag) {
            [_bottomBtnArr removeObject:_bottomBtn];
            [_bottomBtn removeFromSuperview];
            [ _buttomView addSubview:self.bottomBtn];
            [_bottomBtnArr addObject:_bottomBtn];
            _bottomBtn.tag = i+1000;
        }else {
            _bottomBtn.tag = i+1000;
        }
        [_bottomBtn addTarget:self action:@selector(clickButtomBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomBtn setTitle:_buttomArr[i] forState:UIControlStateNormal];
        NSLog(@"%@",_bottomBtn.currentTitle);
        [_bottomBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset(X+left);
            make.top.offset(Y+top);
            make.width.offset(50);
            make.height.offset(20);
        }];
        NSLog(@"%ld",_bottomBtn.tag);
        NSLog(@"%f,%f,%f,%f",X+left,Y+top,W,H);
    }
}
-(void)reloadTopView:(UIButton *)sender {
    //    [self reloadView:sender superView:_topView titleArr:_topArr btnArr:_topBtnArr btnTag:2000];
    for (int i = 0 ; i< _topArr.count; i++) {
        CGFloat X = (i % rank) * (W + rankMargin);//Item X轴
        NSUInteger Y = (i / rank) * (H +rowMargin); //Item Y轴
        CGFloat top =  5;     //Item top
        CGFloat left = 15;
        _bottomBtn =_topBtnArr[i];
        
        if (sender.tag == _bottomBtn.tag) {
            [_topBtnArr removeObject:_bottomBtn];
            [_bottomBtn removeFromSuperview];
            [ _topView addSubview:self.bottomBtn];
            [_topBtnArr addObject:_bottomBtn];
            _bottomBtn.tag = i+2000;
        }else {
            _bottomBtn.tag = i+2000;
        }
        [_bottomBtn addTarget:self action:@selector(clickTopBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomBtn setTitle:_topArr[i] forState:UIControlStateNormal];
//        _bottomBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 14];
//        _bottomBtn.layer.borderWidth = 1;
//        _bottomBtn.layer.borderColor = UIColorFromHexValue(0x2D86E3).CGColor;
//        _bottomBtn.layer.cornerRadius = 10;
//        [_bottomBtn setTitleColor:UIColorFromHexValue(0x2D86E3) forState:UIControlStateNormal];
//        [_bottomBtn setBackgroundColor:[UIColor colorWithRed:45/255.0 green:134/255.0 blue:227/255.0 alpha:0.3]];
        
        [_bottomBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset(X+left);
            make.top.offset(Y+top);
            make.width.offset(50);
            make.height.offset(20);
        }];
    }
}

- (void)removeLoadButtomView {
    [self removeLoadView:_buttomArr btnArray:_bottomBtnArr];
}
- (void)removeLoadTopView {
    [self removeLoadView:_topArr btnArray:_topBtnArr];
}

- (void)removeLoadView:(NSMutableArray*)arry btnArray:(NSMutableArray*)btnArr {
    for (int i = 0 ; i< arry.count; i++) {
        CGFloat X = (i % rank) * (W + rankMargin);//Item X轴
        NSUInteger Y = (i / rank) * (H +rowMargin); //Item Y轴
        CGFloat top =  5;     //Item top
        CGFloat left = 15;
        UIButton *buttom =btnArr[i];
        [buttom setTitle:arry[i] forState:UIControlStateNormal];
        [buttom mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset(X+left);
            make.top.offset(Y+top);
            make.width.offset(50);
            make.height.offset(20);
        }];
    }
}








-(void)creatUI{
    scrollview = [[UIScrollView alloc]init];
    //    scrollview.showsVerticalScrollIndicator = YES;
    [self.view addSubview:scrollview];
    
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.offset(0);
        make.top.mas_equalTo(self.navView.mas_bottom);
        make.right.left.bottom.mas_equalTo(0);
    }];
    [self.view layoutIfNeeded];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.navView.bottom, scrollview.frame.size.width, scrollview.frame.size.height)];
    [scrollview addSubview:view];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.textColor = UIColorFromHexValue(0x444444);
    label1.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 14.7];
    
    label1.text = NSLocalizedStringFromTable(@"Please write down",@"Internation", nil);
    [view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.textColor = UIColorFromHexValue(0x444444);
    label2.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10.7];
    label2.numberOfLines = 0;
    label2.text = NSLocalizedStringFromTable(@"Please click on",@"Internation", nil);
    [view addSubview:label2];
    
    
    // 头部view
    _topView = [[UIView alloc]init];
    _topView.backgroundColor = [UIColor whiteColor];
    _topView.layer.cornerRadius = 6.7;
    [view addSubview:_topView];
    
    // 下面view
    _buttomView = [[UIView alloc]init];
    _buttomView.backgroundColor = [UIColor clearColor];
    [view addSubview:_buttomView];
    
    
    _confirmBtn = [[UIButton alloc]init];
    [_confirmBtn addTarget:self action:@selector(clcickConfirmBtnBtn) forControlEvents:UIControlEventTouchUpInside];
    _confirmBtn.layer.shadowOffset =  CGSizeMake(0.5, 0.5);
    _confirmBtn.layer.shadowOpacity = 0.9;
    _confirmBtn.layer.shadowColor = UIColorFromHexValue(0x2A7DDF).CGColor;
    _confirmBtn.layer.cornerRadius = 20;
    [_confirmBtn setTitle:NSLocalizedStringFromTable(@"Buttonsure",@"Internation", nil) forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 18.7];
    _confirmBtn.backgroundColor = UIColorFromHexValue(0x2A7DDF);
    [view addSubview:_confirmBtn];
    
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom).offset(33);
        make.centerX.mas_equalTo(0);
        
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(10);
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(20);
        make.centerX.mas_equalTo(0);
    }];
//
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label2.mas_bottom).offset(20);
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(180);
        
    }];
    
    
    [self.buttomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(30);
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(200);
    }];
   
    
    for (int i = 0 ; i< _buttomArr.count; i++) {
        CGFloat X = (i % rank) * (W + rankMargin);//Item X轴
        NSUInteger Y = (i / rank) * (H +rowMargin); //Item Y轴
        CGFloat top =  10;     //Item top
        CGFloat left = 15;
        [_buttomView addSubview:self.bottomBtn];
        _bottomBtn.tag = i+1000;
        [_bottomBtn addTarget:self action:@selector(clickButtomBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomBtn setTitle:_buttomArr[i] forState:UIControlStateNormal];
        
        [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(X+left);
            make.top.mas_equalTo(Y+top);
            make.width.offset(50);
            make.height.offset(20);
        }];
        [_bottomBtnArr addObject:_bottomBtn];
    }
    
    
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.buttomView.mas_bottom).offset(10);
        make.right.mas_equalTo(-30);
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(40);
        
    }];
    
    
    
    
    
    [self.view layoutIfNeeded];
//    _confirmBtn.layer.cornerRadius = _confirmBtn.frame.size.height/2;
//    scrollview.contentSize = CGSizeMake(0, _confirmBtn.frame.origin.y+_confirmBtn.frame.size.height + 50);
}


-(UIButton *)bottomBtn {
    _bottomBtn = [[UIButton alloc]init];
//    _bottomBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
    _bottomBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 13];
     _bottomBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    _bottomBtn.layer.borderWidth = 1;
    _bottomBtn.layer.borderColor = UIColorFromHexValue(0x2D86E3).CGColor;
    _bottomBtn.layer.cornerRadius = 10;
    [_bottomBtn setTitleColor:UIColorFromHexValue(0x2D86E3) forState:UIControlStateNormal];
    [_bottomBtn setBackgroundColor:[UIColor colorWithRed:45/255.0 green:134/255.0 blue:227/255.0 alpha:0.3]];
//    _bottomBtn.layer.cornerRadius = 4;
//    _bottomBtn.layer.borderWidth = 1;
//    _bottomBtn.layer.borderColor = UIColorFromHexValue(0x7a7a7a).CGColor;
    [_bottomBtn setTitleColor:UIColorFromHexValue(0x444444) forState:UIControlStateNormal];
    return _bottomBtn;
}


-(UIButton *)topBtn{
    _topBtn = [[UIButton alloc]init];
    _topBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 14];
    _topBtn.layer.cornerRadius = 14.8;
    [_topBtn setTitleColor:UIColorFromHexValue(0x2D86E3) forState:UIControlStateNormal];
    [_topBtn setBackgroundColor:UIColorFromHexValue(0x444444)];
    
    return _topBtn;
}


-(void)clcickConfirmBtnBtn{
    
    
     [self backupSucceful];
}


-(void)backupSucceful{
//    Backup Done" = "备份成功";
//    "The order of the mnemonic" ="你备份的助记词顺序验证正确，币比将移除该助记词";
//    "Backup Failure" = "备份失败";
//    "Please check your mnemonic words" ="请检查你的助记词";

    if ([self.ciArry isEqual:_topArr]) {
        MaskView *maskView = [[MaskView alloc]initWithTitleBiglable:NSLocalizedStringFromTable(@"Backup Done",@"Internation", nil) little:@""littletwo:NSLocalizedStringFromTable(@"The order of the mnemonic",@"Internation", nil)  textColor:UIColorFromHexValue(0x444444)];
        [MoneyPacketManager moneyAcctountManager].isLogin = YES;
        [maskView addButtonAction:^(id  _Nonnull sender) {
            [self pushnex];
        }];
    }else{
     MaskView *maskView = [[MaskView alloc]initWithTitleBiglable:NSLocalizedStringFromTable(@"Backup Failure",@"Internation", nil) little:@""littletwo:NSLocalizedStringFromTable(@"Please check your mnemonic words",@"Internation", nil)  textColor:UIColorFromHexValue(0xF13535)];
        
        [maskView addButtonAction:^(id  _Nonnull sender) {
 
        }];
    }
}

-(void)pushnex{
    [self qingqiu];
}






-(void)qingqiu{
    WuLoadingView *loadingView = [[WuLoadingView alloc]init];
    self.loadingView = loadingView;
    [loadingView showLoadingView];
    
    NSString *urlString =NEW_URL_main;
    
    NSString *usreName = [MoneyPacketManager moneyAcctountManager].userName;
    NSString *pulickStr = [MoneyPacketManager moneyAcctountManager].puliKeyStr;
    NSURL *url = [NSURL URLWithString:urlString];

    //2. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //2.1设置请求方法
    request.HTTPMethod = @"POST";
    NSData *data = [NSJSONSerialization dataWithJSONObject: @{
                                                              @"account":@{
                                                                      @"name":usreName,
                                                                      @"owner_key":pulickStr,
                                                                      @"active_key":pulickStr,
                                                                      @"memo_key":pulickStr,
                                                                      @"refcode":@"",
                                                                      @"referrer":@""
                                                                      }
                                                              } options:NSJSONWritingPrettyPrinted error:nil];
    //
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];




    request.HTTPBody = data;

    //3.建立连接发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if(connectionError) {
            NSLog(@"这个是错误");
        }else {
            //4. 解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];

            NSDictionary * errorMsg = [dict objectForKey:@"error"];
            NSDictionary *account = [dict objectForKey:@"account"];
              NSLog(@"这个字典是多少%@",dict);
            NSString *five;
            if (errorMsg) {
                if ([errorMsg objectForKey:@"remote_ip"]) {
                  five =NSLocalizedStringFromTable(@"Only one user",@"Internation", nil);
                }else{
                    five = [dict objectForKey:@"error"];
                }
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Prompt",@"Internation", nil) message:five delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"Buttonsure",@"Internation", nil) otherButtonTitles:nil];
                
                [self.loadingView cancelView];
                [[MoneyPacketManager moneyAcctountManager]logout];
                [alert show];
                  return;
            }
            
            if (account) {
                
//                [MoneyPacketManager moneyAcctountManager].isLogin = YES;
//                [MoneyPacketManager moneyAcctountManager].isHiddenImage = YES;
//                [[MoneyPacketManager moneyAcctountManager] saveUserData];
//                [self.loadingView cancelView];
//                [self.navigationController popToRootViewControllerAnimated:YES];

                 [self logningfuncktext];
                
            }
            
            
            
        }

    }];

}






//-(void)setupUI{
//
////    WuLoadingView *loadingView = [[WuLoadingView alloc]init];
////    self.loadingView = loadingView;
////    [loadingView showLoadingView];
//    _wallet = [[BitsharesWalletObject alloc]initWithChainId:@"cea4fdf4f5c2278f139b22e782b308928f04008b0fc2c79970a58974a2a28f91" prefix:@"SEER"];
//
//    [self needConnect];
//
//    __weak typeof(self) weakSelf = self;
//
//    _wallet.connectStatusChange = ^(WebsocketConnectStatus status) {
//        weakSelf.connected = status == WebsocketConnectStatusConnected;
//        NSLog(@"status change");
//    };
//
//}
//
//
//- (void)needConnect {
//    [_wallet connectUrl:@"ws://39.105.189.224/ws" timeOut:10 connectedError:^(NSError *error) {
//        NSLog(@"%@",error.description);
//
//        [self needConnect];
//    }];
//
//
//}

//查询id
-(void)logningfuncktext{
    [[BitsharesWalletObject BitsharesWalletObjectManager] getAccount:M_userName success:^(AccountObject *result) {
        
        if ([NSString stringWithFormat:@"%@",result.identifier].length>0) {
            
            [MoneyPacketManager moneyAcctountManager].identifier = [NSString stringWithFormat:@"%@",result.identifier];
//            [self postUrl];
            [self SeerOmniURL];
        }else{
              [MoneyPacketManager moneyAcctountManager].identifier = [NSString stringWithFormat:@"%@",result.identifier];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[BitsharesWalletObject BitsharesWalletObjectManager] getAccount:M_userName success:^(AccountObject *result) {
                    if ([MoneyPacketManager moneyAcctountManager].identifier.length>0) {
                        [MoneyPacketManager moneyAcctountManager].identifier = [NSString stringWithFormat:@"%@",result.identifier];
//
//                        [self postUrl];
                        [self SeerOmniURL];
                        
                    }else{
                          [MoneyPacketManager moneyAcctountManager].identifier = [NSString stringWithFormat:@"%@",result.identifier];
                        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Prompt",@"Internation", nil) message:@"返回的ID值是空的" delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"BUttonsure",@"Internation", nil) otherButtonTitles:nil];
                        [self.loadingView cancelView];
                        [alert show];
                        
                    }
                    
                } error:^(NSError *error) {
                    
                }];
                
                
            });
            
//             UIAlertView *alert =[[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Prompt",@"Internation", nil) message:@"返回的ID值是空的" delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"BUttonsure",@"Internation", nil) otherButtonTitles:nil];
//               [self.loadingView cancelView];
//              [alert show];

        }
//        [[MoneyPacketManager moneyAcctountManager] saveUserData];
        
        
    } error:^(NSError *error) {
        
        NSLog(@"ffffff");
        
    }];
}



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
            
            //绑定eth
            [self postUrl];

            [MoneyPacketManager moneyAcctountManager].isLogin = YES;
            [MoneyPacketManager moneyAcctountManager].isHiddenImage = YES;
            [[MoneyPacketManager moneyAcctountManager] saveUserData];
            [self.loadingView cancelView];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }

    }];
}



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
            
            [MoneyPacketManager moneyAcctountManager].isLogin = YES;
            [MoneyPacketManager moneyAcctountManager].isHiddenImage = YES;
            [[MoneyPacketManager moneyAcctountManager] saveUserData];
            [self.loadingView cancelView];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }];
    
    
}



- (void)dealloc{
    UITabBarController * rootVC = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        [rootVC setSelectedIndex:0];
        rootVC.selectedViewController = rootVC.viewControllers.firstObject;
    }
    
}

@end
