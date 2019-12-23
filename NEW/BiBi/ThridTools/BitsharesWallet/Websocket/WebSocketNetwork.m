//
//  WebSocketNetwork.m
//  SRWebSocketDemo
//
//  Created by jiahao on 2016/11/29.
//  Copyright © 2016年 SILICN. All rights reserved.
//

#import "WebSocketNetwork.h"
#import "UploadParams.h"
#import "CallBackModel.h"
#import "WebsocketResultModel.h"

#import "WebsocketResultErrorParse.h"

static SRWebSocket * webScoket = nil;


@interface WebSocketNetwork ()

@property (nonatomic, strong) SRWebSocket *webSocket;

@property (nonatomic, strong) NSOperationQueue *delegateQueue;



@property (nonatomic, assign, readonly) NSInteger currentId;
/**
 lock for currentId safy
 */
@property (nonatomic, strong) NSLock *lock;

@property (nonatomic, copy) void (^closeCallBack) (NSError *error);

@property (nonatomic, assign) NSInteger normalApi;

@property (nonatomic, assign) NSInteger dataBaseApi;

@property (nonatomic, assign) NSInteger networkBroadCastApi;

@property (nonatomic, assign) NSInteger historyApi;

@property (nonatomic, strong) NSMutableDictionary <NSNumber *,CallBackModel *>*callDictionary;

@property (nonatomic, strong) NSMutableDictionary <NSNumber *,CallBackModel *>*noticeDictionary;

@property (nonatomic, strong) NSLock *sendLock;


@end


@implementation WebSocketNetwork
@synthesize currentId = _currentId;

+ (instancetype)shareInstance
{
    static WebSocketNetwork *mySocket = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mySocket = [[WebSocketNetwork alloc]init];
    });
    return mySocket;
    
}

- (instancetype)shareInstance
{
    return [[self class] shareInstance];
}


- (id)init
{
    self= [super init];
    if (self) {
        self.delegateQueue = [[NSOperationQueue alloc]init];
        self.delegateQueue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (void)startConnect
{
    if (_webSocket == nil) {
        self.webSocket = [[SRWebSocket alloc]initWithURL:[NSURL URLWithString:@"ws://39.105.189.224/ws"]];
    }
    self.webSocket.delegate = self;
    [self.webSocket open];
    self.webSocket.delegateOperationQueue = self.delegateQueue;
    self.status = WebSocketStatusConnecting;
    
}

- (void)sendMessage:(NSDictionary *)message
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:message options:NSJSONWritingPrettyPrinted error:nil];
    NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    [self.webSocket sendString:msg error:nil];
    
//    [self.webSocket send:msg];
    
}



//- (NSInteger)currentId {
//    [self.lock lock];
//    _currentId ++;
//    [self.lock unlock];
//    return _currentId;
//}

- (void)sendWithChainApi:(WebsocketBlockChainApi)chainApi method:(WebsocketBlockChainMethodApi)method params:(UploadParams *)uploadParams callBack:(CallBackModel *)callBack {
    if (self.webSocket.readyState != SR_OPEN) {
        NSError *error = [NSError errorWithDomain:@"Websocket connected state wrong" code:WebsocketErrorCodeNotConnected userInfo:@{@"Error domain":self.connectedUrl}];
        if (callBack.errorResult) callBack.errorResult(error);
        return;
    }
    
    NSInteger sendID = -1;
    
    switch (chainApi) {
        case WebsocketBlockChainApiNormal:
            sendID = self.normalApi;
            break;
            
        case WebsocketBlockChainApiHistory:
            sendID = self.historyApi;
            break;
        case WebsocketBlockChainApiDataBase:
            sendID = self.dataBaseApi;
            break;
        case WebsocketBlockChainApiNetworkBroadcast:
            sendID = self.networkBroadCastApi;
            break;
    }
    
    if (sendID == -1) {
        NSError *error = [NSError errorWithDomain:@"Websocket api id not found" code:WebsocketErrorCodeApiNotFound userInfo:nil];
        if (callBack.errorResult) callBack.errorResult(error);
        return;
    }
    
    UploadBaseModel *uploadModel = [[UploadBaseModel alloc] init];
    
    uploadModel.identifier = self.currentId;
    
    uploadModel.method = method;
    
    uploadModel.params = uploadParams;
    
    uploadParams.apiId = sendID;
    
    NSDictionary *dic = [uploadModel convertData];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingPrettyPrinted) error:nil];
    
    NSLog(@"websocket send:%@",[[NSString alloc] initWithData:data encoding:4]);
    
    dispatch_queue_t queue =  dispatch_queue_create("chouheiwaBitshares", NULL);
    
    dispatch_async(queue, ^{
        [self.sendLock lock];
        switch (method) {
            case WebsocketBlockChainMethodApiCall:{
                [self.callDictionary setObject:callBack forKey:@(uploadModel.identifier)];
            }
                break;
            case WebsocketBlockChainMethodApiNotice:{
                [self.callDictionary setObject:callBack forKey:@(uploadModel.identifier)];
                [self.noticeDictionary setObject:callBack forKey:@(uploadModel.identifier)];
            }
                break;
        }
        [self.sendLock unlock];
        
        [self.webSocket send:data];
        
        //        [self.websocket sendData:data error:nil];
        
        
    });
}


