//
//  PredictTableViewCell.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/27.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonDelegate <NSObject>

-(void)buttonPush:(UITableViewCell *)cell;

@end

@interface PredictTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *touLabel;

//赔率
@property(nonatomic,strong)UILabel *odds_numberLabel;
//提示语
@property(nonatomic,strong)UILabel *textLabel1;


@property(nonatomic,strong)UIImageView *sureBntImageView;

@property(nonatomic,strong)UIButton *yuceBnt;

@property(nonatomic,strong)UIButton *promptBnt;

//imageview
@property(nonatomic,strong)UIButton *imageViewButon;

@property(nonatomic,weak)id<ButtonDelegate>delegate;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

