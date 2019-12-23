//
//  RoomAccountOption.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/23.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "RoomAccountOption.h"
#import "ObjectId.h"
#import "NSObject+DataToObject.h"

@implementation RoomAccountOption

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
//    if ([key isEqualToString:@"id"]) {
//        [self setValue:value forKey:@"identifier"];
//        return;
//    }
//    if ([key isEqualToString:@"description"]) {
//        [self setValue:value forKey:@"description_des"];
//        return;
//    }
    
    
    NSArray *array = @[@"allowed_countries",@"allowed_authentications"];
    if ([array containsObject:key]) {
        [super setValue:[ObjectId generateFromDataArray:value] forKey:key];
        return;
    }
    
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
//
//    dic[@"id"] = dic[@"identifier"];
//
//    dic[@"identifier"] = nil;
    
    
    
    return [dic copy];
}



@end