#pragma mark Receive Messages

/**
 Called when any message was received from a web socket.
 This method is suboptimal and might be deprecated in a future release.
 
 @param webSocket An instance of `SRWebSocket` that received a message.
 @param message   Received message. Either a `String` or `NSData`.
 */
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
   // NSLog(@"%s",__FUNCTION__);
    
}

/**
 Called when a frame was received from a web socket.
 
 @param webSocket An instance of `SRWebSocket` that received a message.
 @param string    Received text in a form of UTF-8 `String`.
 */
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithString:(NSString *)string
{
     NSLog(@"%s",__FUNCTION__);
    NSLog(@"%@   %@",string,[[NSThread currentThread] isMainThread] ? @"Main":@"NoMain");

    if (self.delegate && [self.delegate respondsToSelector:@selector(webSocketDidReceivedMessage:)]) {
        [self.delegate webSocketDidReceivedMessage:string];
    }
    
}

/**
 Called when a frame was received from a web socket.
 
 @param webSocket An instance of `SRWebSocket` that received a message.
 @param data      Received data in a form of `NSData`.
 */
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithData:(NSData *)data
{
     NSLog(@"%s",__FUNCTION__);
}

#pragma mark Status & Connection

/**
 Called when a given web socket was open and authenticated.
 
 @param webSocket An instance of `SRWebSocket` that was open.
 */
- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
     NSLog(@"%s",__FUNCTION__);
    self.status = WebSocketStatusConnected;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onLogin:)]) {
        [self.delegate onLogin:WebSocketStatusConnected];
    }
    
//    NSError *error;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"hello":@"word"} options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//    [webSocket sendString:str error:&error];
    
    
}

/**
 Called when a given web socket encountered an error.
 
 @param webSocket An instance of `SRWebSocket` that failed with an error.
 @param error     An instance of `NSError`.
 */
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    self.status = WebSocketStatusConnectFail;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onLogin:)]) {
        [self.delegate onLogin:WebSocketStatusConnectFail];
    }
    
     NSLog(@"%s   %@",__FUNCTION__,error);
}

/**
 Called when a given web socket was closed.
 
 @param webSocket An instance of `SRWebSocket` that was closed.
 @param code      Code reported by the server.
 @param reason    Reason in a form of a String that was reported by the server or `nil`.
 @param wasClean  Boolean value indicating whether a socket was closed in a clean state.
 */
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(nullable NSString *)reason wasClean:(BOOL)wasClean
{
    self.status = WebSocketStatusLoseConnect;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onLogin:)]) {
        [self.delegate onLogin:WebSocketStatusLoseConnect];
    }
     NSLog(@"%s",__FUNCTION__);
}

/**
 Called on receive of a ping message from the server.
 
 @param webSocket An instance of `SRWebSocket` that received a ping frame.
 @param data      Payload that was received or `nil` if there was no payload.
 */
- (void)webSocket:(SRWebSocket *)webSocket didReceivePingWithData:(nullable NSData *)data
{
    
    NSString *ping = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if (ping != nil) {
          NSLog(@"ping =  %@",ping);
    }
  
    
}

/**
 Called when a pong data was received in response to ping.
 
 @param webSocket An instance of `SRWebSocket` that received a pong frame.
 @param pongData  Payload that was received or `nil` if there was no payload.
 */
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(nullable NSData *)pongData
{
     NSLog(@"%s",__FUNCTION__);
}


@end
