//
//  OPModel.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/5.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "OPModel.h"
#import "NSObject+DataToObject.h"
@implementation OPModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

//不知道这一步干啥的


//- (void)setValue:(id)value forKey:(NSString *)key {
//    if ([value isKindOfClass:[NSNull class]]) return;
//
//    if ([key isEqualToString:@"votes"]) {
//        self.votes = [VoteIdObject generateFromDataArray:value];
//        return;
//    }




- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}




+ (instancetype)generateFromObject:(NSDictionary *)object {
    if (![object isKindOfClass:[NSDictionary class]]) return nil;
    
    return [[self alloc] initWithDic:object];
}

- (id)generateToTransferObject {
    return [self defaultGetDictionary];
}

@end
