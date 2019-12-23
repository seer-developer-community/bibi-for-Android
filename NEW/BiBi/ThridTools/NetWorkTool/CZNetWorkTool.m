//
//  CZNetWorkTool.m
//  NewsBoard
//
//  Created by Apple on 16/4/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CZNetWorkTool.h"
#import "AFNetworking.h"

@implementation CZNetWorkTool

static NSString * const NewsBoardBaseURLString = @"http://c.m.163.com/nc/";

static CZNetWorkTool *_instance;
+ (instancetype)sharedNetWorkTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html
        _instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:NewsBoardBaseURLString]];
        
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil];
//        
//        _instance.responseSerializer.acceptableContentTypes = [_instance.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//        _instance.responseSerializer.acceptableContentTypes = [_instance.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        
        
        
    });
    
    return _instance;
}

- (void)objectWithURLString:(NSString *)URLString  with:(NSDictionary *)dic completeBlock:(CompleteBlock)completeBlock{
    

    
    _instance.responseSerializer = [AFJSONResponseSerializer serializer];
    _instance.requestSerializer = [AFJSONRequestSerializer serializer];
    [_instance.requestSerializer setValue:@"HEADER VALUE" forHTTPHeaderField:@"HEADER"];

    
    
    
    [self POST:URLString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completeBlock!=nil){
            completeBlock(responseObject);
       
            NSLog(@"请求成功");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        
        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
        NSLog(@"Failure error serialised - %@",serializedData);
    }];
}


-(void)GetobjectWithURLString:(NSString *)URLString with:(NSDictionary *)dic completeBlock:(CompleteBlock)completeBlock{
    
    [self GET:URLString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completeBlock!=nil){
            completeBlock(responseObject);
            
            NSLog(@"请求成功");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        
        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
        NSLog(@"Failure error serialised - %@",serializedData);
        
        
    }];
    
}

@end
