//
//  Participators.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/8.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface Participators : NSObject<ObjectToDataProtocol>
//"player":"1.2.14210",
//"block_num":6728632,
//"when":"2019-01-08T06:09:00",
//"amount":4000000,
//"paid":4000000,
//"sequence":1,
//"reward":0
@property(nonatomic,copy)NSString *player;

@property(nonatomic,assign)NSInteger block_num;
//下注时间
@property(nonatomic,copy)NSString * when;
//下注金额
@property(nonatomic,assign)float amount;
//paid
@property(nonatomic,assign)float paid;

@property(nonatomic,assign)NSInteger sequence;

//
@property(nonatomic,assign) float reward;







@end

NS_ASSUME_NONNULL_END
