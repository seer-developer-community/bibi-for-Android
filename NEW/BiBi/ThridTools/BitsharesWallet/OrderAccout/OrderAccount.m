//
//  OrderAccount.m
//  BiBi
//
//  Created by 武建斌 on 2019/4/10.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "OrderAccount.h"
#import "ObjectId.h"
#import "NSObject+DataToObject.h"

@implementation OrderAccount

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    //    if ([key isEqualToString:@"description"]) {
    //        [self setValue:value forKey:@"description_des"];
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

- (id)generateToTransferObject {
    NSMutableDictionary *dic = [[self defaultGetDictionary] mutableCopy];
    
    //    dic[@"description"] = dic[@"description_des"];
    //
    //    dic[@"description_des"] = nil;
    
    return [dic copy];
}
@end
