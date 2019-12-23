




//
//  JBProtocol.m
//  new
//
//  Created by 陈彦松 on 2018/11/28.
//  Copyright © 2018年 cmbc. All rights reserved.
//

#import "JBProtocol.h"
#import "AFNetworking.h"
#define protocolKey @"JBSessionProtocolKey"

@interface JBProtocol ()<NSURLSessionDataDelegate,NSURLSessionDelegate>
@property (nonatomic, strong) NSURLSession * session;

@end

@implementation JBProtocol
+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    NSLog(@"\n====\nFireflySessionURLProtocol 请求地址：%@\n====\n", [request URL].absoluteString);
    /*
     防止无限循环，因为一个请求在被拦截处理过程中，也会发起一个请求，这样又会走到这里，如果不进行处理，就会造成无限循环
     */
    if ([NSURLProtocol propertyForKey:protocolKey inRequest:request]) {
        return NO;
    }
    return YES;
}

- (void)startLoading
{
    NSMutableURLRequest * request = [self.request mutableCopy];
    
    // 表示该请求已经被处理，防止无限循环
    [NSURLProtocol setProperty:@(YES) forKey:protocolKey inRequest:request];
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue currentQueue]];
    NSURLSessionDataTask * task = [self.session dataTaskWithRequest:request];
    [task resume];
}

#pragma mark - NSURLSessionDelegate method

- (void)URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler
{
//    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
//    {
//        AFSecurityPolicy * tmpSecutiry = [AFSecurityPolicy defaultPolicy];
//        tmpSecutiry.allowInvalidCertificates = YES;
//        tmpSecutiry.validatesDomainName = NO;
//        if ([tmpSecutiry evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host])
//        {
//            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
//            [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
//            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
//        }
//        else
//        {
//            [[challenge sender] cancelAuthenticationChallenge:challenge];
//            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge,nil);
//        }
//    }
//    else
//    {
//        [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
//        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling,nil);
//    }
}


#pragma mark - NSURLSessionDataDelegate method

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.client URLProtocol:self didLoadData:data];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse *cachedResponse))completionHandler
{
    completionHandler(proposedResponse);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error)
    {
        [self.client URLProtocol:self didFailWithError:error];
    }
    else
    {
        [self.client URLProtocolDidFinishLoading:self];
    }
}



@end
