//  SF_FrameWork
//  明知是意外
//  Created by Knowing that it was an accident

#import "NetworkJudgmentTool.h"

@interface NetworkJudgmentTool() {
    BOOL _isRuning;
}

@property (nonatomic, assign) NetworkReachabilityStatus networkStatus;

@end

@implementation NetworkJudgmentTool
//SFSingletonM(NetworkJudgmentTool)

- (NetworkReachabilityStatus)start {
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //2.监听改变
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown          = -1,
         AFNetworkReachabilityStatusNotReachable     = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        NSLog(@"当前状态----------------%zd",_networkStatus);
        //断线重连
        BOOL noNetWork;
        if ((_networkStatus == NetworkReachabilityStatusUnknown) ||
             (_networkStatus == NetworkReachabilityStatusNotReachable)) {
            noNetWork = YES;
        }else {
            noNetWork = NO;
        }
        BOOL afnNetWork;
        if ((status == AFNetworkReachabilityStatusReachableViaWWAN) ||
            (status ==
            AFNetworkReachabilityStatusReachableViaWiFi)) {
                afnNetWork = YES;
            }else {
                afnNetWork = NO;
            }
        if (noNetWork && afnNetWork && _isRuning) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkDisconnectionReconnectionNotification object:@(status) userInfo:nil];
        }
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                _networkStatus = NetworkReachabilityStatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                 _networkStatus = NetworkReachabilityStatusNotReachable;
                //NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                 _networkStatus = NetworkReachabilityStatusReachableViaWWAN;
                //NSLog(@"3G|4G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                 _networkStatus = NetworkReachabilityStatusReachableViaWiFi;
                //NSLog(@"WiFi");
                break;
        }
        BOOL is_netWork;
        if (_networkStatus == -1 || _networkStatus== 0) {
            is_netWork = NO;
        }else {
            is_netWork = YES;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkStatusChangeNotification object:@(is_netWork) userInfo:nil];
        //在block中记录运行状态 开启监控会执行startMonitoring后代码
        _isRuning = YES;
    }];
    // 开始监控
    [manager startMonitoring];
    return _networkStatus;
}

//+ (NetworkReachabilityStatus)status {
////    return [[NetworkJudgmentTool sharedNetworkJudgmentTool] start];
//}

+ (BOOL)isNetWorking {
    if ([NetworkJudgmentTool status] ==
        NetworkReachabilityStatusUnknown ||
        [NetworkJudgmentTool status] ==NetworkReachabilityStatusNotReachable ) {
        return NO;
    }
    return YES;
}

+ (BOOL)isMobileData {
    return [NetworkJudgmentTool status] ==
    NetworkReachabilityStatusReachableViaWWAN ? YES:NO;
}

+ (BOOL)isWiFi {
    return [NetworkJudgmentTool status] ==
    NetworkReachabilityStatusReachableViaWiFi ? YES:NO;
}

@end
