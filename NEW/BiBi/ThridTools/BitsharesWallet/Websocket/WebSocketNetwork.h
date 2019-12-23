//
//  WebSocketNetwork.h
//  SRWebSocketDemo
//
//  Created by jiahao on 2016/11/29.
//  Copyright © 2016年 SILICN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRWebSocket.h"
#import "BitsharesWalletError.h"
#import "WebsocketBlockChainApi.h"
#import "UploadBaseModel.h"
@class CallBackModel;
@class UploadParams;

typedef NS_ENUM(NSInteger,WebSocketStatus)
{
    WebSocketStatusConnecting = 0,
    WebSocketStatusConnected,
    WebSocketStatusConnectFail,
    WebSocketStatusLoseConnect
};


@protocol SLWebSocketDelegate <NSObject>

@optional

- (void)onLogin:(WebSocketStatus)state;

- (void)webSocketDidReceivedMessage:(id)message;


@end


@interface WebSocketNetwork : NSObject <SRWebSocketDelegate>


@property (nonatomic, assign) WebSocketStatus status;

//人家的

@property (nonatomic, assign) id <SLWebSocketDelegate>delegate;

@property (nonatomic, assign, readonly) WebsocketConnectStatus connectStatus;

@property (nonatomic, copy) void (^connectStatusChange)(WebsocketConnectStatus connectStatus);

@property (nonatomic, copy, readonly) NSString *connectedUrl;

//@property (nonatomic, assign) id <SLWebSocketDelegate>delegate;

//- (instancetype)initWithUrl:(NSString *)url closedCallBack:(void (^) (NSError *error))closedCallBack;

//- (void)connectWithTimeOut:(NSTimeInterval)timeOut;


+ (instancetype)shareInstance;

- (instancetype)shareInstance;

- (void)startConnect;


- (void)sendMessage:(NSDictionary *)message;

- (void)sendWithChainApi:(WebsocketBlockChainApi)chainApi method:(WebsocketBlockChainMethodApi)method params:(UploadParams *)uploadParams callBack:(CallBackModel *)callBack;

@end
