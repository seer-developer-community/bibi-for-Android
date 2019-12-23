//
//  OrederTableViewCell.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/7.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrederTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView ;

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

//待结算
@property(nonatomic,strong)OrderModel *orderH;

@property(nonatomic,assign)float rewer;

@property(nonatomic,strong)UIView *bagView;

@property(nonatomic,strong)UIView *line1;

//第几个cell
@property(nonatomic,assign)NSInteger cellIdenx;


// 购买份数金额
@property(nonatomic,strong)UILabel*piadLabel;



@end

NS_ASSUME_NONNULL_END
