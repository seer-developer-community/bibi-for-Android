//  SF_FrameWork
//  明知是意外
//  Created by Knowing that it was an accident

#import "AFNetworking.h"
//#import "SFSingleton.h"

/** 网络状态改变 */
#define kNetworkStatusChangeNotification @"NetworkStatusChangeNotification"
/** 断线重连 */
#define kNetworkDisconnectionReconnectionNotification @"NetworkDisconnectionReconnectionNotification"


typedef NS_ENUM(NSInteger, NetworkReachabilityStatus) {
    NetworkReachabilityStatusUnknown          = -1,
    NetworkReachabilityStatusNotReachable     = 0,
    NetworkReachabilityStatusReachableViaWWAN = 1,
    NetworkReachabilityStatusReachableViaWiFi = 2,
};

@interface NetworkJudgmentTool : NSObject

//SFSingletonH(NetworkJudgmentTool)
//- (NetworkReachabilityStatus)start;
+ (NetworkReachabilityStatus)status;
/** 是否有网络 */
+ (BOOL)isNetWorking;
/** 是否是移动数据 */
+ (BOOL)isMobileData;
/** 是否是WiFi */
+ (BOOL)isWiFi;

@end
