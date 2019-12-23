//
//  CPToolView.h
//  随便
//
//  Created by 陈彦松 on 2018/12/23.
//  Copyright © 2018年 cmbc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailsModel;
#import "OrderModel.h"
@protocol CPPassCPToolViewProtocol <NSObject>
- (void)selectedIndex:(NSInteger)index;
-(void)pushnextVc;
@end
@interface CPToolView : UIView

@property(nonatomic,strong)DetailsModel *preModel;

@property(nonatomic,copy)NSString *choseStr;

@property(nonatomic,strong)OrderModel *toolOrderM;

@property(nonatomic,assign)NSInteger indexpath;

@property (weak, nonatomic) id<CPPassCPToolViewProtocol> delegate;

-(instancetype) initWithRoomtype:(NSInteger)roomtype;

@end
