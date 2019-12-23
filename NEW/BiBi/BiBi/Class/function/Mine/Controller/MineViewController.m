//
//  MineViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/11/21.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "MineViewController.h"
#import "BitsharesWalletObject.h"
#import "BrainKey.h"
#import "CZNetWorkTool.h"
#import "MLNetworkTool.h"
#import "PublicKey.h"
#import "BaseConfig.h"
#import "BitsharesWalletObject.h"
#import "HYBNetworking.h"
//#import "AFNetworkActivityIndicatorManager.h"
//#import "AFNetworking.h"
//#import "AFHTTPSessionManager.h"
@interface MineViewController ()

@end

@implementation MineViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [BaseConfig setPrefix:@"SEER"];
    
     self.view.backgroundColor = [UIColor blueColor];
    
    BitsharesWalletObject *walltObject = [[BitsharesWalletObject alloc]init];
    
    BrainKey *brainKey = [walltObject suggestBrainKey];
    
    
    BrainKey *brainKey2 = [[BrainKey alloc] init];
    
    brainKey2.pubKey = brainKey.pubKey;
    
    brainKey2.brainKey = brainKey.brainKey;
    
//    NSLog(@"这个助词%@",brainKey2.brainKey);
//    NSLog(@"这个公钥%@",brainKey2.pubKey);
    
    [self qingqiu];
    
//    [self qing];

    // 配置请求和响应类型，由于部分伙伴们的服务器不接收JSON传过去，现在默认值改成了plainText
//    [HYBNetworking configRequestType:kHYBRequestTypePlainText
//                        responseType:kHYBResponseTypeJSON
//                 shouldAutoEncodeUrl:YES
//             callbackOnCancelRequest:NO];

    // 设置GET、POST请求都缓存
//    [HYBNetworking cacheGetRequest:YES shoulCachePost:YES];
    
    // 测试POST API：
    // 假数据




//    NSString *myUrlString= @"http://www.seerapi.com/api/v1/accounts";
////        NSString *myUrlString= @"https://www.baidu.com";
//
//    NSMutableDictionary* postRequestDictionary = [[NSMutableDictionary alloc] init];
//
//    NSLog(@"body = %@",postRequestDictionary);
//
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
//
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"HEADER VALUE" forHTTPHeaderField:@"HEADER"];
//
//    //   ... ADD ANYMORE HEADER IF YOU WANT ...
//
//
//    [manager POST:myUrlString parameters: parmst constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        NSLog(@"错误");
//        NSLog(@"%@",error);
//        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
//
//        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
//        NSLog(@"Failure error serialised - %@",serializedData);
//
//
//    }];













  //水龙头地址  @"http://faucet.seerchain.org"


//    https://www.seerapi.com/api/v1/accounts
    NSString *path =@"https://www.seerapi.com/api/v1/accounts";
    // 由于这里有两套基础路径，用时就需要更新
//    [HYBNetworking updateBaseUrl:@"http://data.zz.baidu.com"];
    // 每次刷新缓存
    // 如果获取到的业务数据是不正确的，则需要下次调用时设置为YES,表示要刷新缓存
