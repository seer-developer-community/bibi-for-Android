//
//  PlatAccount.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/23.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
@class ObjectId;
NS_ASSUME_NONNULL_BEGIN

@interface PlatAccount : NSObject<ObjectToDataProtocol>

@property(nonatomic,strong)ObjectId *owner;

@property(nonatomic,copy)NSString *script;

@property(nonatomic,assign)NSInteger volume;

@property(nonatomic,assign)NSInteger collected_fees;

@property(nonatomic,strong)NSArray<ObjectId *> *finished_rooms;

@property(nonatomic,strong)NSArray *rooms;

@property(nonatomic,copy)NSString *description_des;

@property(nonatomic,assign)NSInteger reputation;

@property(nonatomic,copy)NSString *guaranty;

@end

NS_ASSUME_NONNULL_END
