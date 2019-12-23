//
//  OrderContention.h
//  BiBi
//
//  Created by 武建斌 on 2019/4/12.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
#import "NSObject+DataToObject.h"
#import "OrderToclass.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderContention : NSObject<ObjectToDataProtocol>

//页数的标识
@property(nonatomic,copy)NSString *identifier;
//投注的选手
@property(nonatomic,copy)NSString *player;
//投注的房间
@property(nonatomic,copy)NSString *room;
//选项
@property(nonatomic,assign)int input;
//投注的总金额
@property(nonatomic,assign)NSInteger amount;
//reward中奖总金额
@property(nonatomic,assign)NSInteger reward;
//status
@property(nonatomic,assign)NSInteger status;
//paid
@property(nonatomic,assign)NSInteger paid;
//参与时间
@property(nonatomic,copy)NSString *when;
//派奖的时间
@property(nonatomic,copy)NSString *settle_time;
@end

NS_ASSUME_NONNULL_END
