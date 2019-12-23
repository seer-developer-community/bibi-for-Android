//
//  CallBackModel.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/17.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallBackModel : NSObject

@property (nonatomic, copy, nonnull) void(^successResult)(id _Nullable result);

@property (nonatomic, copy, nullable) void(^errorResult)(NSError * _Nullable error);

@property (nonatomic, copy, nullable) void(^noticeResult)(id _Nullable result);

@end
