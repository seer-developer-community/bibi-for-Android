//
//  PredictHeaderView.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/27.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"
@class DetailsModel;
#import "OrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PredictHeaderView : UITableViewHeaderFooterView

//截止时间

@property(nonatomic,strong)UILabel *stopTimeLabel;

@property(nonatomic,strong)UILabel *room_typeLabel;

//竞猜内容
@property(nonatomic,strong)UILabel *contentLabel;


// 产于的金额
@property(nonatomic,strong)UIButton * totalmoney;

//人数
@property(nonatomic,strong)UIButton *totalpeople;

//剩余占百分比
@property(nonatomic,strong)UIButton *percent;

//// 预测button
//@property(nonatomic,strong)UIButton *preBnt;

//分割线
@property(nonatomic,strong)UIView *lineView1;

//背景view
@property(nonatomic,strong)UIView *bagView;

//创建一个背景
@property(nonatomic,strong)ProgressView *progressView;

// 分割线2

@property(nonatomic,strong)UIView *lineView2;

//最下面的view
@property(nonatomic,strong)UIView *toolView;


//模型数据
@property(nonatomic,strong)DetailsModel *headPredicModel;

//订单跳转的模型数据

@property(nonatomic,strong)OrderModel * headOrderModel;







@end

NS_ASSUME_NONNULL_END
