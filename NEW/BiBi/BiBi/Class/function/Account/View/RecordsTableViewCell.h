//
//  RecordsTableViewCell.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/18.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TrAccountModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface RecordsTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;


//日期
@property(nonatomic,copy)NSString *data;

//交易类型
@property(nonatomic,copy)NSString *type;

//用户
@property(nonatomic,copy)NSString *name;

//交易金额

@property(nonatomic,copy)NSString *rmb;

////手续费
//@property(nonatomic,copy)NSString *tranfeer;

@property(nonatomic,strong)TrAccountModel *historyModel;



@end

NS_ASSUME_NONNULL_END
