//
//  DetailsTableViewCell.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/19.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsModel.h"


@class ButtonView;
NS_ASSUME_NONNULL_BEGIN

@interface DetailsTableViewCell : UITableViewCell

@property (nonatomic, strong) DetailsModel *model;
@property (nonatomic, strong) UILabel *titleLb;


+(instancetype)cellWithTableView:(UITableView *)tableView;


//背景view
@property(nonatomic,strong)UIView *bagView;

//截止时间

//@property(nonatomic,strong)UILabel *stopTimeLabel;

//房间类型

@property(nonatomic,strong)UILabel *room_TypeLabel;

@property (nonatomic, strong) UILabel *timeLb;

//竞猜内容
@property(nonatomic,strong)UILabel *contentLabel;

//竞猜选项
@property(nonatomic,assign)NSInteger choseCount;


//选择buttonView
@property(nonatomic,strong)ButtonView *chooseButton;


@property(nonatomic,strong)UIView *betView;

@property(nonatomic,strong)UIView *lineView1;

//小横线 下
@property(nonatomic,strong)UIView *lineView2;


//最下面的view
@property(nonatomic,strong)UIView *toolView;


// 产于的金额
@property(nonatomic,strong)UIButton * totalmoney;

//人数
@property(nonatomic,strong)UIButton *totalpeople;

//剩余占百分比
@property(nonatomic,strong)UIButton *percent;

//确定
@property(nonatomic,strong)UIButton *choseBut;

@property(nonatomic,strong)UIButton *choseBut1;

@property(nonatomic,strong)UIButton *choseBut2;

@end

NS_ASSUME_NONNULL_END
