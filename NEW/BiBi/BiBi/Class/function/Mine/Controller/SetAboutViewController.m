//
//  SetAboutViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/17.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "SetAboutViewController.h"
#import "LangueViewController.h"
#import "AboutUsViewController.h"
@interface SetAboutViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *setTableView;

@property(nonatomic,strong)NSArray *labelArray;

@end

@implementation SetAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 

    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    
    [self.view addSubview:self.setTableView];
//    "Language" ="Language Management";
//    "Abount Us" ="Abount Us";
    self.labelArray = @[NSLocalizedStringFromTable(@"Language",@"Internation", nil),NSLocalizedStringFromTable(@"Abount Us",@"Internation", nil)];
    
     [self setTopView];
}

-(void)setTopView{
 
    self.navigationController.navigationBarHidden = YES;
    self.navView.title =NSLocalizedStringFromTable(@"Setings",@"Internation", nil);
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
  
}


-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(UITableView *)setTableView{

    if (!_setTableView) {
        
        _setTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, self.navView.bottom, kScreenW, kScreenH - self.navView.height) style:UITableViewStyleGrouped];
        _setTableView.delegate = self;
       _setTableView.dataSource =self;
        
        _setTableView.separatorStyle =   UITableViewCellSeparatorStyleSingleLine;
        
        _setTableView.backgroundColor = UIColorFromHexValue(0xf4f6fd);
        
    }


    return _setTableView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [self.labelArray count];;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellindex = @"cellindex";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellindex];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellindex];
        
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.labelArray[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12.7];
    cell.textLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];

    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        LangueViewController *vc = [[LangueViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }if (indexPath.row == 1) {
        AboutUsViewController *vc = [[AboutUsViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
}


@end
