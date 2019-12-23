//
//  PredictTableView.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/27.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailsModel;
#import "PredictTableViewCell.h"
#import "OrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol SDChatTableViewDelegate <NSObject>

-(void)SDChatTableView:(id)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PredictTableView : UITableView
<UITableViewDataSource,UITableViewDelegate,ButtonDelegate>

@property (nonatomic,weak) id<SDChatTableViewDelegate>sd_delegate;//
@property (nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)DetailsModel *tableprdModel;
@property(nonatomic,strong)OrderModel *orderM;
@end

NS_ASSUME_NONNULL_END
