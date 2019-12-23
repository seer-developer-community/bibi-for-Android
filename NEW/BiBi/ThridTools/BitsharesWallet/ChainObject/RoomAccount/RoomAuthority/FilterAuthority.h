//
//  FilterAuthority.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/20.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilterAuthority : NSObject

@property(nonatomic,assign)NSInteger reputation;

@property(nonatomic,assign)NSInteger guaranty;

@property(nonatomic,assign)NSInteger volume;
@end

NS_ASSUME_NONNULL_END