//    // HYBURLSessionTask *task =
////    [HYBNetworking postWithUrl:path refreshCache:YES params:@{
////                                                               @"account":@{
////                                                                      @"name":@"wujian789",
////                                                                      @"owner_key":brainKey.pubKey,
////                                                                      @"active_key":brainKey.pubKey,
////                                                                      @"memo_key":brainKey.pubKey,
////                                                                      @"refcode":@"",
////                                                                      @"referrer":@""
////                                                                           }
////
////     }
////
////
////                       success:^(id response) {
////
////        NSLog(@"%@",response);
////
////    } fail:^(NSError *error) {
////        NSLog(@"%@",error);
////
////        NSLog(@"失败了");
////
////    }];
//
//
//    NSMutableDictionary *params   = [NSMutableDictionary dictionary];
//
//
//    params[@"owner_key"] = @"SEER7Vj9ieyedER8UQCDvrmE8rtmiwGZ8S44LFRRBsJPCgEUpojLNd";
//    params[@"active_key"] = @"SEER7Vj9ieyedER8UQCDvrmE8rtmiwGZ8S44LFRRBsJPCgEUpojLNd";
//    params[@"name"] = @"yansongcheng456";
//    params[@"memo_key"] = @"SEER7Vj9ieyedER8UQCDvrmE8rtmiwGZ8S44LFRRBsJPCgEUpojLNd";
//    params[@"refcode"] = @"";
//    params[@"referrer"] = @"";
//
//
//
//
//
//
//
//
//
////    params[@"name"] = @"wubin123";
////    params[@"ownerkey"] =brainKey2.pubKey;
////    params[@"activekey"] = brainKey2.pubKey;
////    params[@"memokey"] = brainKey2.pubKey;
////    params[@"refcode"] = @"";
////    params[@"referrer"] = @"";
//
//
//
//    //    NSLog(@"这个字典是多少%@",params);
//
////    NSMutableDictionary *parmst = [NSMutableDictionary dictionary];
//
////    parmst[@"account"] = params;
//
//
////    NSLog(@"这个字典是多少%@",parmst);
////
//
//
//
////      NSString *jsonString = @"{\"name\":\"yansongcheng456\",\"active_key\":\"SEER6cLcofCe6r9e3W7HdJzyS1hDUywjPvxqT58DwUuVVe2o7fBEni\",\"owner_key\":\"SEER6cLcofCe6r9e3W7HdJzyS1hDUywjPvxqT58DwUuVVe2o7fBEni\",\"memo_key\":\"SEER6cLcofCe6r9e3W7HdJzyS1hDUywjPvxqT58DwUuVVe2o7fBEni\",\"refcode\":[],\"referrer\":[]}";
////
////    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingAllowFragments) error:nil];
////
////
////    [HYBNetworking postWithUrl:path refreshCache:YES params:dic success:^(id response) {
////
////        NSLog(@"这个正确返回%@",response);
////
////    } fail:^(NSError *error) {
////        NSLog(@"这个错误代码%@",error);
////
////    }];
////
//////    NSString *urlString = @"https://www.seerapi.com/api/v1/accounts";
////
////
//////    NSError *error;
//////
//////    NSData * jsonData  =  [NSJSONSerialization dataWithJSONObject: parmst options:NSJSONWritingPrettyPrinted error:&error];  //第一步，字典转数据
//////
//////    NSString *jsonString = [[NSString alloc]initWithData: jsonData encoding:NSUTF8StringEncoding];  //第二部，数据转JSON
//////
//////    NSString *outerJson = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];  //第三步，处理JSON，去掉“\”转义
//////
//////    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];  //定义新字典存参
//////
//////    dictionary[@"data"] = outerJson;  //将处理好的JSON存入key中
////
////
////
////
    NSString *urlString =@"http://faucet.seerchain.org/api/v1/accounts";

    NSURL *url = [NSURL URLWithString:urlString];

    //2. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //2.1设置请求方法
    request.HTTPMethod = @"POST";


//
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
//    NSString  * vaule =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    //    NSLog(@"这个字典是多少%@",params);
//
//    NSMutableDictionary *parmst = [NSMutableDictionary dictionary];
//
//     parmst[@"account"] = vaule;

    NSData *data = [NSJSONSerialization dataWithJSONObject: @{

                                                              @"account":@{
                                                                      @"name":@"yansongwu23",
                                                                   @"owner_key":@"SEER722e3ksXQQwTNKHKw5qJvwGcg131KYyUg5a5fGoHpnDcRoc3c2",
                                                                   @"active_key":@"SEER722e3ksXQQwTNKHKw5qJvwGcg131KYyUg5a5fGoHpnDcRoc3c2",
                                                                  @"memo_key":@"SEER722e3ksXQQwTNKHKw5qJvwGcg131KYyUg5a5fGoHpnDcRoc3c2",
                                                                      @"refcode":@"",
                                                                      @"referrer":@""
                                                                      }
                                                             } options:NSJSONWritingPrettyPrinted error:nil];
//
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];


//     [request setValue:@"charset=utf-8" forHTTPHeaderField:@"Content-Type"];

//    [request setValue:[[NSString alloc] initWithFormat:@"text/plain;application/json"] forHTTPHeaderField:@"Content-Type"];
////



    request.HTTPBody = data;
