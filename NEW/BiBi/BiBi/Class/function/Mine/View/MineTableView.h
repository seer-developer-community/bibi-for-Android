//
//  MineTableView.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/17.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SDChatTableViewDelegate <NSObject>

-(void)SDChatTableView:(id)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end



@interface MineTableView : UITableView

<
UITableViewDelegate,
UITableViewDataSource
>


@property (nonatomic,strong)NSMutableArray * dataArray;

@property (nonatomic,weak) id<SDChatTableViewDelegate>sd_delegate;//

@end

NS_ASSUME_NONNULL_END
