//
//  CZNetWorkTool.h
//  NewsBoard
//
//  Created by Apple on 16/4/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void(^CompleteBlock)(id result);

@interface CZNetWorkTool : AFHTTPSessionManager

+ (instancetype)sharedNetWorkTool;

/**
 *  供所有模型调用
 *
 *  @param URLString     URLString
 *  @param completeBlock 完成Block
 */
- (void)objectWithURLString:(NSString *)URLString with:(NSDictionary *)dic completeBlock:(CompleteBlock)completeBlock;


-(void)GetobjectWithURLString:(NSString *)URLString with:(NSDictionary *)dic completeBlock:(CompleteBlock)completeBlock;

@end
