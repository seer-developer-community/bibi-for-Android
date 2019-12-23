//
//  MLNetworkTool.h
//  AlongChat
//
//  Created by yuanbo on 2017/8/28.
//  Copyright © 2017年 AlongChat. All rights reserved.
//

#import <AFNetworking.h>
#import "MLNetCodeManager.h"

typedef void(^Success)(id responseObject);
typedef void(^Failure)(NSError *error);
typedef void(^CodeFailureWithParameter)(id error);

@interface MLNetworkTool : AFHTTPSessionManager

+ (instancetype)sharedManager;

- (void)postWithMethod:(NSString *)method Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;

- (void)postWithCodeController:(id)targer Method:(NSString *)method Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure Failrue:(Failure)failureBlock;

- (void)postUpdatePic:(NSString *)method userPic:(UIImage *)image Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock;


@end
