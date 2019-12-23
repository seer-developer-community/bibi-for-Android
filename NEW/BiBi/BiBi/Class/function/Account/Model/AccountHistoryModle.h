//
//  AccountHistoryModle.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/5.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface AccountHistoryModle : NSObject<ObjectToDataProtocol>

@property(nonatomic,strong)NSArray * op;

@property(nonatomic,copy)NSString * identifier;

@property(nonatomic,strong)NSArray *result;

@property(nonatomic,copy)NSString * block_num;

@property(nonatomic,copy)NSString *trx_in_block;

@property(nonatomic,copy)NSString *op_in_trx;

@property(nonatomic,copy)NSString *virtual_op;



@end

NS_ASSUME_NONNULL_END