//    //2.2设置请求体
////    NSString *para = [self dealWithParam:parmst];
//    //把string 转data
////    request.HTTPBody = [para dataUsingEncoding:NSUTF8StringEncoding];
//
//
    //3.建立连接发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //4. 解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"这个字典是多少%@",dict);

    }];


    //2. Request

    //2.1设置请求方法

//    NSString *para = [self toJSONSt:params];
//    urlString  = [urlString stringByAppendingString:para];
//
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//     NSURL *url = [NSURL URLWithString:urlString];

//    NSData *nsdata = [urlString  dataUsingEncoding:NSUTF8StringEncoding];
//
//
//
//        // Get NSString from NSData object in Base64
//
//        NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
//
//

//
//     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//
//     [request  setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//
//     request.HTTPMethod = @"POST";
//
//
//
//      NSLog(@"哼哼。。%@",request);



//    request.HTTPBody =


    //2.2设置请求体
//    NSString *para = @"username=zhangsan&password=张";
    //把string 转data
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    NSError *error;
//    NSData *body = [NSJSONSerialization dataWithJSONObject:parmst options:NSJSONWritingPrettyPrinted error:&error];
//    if (error) {
////        MBErrorLog(@"%@", error);
//    }
//    request.HTTPBody = body;



//
//
//      NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                if ([data length] > 0 && connectionError == nil) {
//                        NSString *html = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                        NSLog(@"呵呵。。。%@",html);
//                    }
//                else if ([data length] == 0 && connectionError ==nil ) {
//                        NSLog(@"Nothing was downloaded!");
//                    }
//                else {
//                        NSLog(@"%@",connectionError);
//                    }
//            }];
//
//}



//    //3.建立连接发送请求
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        //4. 解析数据
//    }];
////

//    [self postRequestByServiceUrl:urlString andApi:@"/api/v1/accounts" andParams:parmst andCallBack:^(id obj) {
//
//        NSLog(@"成功");
//
//    }];

}


//- (NSString *)toJSONString:(NSDictionary *)dict
//{
//        NSError *error;
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
//        NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//        str = [NSString stringWithFormat:@"%@",str];
//        return str;
//}

-(NSString *)toJSONSt:(NSDictionary *)dict{
    NSError *error;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

    NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    str = [NSString stringWithFormat:@"%@",str];

    return str;
}



-(NSString *)dealWithParam:(NSDictionary *)param
{
    NSArray *allkeys = [param allKeys];
    
    NSMutableString *result = [NSMutableString string];
    
    for (NSString *key in allkeys) {
        
        NSString *str = [NSString stringWithFormat:@"%@=%@&",key,param[key]];
        
        [result appendString:str];
    }
    
    return [result substringWithRange:NSMakeRange(0, result.length-1)];
    
}


//-(void)postRequestByServiceUrl:(NSString *)service
//                         andApi:(NSString *)api
//                      andParams:(NSDictionary *)params
//                    andCallBack:(void (^)(id obj))callback
//
//{
//    NSString *basePath = [service stringByAppendingString:api];
//
//    NSURL *url = [NSURL URLWithString:basePath];
//
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//
//    [request setHTTPMethod:@"POST"];
//
//    NSString *body = [self dealWithParam:params];
//    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
//
//    // 设置请求体
//    [request setHTTPBody:bodyData];
//
//    // 设置本次请求的提交数据格式
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    // 设置本次请求请求体的长度(因为服务器会根据你这个设定的长度去解析你的请求体中的参数内容)
//    [request setValue:[NSString stringWithFormat:@"%ld",bodyData.length] forHTTPHeaderField:@"Content-Length"];
//
//    // 设置本次请求的最长时间
//    request.timeoutInterval = 20;
//
//    NSURLSession *session = [NSURLSession sharedSession];
//
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//
//        if (dic) {
//            callback(dic);
//        }else
//        {
//
//            callback(error.description);
//        }
//
//
//    }];
//
//
//    [task resume];
//
//
//
//}



