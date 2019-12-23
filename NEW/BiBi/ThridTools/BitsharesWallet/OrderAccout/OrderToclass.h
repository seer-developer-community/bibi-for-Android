//
//  OrderToclass.h
//  BiBi
//
//  Created by 武建斌 on 2019/4/12.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderToclass : NSObject<ObjectToDataProtocol>
//代码块
//block_num":280975,
//"when":"2019-04-01T06:25:24",
//"amount":450000,
//"paid":500000,
//"sequence":0
@property(nonatomic,assign)NSInteger block_num;
//时间
@property(nonatomic,copy)NSString *when;
//订单金额
@property(nonatomic,assign)float amount;

//paid
@property(nonatomic,assign)float paid;

//sequence
@property(nonatomic,assign)NSInteger sequence;
@end

NS_ASSUME_NONNULL_END
