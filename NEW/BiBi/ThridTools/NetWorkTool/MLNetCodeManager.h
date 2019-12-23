//
//  MLNetCodeManager.h
//  AlongChat
//
//  Created by yuanbo on 2017/9/1.
//  Copyright © 2017年 AlongChat. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CodeSuccess)();
typedef void(^CodeFailure)();

@interface MLNetCodeManager : NSObject

+ (void)netReturnCodeManager:(id)targer Code:(int)code Messager:(NSString *)messager CodeSuccess:(CodeSuccess)codeSuccess CodeFailure:(CodeFailure)codeFailure;

@end
