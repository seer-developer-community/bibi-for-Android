//
//  AccountTableViewCell.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/17.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PredictHeaderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

/**
 背景
 */
@property(nonatomic,strong)UIImageView *cellimageView;

/**
 小图
 */
@property(nonatomic,strong)UIImageView *bizhongimageView;
/**
 余额
 */
@property(nonatomic,strong)UILabel *cellLabel;

//币种字体
@property(nonatomic,strong)UILabel *bizhongtextcount;


@property(nonatomic,strong)PredictHeaderModel *model;

@end

NS_ASSUME_NONNULL_END