//-(void)request: (NSString*)httpUrl withHttpArg: (NSDictionary*)parameters{
//    NSURL *url = [NSURL URLWithString: httpUrl];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
//    [request setHTTPMethod: @"POST"];
//    if (parameters) {
//        if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
//            [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        }
//        [mutableRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:self.writingOptions error:error]];
//    }
//    [NSURLConnection sendAsynchronousRequest: request
//                                       queue: [NSOperationQueue mainQueue]
//                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
//                               if (error) {
//                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
//                               } else {
//                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                   NSLog(@"HttpResponseCode:%ld", responseCode);
//                                   NSLog(@"HttpResponseBody %@",responseString);
//                                   NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                                   NSDictionary *dicjson = (NSDictionary *)json;
//                                   dispatch_async(dispatch_get_main_queue(), ^{
//                                       //刷新UI
//                                   });                               }
//                           }];
//}


-(void)qingqiu{
    
   [HYBNetworking postWithUrl:@"http://faucet.seerchain.org/api/v1/accounts" refreshCache:YES params:@{
                                                                                                       
                                                                                                       @"account":@{
                                                                                                                     @"name":@"yansongbin23",
                                                                                                                     @"owner_key":@"SEER6j7Mc6bU9GYs8JLmySDdhjofWze6MTo6ZsgwAHLkYbR8St5U2z",
                                                                                                                     @"active_key":@"SEER6j7Mc6bU9GYs8JLmySDdhjofWze6MTo6ZsgwAHLkYbR8St5U2z",
                                                                                                                     @"memo_key":@"SEER6j7Mc6bU9GYs8JLmySDdhjofWze6MTo6ZsgwAHLkYbR8St5U2z",
                                                                                                                     @"refcode":@"",
                                                                                                                     @"referrer":@""
                                                                                                                     }}
                                                                                                        success:^(id response) {
                                                                                                            
                                                                                                            if([response isKindOfClass:[NSDictionary class]]){
                                                                                                                
                                                                                                                                        NSDictionary *dict = (NSDictionary *)response;
                                                                                                                                        NSLog(@"这个字典怎么样%@",dict);
                                                                                                                
                                                                                                            }
                                                                                                            
                                                                                                            
                                                                                                        } fail:^(NSError *error) {
                                                                                                            
                                                                                                            
                                                                                                            NSLog(@"这个%@",error);
                                                                                                            
                                                                                                        }];
    
}




//-(void)qing{
//
//
//    //    params[@"name"] = @"wubin123";
//    //    params[@"ownerkey"] = brainKey.pubKey;
//    //    params[@"activekey"] = brainKey.pubKey;
//    //    params[@"memokey"] = brainKey.pubKey;
//    //    params[@"refcode"] = @"";
//    //    params[@"referrer"] = @"";
//      NSMutableDictionary *params   = [NSMutableDictionary dictionary];
//    params[@"owner_key"] = @"SEER7Vj9ieyedER8UQCDvrmE8rtmiwGZ8S44LFRRBsJPCgEUpojLNd";
//    params[@"active_key"] = @"SEER7Vj9ieyedER8UQCDvrmE8rtmiwGZ8S44LFRRBsJPCgEUpojLNd";
//    params[@"name"] = @"yansongcheng456";
//    params[@"memo_key"] = @"SEER7Vj9ieyedER8UQCDvrmE8rtmiwGZ8S44LFRRBsJPCgEUpojLNd";
//    params[@"refcode"] = @"";
//    params[@"referrer"] = @"";
//
//
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
//    NSString  * vaule =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    //    NSLog(@"这个字典是多少%@",params);
//
//    NSMutableDictionary *parmst = [NSMutableDictionary dictionary];
//
//    parmst[@"account"] = vaule;
//
//
//
//    NSString *myUrlString= @"https://www.seerapi.com";
//
//    //    postRequestDictionary[@"YOUR PARAMATER"]= YOUR PARAMETER VALUE;
//    //
//    //  ... ADD ANY MORE PARAMETER IF YOU WANT HERE ...
//
//    NSLog(@"body = %@",parmst);
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    //    [manager.requestSerializer setValue:@"HEADER VALUE" forHTTPHeaderField:@"HEADER"];
//
//    //   ... ADD ANYMORE HEADER IF YOU WANT ...
//
//
//    [manager POST:myUrlString parameters: parmst constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        NSLog(@"错误");
//        NSLog(@"%@",error);
//        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
//
//        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
//        NSLog(@"Failure error serialised - %@",serializedData);
//
//
//    }];
//
//
//}







    
    
    
    


@end
