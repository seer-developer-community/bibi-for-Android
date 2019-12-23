//
//  OrderAccount.h
//  BiBi
//
//  Created by 武建斌 on 2019/4/10.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderAccount : NSObject<ObjectToDataProtocol>

//累计收益
@property(nonatomic,strong)NSArray *share_wins;

//总订单数
@property(nonatomic,strong)NSArray *count_total;

//获胜订单
@property(nonatomic,strong)NSArray *count_wins;

//获胜订单
@property(nonatomic,strong)NSArray *rooms;

@property(nonatomic,strong)NSArray *share_total;

@property(nonatomic,strong)NSArray *count_back;


@property(nonatomic,strong)NSArray *share_back;


@end

NS_ASSUME_NONNULL_END
