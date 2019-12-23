//
//  RoomAuthority.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/19.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
#import "FilterAuthority.h"
@class ObjectId;
NS_ASSUME_NONNULL_BEGIN

@interface RoomAuthority : NSObject<ObjectToDataProtocol>

@property(nonatomic,assign)NSInteger result_owner_percent;

@property(nonatomic,assign)NSInteger reward_per_oracle;

@property(nonatomic,strong)ObjectId * accept_asset;

@property(nonatomic,assign)NSInteger minimum;

@property(nonatomic,assign)NSInteger maximum;

@property(nonatomic,copy)NSString *start;

@property(nonatomic,copy)NSString *stop;

@property(nonatomic,assign)NSInteger input_duration_secs;

//里面什么也没有
@property(nonatomic,strong)NSArray<ObjectId *> *allowed_oracles;


@property(nonatomic,strong)NSArray<ObjectId *> *allowed_countries;

@property(nonatomic,strong)NSArray<ObjectId *> *allowed_authentications;

@end

NS_ASSUME_NONNULL_END
