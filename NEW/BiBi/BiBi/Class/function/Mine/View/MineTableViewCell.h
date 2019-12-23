//
//  MineTableViewCell.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/17.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

/**
 头像
 */
@property(nonatomic,strong)UIImageView *cellimageView;

/**
 celllabel
 */
@property(nonatomic,strong)UILabel *cellLabel;

@end

NS_ASSUME_NONNULL_END
