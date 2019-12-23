//
//  NoteViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/24.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "NoteViewController.h"
#import "passWordView.h"
#import "NoteBigTagsViewController.h"
#import "NoteTagsRightViewController.h"
#import "NineNoteViewController.h"
@interface NoteViewController ()

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTopView];
    
//    NSArray *array = @[@1,@2,@3];
//    NSNumber *num = [array objectAtIndex:0];
    

    

    
}


-(void)setTopView{
    self.view.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    
    self.navigationController.navigationBarHidden = YES;
    self.navView.title = NSLocalizedStringFromTable(@"Back Up Mnemonic Words",@"Internation", nil);
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
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    imageView.image = [UIImage imageNamed:NSLocalizedStringFromTable(@"beizhu",@"Internation", nil)];
    
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.navView.mas_bottom).offset(100*kHeightScale);
        
        make.left.mas_equalTo(15*kWidthScale);
        
        make.right.mas_equalTo(-15*kWidthScale);
        
        
        
    }];
    
    
    UIButton *noteButton = [[UIButton alloc]init];
    
    //备份钱包
    [noteButton setTitle:NSLocalizedStringFromTable(@"Back Up Mnemonic Words",@"Internation", nil) forState:UIControlStateNormal];
    [noteButton  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    InQusetion.backgroundColor =  UIColorFromHexValue(0x81d8cf);
    noteButton.layer.backgroundColor = UIColorFromHexValue(0x2a7ddf).CGColor;
                                         
    noteButton .layer.cornerRadius = 20;
    noteButton .layer.masksToBounds = NO;
        [noteButton addTarget:self action:@selector(beifeiGo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noteButton ];
    
    
    //备份按钮
    [noteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(imageView.mas_bottom).offset(60*kHeightScale);
        
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(360*kWidthScale, 44*kHeightScale));
        
    }];
    

}

-(void)beifeiGo{
    
//    [self pushnext];

    passWordView *wordView = [[passWordView alloc]initWithTitleImage];

    __weak typeof(self) weakSelf = self;
    [wordView withSureClick:^(NSString *string) {
        NSLog(@"%@",string);

        [weakSelf pushnext];

    }];
    
    
//    [wordView addButtonAction:^(id  _Nonnull sender) {
//         __weak typeof(self) weakSelf = self;
//
//        [weakSelf pushnext];
//    }];
    
}


-(void)pushnext{
    
    
//    NoteTagsRightViewController *vc = [[NoteTagsRightViewController alloc]init];
//
//    [self.navigationController pushViewController:vc animated:YES];
    
    NineNoteViewController *nineNoetVC = [[NineNoteViewController alloc]init];
    
    [self.navigationController pushViewController:nineNoetVC animated:YES];
    
    
    
    
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
