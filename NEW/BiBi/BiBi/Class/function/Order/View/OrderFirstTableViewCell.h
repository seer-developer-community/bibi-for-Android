//
//  OrderFirstTableViewCell.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/8.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderFirstTableViewCell : UITableViewCell
//模型
@property(nonatomic,strong)OrderModel *headOrderModel;
//总订单
@property(nonatomic,assign)NSInteger countNmb;

//总共获益
@property(nonatomic,assign)float counRmb;

//胜场
@property(nonatomic,assign)NSInteger suncedCount;

//胜率
@property(nonatomic,assign)float prendStr;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
