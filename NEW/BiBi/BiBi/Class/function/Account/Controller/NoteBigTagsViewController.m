//
//  NoteBigTagsViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/26.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "NoteBigTagsViewController.h"

@interface NoteBigTagsViewController ()

/**
 上面标签
 */
@property (nonatomic,strong)NSMutableArray *myTagsArr;


/**
 下面固定标签
 */
@property (nonatomic,strong)NSArray *moreTagsArr;


/**
 所有标签数据
 */
@property (nonatomic,strong)NSArray *dataArr;



@end

@implementation NoteBigTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTopView];
    
    [self setupUI];
    
}


-(NSArray *)dataArr{
    if (!_dataArr) {
        NSString * str = @"JHOW BALLOT CALLOUS HEADCAP AMNESIC TARSIER HELLUO SEEKER OPERAE CURLIKE PUTT HOOPOE RUSPONE JARRA ODORANT ACEPHAL";
        
        NSString *str1 = [str lowercaseString];
        
        _dataArr = [str1  componentsSeparatedByString:@" "];
        
    }
    
    
    return _dataArr;
    
}

-(NSMutableArray *)myTagsArr{
    if (!_myTagsArr) {
        _myTagsArr =[NSMutableArray array];
    }

return _myTagsArr;
    
}


//


-(void)setupUI{
    
    UIView *labelView = [[UIView alloc]init];
    
    labelView.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:labelView];
    
    
    [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.top.mas_equalTo(260);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(200);
        
    }];
    
    CGFloat width = 60;
    CGFloat height = 20;
    CGFloat xMargin = 30;
    CGFloat yMargin = 40;
    CGFloat topMargin = 0;
    int column = 4;
    CGFloat leftMargin = 10;
    
    for (int i = 0; i<self.dataArr.count; i++) {
        UIButton *optionButton = [[UIButton alloc]init];
        //x = leftMargin + (width + xMargin) * (i % column)
        CGFloat x = leftMargin + (width + xMargin) * (i % column);
        //y = topMaring + (height + yMargin) * (i / column)
        CGFloat y = topMargin + (height + yMargin) * (i / column);
        
        optionButton.frame = CGRectMake(x, y, width, height);
        optionButton.backgroundColor = [UIColor redColor];
        [optionButton setTitle:self.dataArr[i] forState:UIControlStateNormal];
        optionButton.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
//
        [optionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [labelView addSubview:optionButton];
        //给待选项按钮添加点击事件
        [optionButton addTarget:self action:@selector(clickOptionButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
}




-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    
    self.navigationController.navigationBarHidden = YES;
    self.navView.title = @"备份助记词";
    //    self.navView.backgroundColor = [UIColor redColor];
    [self.navView.leftBarButton addTarget:self action:@selector(goBackClick)
                         forControlEvents:UIControlEventTouchUpInside];
    self.navView.lefBarButtonImage = [UIImage imageNamed:@"back"];
    
//    [self setupUI];
}


-(void)goBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)clickOptionButton:(UIButton *)sender{
    
    [sender removeFromSuperview];
    
    [self.myTagsArr addObject:sender.titleLabel.text];
    
//      [self.view invalidateIntrinsicContentSize];

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
