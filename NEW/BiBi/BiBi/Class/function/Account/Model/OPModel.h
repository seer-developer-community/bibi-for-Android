//
//  OPModel.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/5.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
//@class AssetAmountObject;
#import "AssetAmountObject.h"
NS_ASSUME_NONNULL_BEGIN

@interface OPModel : NSObject<ObjectToDataProtocol>

@property(nonatomic,copy)NSString *from;

@property(nonatomic,copy)NSString *to;

@property (nonatomic, strong, nonnull) AssetAmountObject *fee;

@property (nonatomic, strong, nonnull) AssetAmountObject *amount;

@property(nonatomic,strong)NSArray *extensions;



@end

NS_ASSUME_NONNULL_END
