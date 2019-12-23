//
//  OrderContention.m
//  BiBi
//
//  Created by 武建斌 on 2019/4/12.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "OrderContention.h"
#import "NSObject+DataToObject.h"
@implementation OrderContention


- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
        return;
    }
//    if ([key isEqualToString:@"items"]) {
//        [self setValue:value forKey:@"items_order"];
//        self.items_order = [OrderToclass generateFromDataArray:value];
//        return;
//    }
 
//    - (void)setValue:(id)value forKey:(NSString *)key {
//        if ([value isKindOfClass:[NSNull class]]) return;
//
//        if ([key isEqualToString:@"votes"]) {
//            self.votes = [VoteIdObject generateFromDataArray:value];
//            return;
//        }
//
//        value = [self defaultGetValue:value forKey:key];
//
//        [super setValue:value forKey:key];
//    }
    
    //    NSArray *array = @[@"final_result",@"committee_result",@"oracle_sets"];
    //    if ([array containsObject:key]) {
    //        [super setValue:[ObjectId generateFromDataArray:value] forKey:key];
    //        return;
    //    }
    
    id obj = [self defaultGetValue:value forKey:key];
    
    if (!obj) obj = value;
    
    [super setValue:obj forKey:key];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (instancetype)generateFromObject:(id)object {
    if (![object isKindOfClass:[NSDictionary class]]) return nil;
    
    return [[self alloc] initWithDic:object];
}
//
- (id)generateToTransferObject {
    NSMutableDictionary *dic = [[self defaultGetDictionary] mutableCopy];
    
    dic[@"id"] = dic[@"identifier"];
    
    dic[@"identifier"] = nil;
    dic[@"items"] = dic[@"items_order"];
    
    dic[@"items_order"] = nil;
    
    
    
    return [dic copy];
}


@end
