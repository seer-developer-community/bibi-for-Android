//
//  MLNetworkTool.m
//  AlongChat
//
//  Created by yuanbo on 2017/8/28.
//  Copyright © 2017年 AlongChat. All rights reserved.
//

#import "MLNetworkTool.h"

//#import "HAXAuthSign.h"
//#import "MLViewController.h"
//#import "Common.h"
static MLNetworkTool *instance;
static NSString * const NewsBoardBaseURLString = @"http://c.m.163.com/nc/";
@implementation MLNetworkTool


+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 15;
        instance = [[MLNetworkTool alloc] initWithSessionConfiguration:configuration];
    
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
        
        instance.responseSerializer = [AFJSONResponseSerializer serializer];
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
//
        [instance .requestSerializer setTimeoutInterval:15];
        AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
        [securityPolicy setAllowInvalidCertificates:YES];
    });
    
    return instance;
}

#pragma mark - post 不判断错误码
- (void)postWithMethod:(NSString *)method Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock {
    
//    NSString *path = [MLURL stringByAppendingString:method];
    [instance POST:method parameters:paragmeter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject && sucessBlock) {
                             sucessBlock(responseObject);
                         }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
                NSLog(@"%@",error);

    }];
    
    

}

#pragma mark - post 判断错误码 获取用户信息

-(void)postWithCodeController:(id)targer Method:(NSString *)method Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock CodeFailuer:(CodeFailure)codeFailure Failrue:(Failure)failureBlock {
    
//    if(![[MLUserInfoModel sharedManager] isInitUserInfoModel]){
//        [self getUserInfo];
//    }
//
//    NSString *path = [MLURL stringByAppendingString:method];
//    USERDEFAULTS
//     NSMutableDictionary * paramDic  = [HAXAuthSign generateURLParams:@"POST" requestURL:path params:[NSMutableDictionary dictionaryWithDictionary:paragmeter] consumerKey:CONSUMER_KEY consumerKeySecret:CONSUMER_SECRET accessToken:[userDefault objectForKey:ACCESSTOKEN] tokenSecret:[userDefault objectForKey:TOKENSECRET]];
//    if (paragmeter) {
//        [paramDic addEntriesFromDictionary:paragmeter];
//    }
//
//    [instance POST:path parameters:paramDic.copy progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (responseObject) {
//            MLLog(@"paragmeter-----%@",paramDic);
//            MLLog(@"url----%@",path);
//            MLLog(@"%@",responseObject);
//            [MLNetCodeManager netReturnCodeManager:targer Code:[responseObject[@"err_code"] intValue] Messager:responseObject[@"err_msg"] CodeSuccess:^{
//                [YBProgressHUD hide];
//                if(sucessBlock){
//                    sucessBlock(responseObject);
//                }
//            } CodeFailure:^{
//
//                if(codeFailure){
//                    codeFailure();
//                }
//
//            }];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        if(failureBlock && error){
//            failureBlock(error);
//        }
//    }];

}

#pragma mark - 图片上传
-(void)postUpdatePic:(NSString *)method userPic:(UIImage *)image Paragmeter:(NSDictionary *)paragmeter Sucess:(Success)sucessBlock Failrue:(Failure)failureBlock {
    
//    NSString *path = [MLURL stringByAppendingString:method];
//
//    [instance POST:path parameters:paragmeter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:UIImageJPEGRepresentation(image,0.5) name:@"_ef1" fileName:@"_ef1" mimeType:@"image/png"];
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        if (responseObject && sucessBlock) {
//            sucessBlock(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//        if(failureBlock && error){
//            failureBlock(error);
//        }
//    }];
//        NSLog(@"%@",responseObject);
////         [YBProgressHUD hide];
//        if([responseObject[@"err_code"] intValue]  == CODE_SUCCESSH){
//            if (responseObject && sucessBlock) {
//                sucessBlock(responseObject);
//            }
//        }else if([responseObject[@"err_code"] intValue]  == 4444||[responseObject[@"err_code"] intValue]  == 7777){
//            [UIApplication sharedApplication].keyWindow.rootViewController = [[MLViewController alloc]init];
//            [YBProgressHUD showMsgWithoutView:responseObject[@"err_msg"]];
//
//        } else {
//            [YBProgressHUD showMsgWithoutView:responseObject[@"err_msg"]];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if(failureBlock && error){
//            failureBlock(error);
//        }
////        [YBProgressHUD showMsgWithoutView:REQUESTERRORMESSAGE];
//    }];
}

#pragma mark - 获取用户信息
- (void)getUserInfo{
//    USERDEFAULTS
//    NSString *qd=[[NSBundle mainBundle] infoDictionary][@"qd"];
//    [self postWithMethod:GETUSERINFO Paragmeter:@{@"uid":[userDefault objectForKey:USERID],@"channel":qd,@"version":@"1"} Sucess:^(id responseObject) {
//        if(responseObject[@"result"]){
//            MLLog(@"%@",responseObject);
//            [[MLUserInfoModel sharedManager] setUserInfoWithDict:responseObject[@"result"][@"userInfo"]];
//            [[MLUserInfoModel sharedManager] setUserInfoWithDict:responseObject[@"result"][@"accountInfo"]];
//            [[MLUserInfoModel sharedManager] setUserInfoWithDict:responseObject[@"result"][@"levelInfo"]];
//            [userDefault setObject:responseObject[@"result"] forKey:USERINFO];
//        }
//    } Failrue:^(NSError *error) {
//        if ([userDefault objectForKey:USERINFO]) {
//            [[MLUserInfoModel sharedManager] setUserInfoWithDict:[userDefault objectForKey:USERINFO][@"userInfo"]];
//            [[MLUserInfoModel sharedManager] setUserInfoWithDict:[userDefault objectForKey:USERINFO][@"accountInfo"]];
//            [[MLUserInfoModel sharedManager] setUserInfoWithDict:[userDefault objectForKey:USERINFO][@"levelInfo"]];
//            [[MLUserInfoModel sharedManager] setInitUserInfoModel:NO];
//        }
//    }];
}




@end
