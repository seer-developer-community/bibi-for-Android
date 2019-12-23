//
//  TrAccountModel.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/6.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrAccountModel : NSObject

@property(nonatomic,assign) NSInteger gongCount;

@property(nonatomic,assign)long long feerCount;

@property(nonatomic,copy)NSString *dataTime;

@property(nonatomic,copy)NSString *fromnName;

@property(nonatomic,copy)NSString *tooName;

@property(nonatomic,assign)long long jinerCount;

@property(nonatomic,copy)NSString *ass_id;

@end

NS_ASSUME_NONNULL_END
