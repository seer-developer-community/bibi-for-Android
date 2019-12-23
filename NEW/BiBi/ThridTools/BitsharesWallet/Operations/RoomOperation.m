//
//  RoomOperation.m
//  BiBi
//
//  Created by chouheiwa on 2018/12/21.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "RoomOperation.h"
#import "NSObject+DataToObject.h"
#import "AssetAmountObject.h"
#import "AssetObject.h"
#import "ObjectId.h"
#import "PackData.h"
@implementation RoomOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
        _input = @[];
        _input1 = @[];
        _input2 = @[];
    }
    return self;
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    value = [self defaultGetValue:value forKey:key];
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (instancetype)generateFromObject:(id)object {
    if (![object isKindOfClass:[NSDictionary class]]) return nil;
    
    return [[self alloc] initWithDic:object];
}

- (id)generateToTransferObject {
    return [self defaultGetDictionary];
}

- (NSData *)transformToData {
    NSMutableData *data = [NSMutableData dataWithCapacity:200];
//    if (!self.fee) {
//        [data appendData:[[[AssetAmountObject alloc] initFromAssetId:[ObjectId generateFromObject:@"1.3.0"] amount:0] transformToData]];
//    }else {
//
//        [data appendData:[self.fee transformToData]];
//    }
    [data appendData:[self.fee transformToData]];
    
    [data appendData:_issuer.transformToData];
    
    [data appendData:_room.transformToData];
    
    [data appendData:[self packOneBytes:_type]];
    
    [data appendData:[PackData packUnsigedInteger:_input.count]];
    
    for (NSNumber *number in _input) {
        [data appendData:[self packOneBytes:number.integerValue]];
    }
    
    // 这里需要等以后更新
    [data appendData:[PackData packUnsigedInteger:_input1.count]];
    
    for (NSSet *set in _input1) {
        NSAssert([set isKindOfClass:[NSSet class]], @"This class is not set");
        [data appendData:[PackData packUnsigedInteger:set.count]];
        
        for (NSNumber *value in set) {
            [data appendData:[self packOneBytes:value.integerValue]];
        }
    }
    
    [data appendData:[PackData packUnsigedInteger:_input2.count]];
    
    for (NSArray *array in _input2) {
        NSAssert([array isKindOfClass:[NSArray class]], @"This class is not array");
        [data appendData:[PackData packUnsigedInteger:array.count]];
        for (NSNumber *value in array) {
            [data appendData:[self packOneBytes:value.integerValue]];
        }
    }
    
    [data appendData:[PackData packLongValue:_amount]];
    
    return [data copy];
}
- (AssetAmountObject *)caculateFeeWithFeeDic:(NSDictionary *)feeDictionary payFeeAsset:(AssetObject *)asset {
    long baseAmount = [feeDictionary[@"fee"] integerValue];
    if ([asset.symbol isEqualToString:@"USDT"]) {
        baseAmount = 10;
    }else if ([asset.symbol isEqualToString:@"PFC"]){
         baseAmount = 665;
    }
    return [[AssetAmountObject alloc] initFromAssetId:asset.identifier amount:baseAmount];
}

- (NSData *)packOneBytes:(NSInteger)value {
    NSMutableData *data = [NSMutableData dataWithCapacity:1];
    
    Byte b = (Byte)(value & 0xff);
    
    [data appendBytes:&b length:1];
    
    return [data copy];
}

@end
