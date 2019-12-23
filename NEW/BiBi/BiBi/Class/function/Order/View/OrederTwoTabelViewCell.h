//
//  OrederTwoTabelViewCell.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/9.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrederTwoTabelViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

//标题
@property(nonatomic,strong)UILabel *contentLabel;

//竞猜金额
@property(nonatomic,strong)UILabel *sumLabel;

//竞猜选项

@property(nonatomic,strong)UILabel *guessLabel;

//时间
@property(nonatomic,strong)UILabel *timeOutLabel;

//中奖金额
@property(nonatomic,strong)UILabel *winnLabel;

@property(nonatomic,strong)OrderModel *orderM;

@property(nonatomic,strong)OrderModel *orderW;

@property(nonatomic,assign)float rewer;
@end

NS_ASSUME_NONNULL_END
