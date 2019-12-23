//
//  MineTableViewHeaderView.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/17.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "MineTableViewHeaderView.h"

@interface MineTableViewHeaderView ()

@property(nonatomic,strong)UILabel *nameLabel;

@end

@implementation MineTableViewHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUIMineHeader];
    }
    
    return self;
}


-(void)setUIMineHeader{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 113*kHeightScale )];
    [self addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];
    UIImageView *headIconImageView = [[UIImageView alloc]init];
    headIconImageView.image = [UIImage imageNamed:@"head_icon"];
    [backView addSubview:headIconImageView];
    [headIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(53, 53));
        
    }];
    
    //导入钱包
    UILabel *nameLabel = [[UILabel alloc] init];
   
    nameLabel.numberOfLines = 0;
    NSString *userName ;
    userName = @"创建钱包/导入钱包";
    
//    if ([MoneyPacketManager moneyAcctountManager].isLogin) {
//    }

    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:userName attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0]}];
    
    nameLabel.attributedText = string;
    self.nameLabel =  nameLabel;
    [backView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headIconImageView.mas_bottom).offset(7);
        make.centerX.mas_equalTo(headIconImageView.mas_centerX);
        
    }];
    //空白界面
    UIView *balckView = [[UIView alloc] initWithFrame:CGRectMake(0, 93, kScreenW, 25 )];;
    
    balckView.backgroundColor = UIColorFromHexValue(0xf4f6fd);
    
    [backView addSubview:balckView];
   
    
}

-(void)setUserName:(NSString *)userName{
    _userName = userName;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:userName attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0]}];
    self.nameLabel.attributedText = string;
    
}



@end
