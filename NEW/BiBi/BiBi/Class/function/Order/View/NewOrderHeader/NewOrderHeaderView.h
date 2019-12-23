//
//  NewOrderHeaderView.h
//  BiBi
//
//  Created by 武建斌 on 2019/4/10.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "CPTopAnimationView.h"
#import "SEERTopAnimationView.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewOrderHeaderView : UITableViewHeaderFooterView

//模型
@property(nonatomic,strong)OrderModel *headOrderModel;
//总订单
@property(nonatomic,assign)NSInteger countNmb;

////总订单
//@property(nonatomic,assign)NSInteger allCount;


//总共获益
@property(nonatomic,assign)float counRmb;

@property(nonatomic,copy)NSString *leiji;

//胜场
@property(nonatomic,assign)NSInteger suncedCount;

//胜率
@property(nonatomic,assign)float prendStr;
//货币
@property(nonatomic,strong)SEERTopAnimationView *seerTopView;

//进行中 待结算 已结束
@property(nonatomic,strong)CPTopAnimationView *headerView;


-(instancetype)initWith:(NSArray *)arry andFlag:(NSInteger)flag andtopFlag:(NSInteger)topFlag;

@end

NS_ASSUME_NONNULL_END
