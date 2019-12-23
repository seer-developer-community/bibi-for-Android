//
//  AboutUsViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/17.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()


//<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *aboutUsTableView;
@property(nonatomic,strong)UIView * backView ;

@end

@implementation AboutUsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    [self setTopView];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupUI];
}


-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    
    self.navigationController.navigationBarHidden = YES;
    self.navView.title = NSLocalizedStringFromTable(@"Abount Us",@"Internation", nil);
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
}


-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setupUI{
    
    UIView *backView = [[UIView alloc]init];
    
    backView.backgroundColor =  UIColorFromHexValue(0xf4f6fd);
    
    backView.frame = CGRectMake(0, self.navView.bottom, kScreenW, 170*kHeightScale);
    self.backView = backView;
    [self.view addSubview:backView];
    
    UIImageView *logoImageView = [[UIImageView alloc]init];
    
    logoImageView.image = [UIImage imageNamed:@"bibilogo"];
    
    [backView addSubview:logoImageView];
    
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(backView.mas_top).offset(25*kHeightScale);
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(64*kWidthScale, 74*kHeightScale));
        
    }];
    
    UILabel *versionLabel = [[UILabel alloc]init];
    versionLabel.text = @"V1.0";
    versionLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7];
    versionLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
    
    [backView addSubview:versionLabel];
    
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(logoImageView.mas_bottom).offset(2*kHeightScale);
        make.centerX.mas_equalTo(backView.mas_centerX);
        
    }];

    
    [self.view addSubview:self.aboutUsTableView];
}



//-(UITableView *)aboutUsTableView{
//
//    if (!_aboutUsTableView) {
//
//        _aboutUsTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, self.backView.bottom, kScreenW, kScreenH - self.navView.height) style:UITableViewStyleGrouped];
//        _aboutUsTableView.delegate = self;
//        _aboutUsTableView.dataSource =self;
//
//        _aboutUsTableView.separatorStyle =   UITableViewCellSeparatorStyleSingleLine;
//
//        _aboutUsTableView.backgroundColor = UIColorFromHexValue(0xf4f6fd);
//
//    }
//
//
//    return _aboutUsTableView;
//}
//
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//
//    return 1;
//}
//
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//
//    return 2;
//}
//
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    static NSString *cellindex = @"cellindex";
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellindex];
//
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellindex];
//
//        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
//        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
//    }
//
//
//    if (indexPath.row == 0) {
//
//        cell.textLabel.text = @"使用协议";
//        cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7];
//        cell.textLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
//
//    }if (indexPath.row ==1) {
//        cell.textLabel.text = @"隐私服务";
//        cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7];
//        cell.textLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
//    }
//
//
//    return cell;
//
//}
//
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//
//}
//





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
