//
//  AdvancedOption.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/24.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"


@interface AdvancedOption : NSObject<ObjectToDataProtocol>

@property(nonatomic,assign)NSInteger pool;

@property(nonatomic,strong)NSArray *awards;

@end


