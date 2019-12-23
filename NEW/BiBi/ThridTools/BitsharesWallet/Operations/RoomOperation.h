//
//  RoomOperation.h
//  BiBi
//
//  Created by Di on 2018/12/21.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseOperation.h"
@class AssetAmountObject;
@class ObjectId;
NS_ASSUME_NONNULL_BEGIN

@interface RoomOperation : BaseOperation

@property (nonatomic, strong, nonnull) AssetAmountObject *fee;

@property (nonatomic, strong, nonnull) ObjectId *issuer;

@property (nonatomic, strong, nonnull) ObjectId *room;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy, nonnull) NSArray <NSNumber *> * input;

@property (nonatomic, copy, nonnull) NSArray <NSSet <NSNumber *>*> * input1;

@property (nonatomic, copy, nonnull) NSArray <NSArray <NSNumber *>*> * input2;

@property (nonatomic, assign) long amount;

@end

NS_ASSUME_NONNULL_END
