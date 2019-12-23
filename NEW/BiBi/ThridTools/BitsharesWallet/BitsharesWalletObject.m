//
//  BitsharesWalletObject.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/19.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "BitsharesWalletObject.h"
#import "BaseConfig.h"
#import "WebsocketClient.h"

#import "ObjectId.h"
#import "BitsharesLocalWalletFile.h"
#import "AuthorityObject.h"

#import "NSObject+DataToObject.h"

#import "TransferOperation.h"
#import "LimitOrderCreateOperation.h"




//#import "RoomAccount.h"
//#import "PlatAccount.h"

@interface BitsharesWalletObject ()

@property (nonatomic, strong) WebsocketClient *client;

@property (nonatomic, strong) BitsharesLocalWalletFile *walletFile;

@property (nonatomic, copy) NSDictionary *feeDictionary;

@end


@implementation BitsharesWalletObject
static BitsharesWalletObject *_bitsharesWalletManger = nil;
- (instancetype)initWithChainId:(NSString *)chainId prefix:(NSString *)prefix {
    if (self = [super init]) {
        [BaseConfig setPrefix:prefix];
        [BaseConfig setChainId:chainId];
        _walletFile = [[BitsharesLocalWalletFile alloc] init];
        _walletFile.chain_id = chainId;
    }
    return self;
}

- (BOOL)judgeCanUseWithError:(NSError **)error {
    if (self.walletFile.isLocked) {
        if (error) {
            *error = [NSError errorWithDomain:@"Wallet Locked Error,you should use function unlock" code:WebsocketErrorCodeWalletLockedError userInfo:nil];
        }
    }
    return YES;
}

- (void)setPassword:(NSString *)password error:(NSError *__autoreleasing *)error {
    if ([self.walletFile canSetPassword]) {
        [self.walletFile lockWithString:password];
        return;
    }
    if (error) {
        *error = [NSError errorWithDomain:@"Wallet Set Password Error" code:WebsocketErrorCodeWalletLockedError userInfo:nil];
    }
}

- (void)unlockPassword:(NSString *)password error:(NSError *__autoreleasing *)error {
    [self.walletFile unlockWithString:password error:error];
}

- (BOOL)loadLocalWalletFileFromPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    @try {
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (!data) {
            if (error) {
                *error = [NSError errorWithDomain:[NSString stringWithFormat:@"File not exists at path:%@",path] code:WebsocketErrorCodeWalletFileNotFound userInfo:nil];
            }
            
            return NO;
        }
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:error];
        
        if (!dic) {
            return NO;
        }
        
        _walletFile = [BitsharesLocalWalletFile generateFromObject:dic];
        
        if (!_walletFile) {
            if (error) {
                *error = [NSError errorWithDomain:[NSString stringWithFormat:@"File format is not right"] code:WebsocketErrorCodeWalletFileFormatWrong userInfo:nil];
            }
            
            return NO;
        }
        
        return YES;
    }@catch (NSException *exception) {
        // 捕获到的异常exception
        if (error) {
            *error = [NSError errorWithDomain:exception.reason code:WebsocketErrorCodeWalletLoadExceptionRaise userInfo:exception.userInfo];
        }
    }
    
    return NO;
}

- (BOOL)importKey:(PrivateKey *)privateKey forAccount:(AccountObject *)account error:(NSError *__autoreleasing *)error{
    return [self.walletFile importKey:privateKey ForAccount:account error:error];
}

- (PrivateKey *)getPrivateKey:(PublicKey *)key {
    return [self.walletFile getPrivateKeyFromPublicKey:key error:nil];
}

- (BOOL)saveWalletFileAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    NSData *data = [NSJSONSerialization dataWithJSONObject:[self.walletFile generateToTransferObject] options:(NSJSONWritingPrettyPrinted) error:nil];
        
    return [data writeToFile:path options:(NSDataWritingAtomic) error:error];
}

- (void)connectUrl:(NSString *)url timeOut:(NSTimeInterval)timeOut connectedError:(void (^)(NSError *))connectedError {
    if (_client.connectStatus == WebsocketConnectStatusConnected){
        _connected = YES;
        return;
    }else {
        _connected = NO;
    }
    self.client = [[WebsocketClient alloc] initWithUrl:url closedCallBack:connectedError];
    
    [self.client connectWithTimeOut:timeOut];
    
    self.walletFile.ws_server = url;
    
    _connectedUrl = url;
}

- (void)setConnectStatusChange:(void (^)(WebsocketConnectStatus))connectStatusChange {
    _connectStatusChange = connectStatusChange;
    if (_client) {
        _client.connectStatusChange = connectStatusChange;
    }
}

- (void)setClient:(WebsocketClient *)client {
    _client = client;
    
    if (_connectStatusChange) {
        _client.connectStatusChange = _connectStatusChange;
    }
}

- (void)sendWithChainApi:(WebsocketBlockChainApi)chainApi method:(WebsocketBlockChainMethodApi)method params:(UploadParams *)uploadParams callBack:(CallBackModel *)callBack {
    [_client sendWithChainApi:chainApi method:method params:uploadParams callBack:callBack];
}

- (void)getObject:(ObjectId *)object success:(void (^)(id))success error:(void (^)(NSError *))error {
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    uploadParams.methodName = @"get_objects";
    
    uploadParams.totalParams = @[@[object.generateToTransferObject]];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray * result) {
        NSDictionary *dic = result.firstObject;
        
        success(dic);
    };
    
    callBackModel.errorResult = error;
    
    [self sendWithChainApi:WebsocketBlockChainApiDataBase method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

- (void)getAccount:(NSString *)accountIdOrName success:(void (^)(AccountObject *))success error:(void (^)(NSError *))error {
    ObjectId *object = [ObjectId generateFromObject:accountIdOrName];
    
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    if (object) {
        uploadParams.methodName = @"get_objects";
        
        uploadParams.totalParams = @[@[object.generateToTransferObject]];
    }else {
        uploadParams.methodName = @"lookup_account_names";
        
        uploadParams.totalParams = @[@[accountIdOrName]];
    }
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray * result) {
        
        NSDictionary *dic = result.firstObject;
        
        success([AccountObject generateFromObject:dic]);
    };
    
    callBackModel.errorResult = error;
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

- (void)listAccountBalance:(AccountObject *)account success:(void (^)(NSArray<AssetAmountObject *> *))success error:(ErrorDone)error {
    UploadParams *uploadParams = [[UploadParams alloc] init];
    uploadParams.methodName = @"get_account_balances";
    uploadParams.totalParams = @[account.identifier.generateToTransferObject,@[]];
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    callBackModel.successResult = ^(NSArray * result) {
        success([AssetAmountObject generateFromDataArray:result]);
    };
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

- (void)listAssets:(NSString *)lowerBounds nLimit:(NSInteger)nLimit success:(void (^)(NSArray<AssetObject *> *))success error:(ErrorDone)error {
    UploadParams *uploadParams = [[UploadParams alloc] init];

    uploadParams.methodName = @"list_assets";
    
    uploadParams.totalParams = @[lowerBounds,@(nLimit)];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray * result) {
        success([AssetObject generateFromDataArray:result]);
    };
    
    callBackModel.errorResult = error;
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

- (void)getAsset:(NSString *)assetIdOrName success:(void (^)(AssetObject *))success error:(void (^)(NSError *))error {
    ObjectId *object = [ObjectId generateFromObject:assetIdOrName];
    
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    if (object) {
        uploadParams.methodName = @"get_objects";
        
        uploadParams.totalParams = @[@[object.generateToTransferObject]];
    }else {
        uploadParams.methodName = @"lookup_asset_symbols";
        
        uploadParams.totalParams = @[@[assetIdOrName]];
    }
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray * result) {
        NSDictionary *dic = result.firstObject;
        
        success([AssetObject generateFromObject:dic]);
    };
    
    callBackModel.errorResult = error;
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

- (void)getAssets:(NSArray<ObjectId *> *)assetIds success:(void (^)(NSArray<AssetObject *> *))success error:(ErrorDone)error {
    UploadParams *uploadParams = [[UploadParams alloc] init];

    uploadParams.methodName = @"get_objects";
    
    uploadParams.totalParams = @[[NSObject generateToTransferArray:assetIds]];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray * result) {
        success([AssetObject generateFromDataArray:result]);
    };
    
    callBackModel.errorResult = error;
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

- (void)getDynamicGlobalPropertiesWithSuccess:(void (^)(ChainDynamicGlobalProperties *))success error:(void (^)(NSError *))error {
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    uploadParams.methodName = @"get_dynamic_global_properties";
    
    uploadParams.totalParams = @[];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(id result) {
        success([ChainDynamicGlobalProperties generateFromObject:result]);
    };
    
    callBackModel.errorResult = error;
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

- (void)getOperationBaseFeeObjectWithSuccess:(void (^)(id))success error:(void (^)(NSError *))error lazyLoad:(BOOL)lazyLoad {
    if (lazyLoad && self.feeDictionary) {
        success(self.feeDictionary);
        return;
    }
    
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    uploadParams.methodName = @"get_objects";
    
    uploadParams.totalParams = @[@[@"2.0.0"]];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray *result) {
        NSArray *feeArray = result.firstObject[@"parameters"][@"current_fees"][@"parameters"];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:feeArray.count];
        
        for (NSArray *array in feeArray) {
            
            dic[array.firstObject] = array.lastObject;
        }
        
        self.feeDictionary = dic;
        
        success(dic);
    };
    
    callBackModel.errorResult = error;
    
    [self sendWithChainApi:WebsocketBlockChainApiDataBase method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

//转账

- (void)transferFromAccount:(AccountObject *)fromAccount toAccount:(AccountObject *)toAccount assetAmount:(AssetAmountObject *)assetAmount memo:(NSString *)memo feePayingAsset:(AssetObject *)feePayingAsset success:(SignedTransactionDone)success error:(void (^) (NSError *))error {
    NSError *errors;
    
    if (![self judgeCanUseWithError:&errors]) {
        error(errors);
        return;
    }
    
    TransferOperation *operation = [[TransferOperation alloc] init];
    
    operation.from = fromAccount.identifier;
    
    operation.to = toAccount.identifier;
    
    operation.amount = assetAmount;
    
    operation.requiredAuthority = fromAccount.active.publicKeys;
    
    if (memo.length > 0) {
        NSError *errors;
        
        PrivateKey *private = [self.walletFile getPrivateKeyFromPublicKey:fromAccount.options.memo_key error:&errors];
        
        if (!private) {
            if (!errors) {
                errors = [NSError errorWithDomain:[NSString stringWithFormat:@"Account %@ memo key %@ not found",fromAccount.name,fromAccount.options.memo_key] code:WebsocketErrorCodeWalletKeyAccountError userInfo:nil];
            }
            
            error(errors);
            return;
        }
        
        Memo *memoData = [[Memo alloc] initWithSend:YES privateKey:private anotherPublickKey:toAccount.options.memo_key customerNonce:nil totalMessage:memo];
        
        operation.memo = memoData;
    }
    
    [self getOperationBaseFeeObjectWithSuccess:^(NSDictionary *result) {
        
        operation.fee = [operation caculateFeeWithFeeDic:result[@(0)] payFeeAsset:feePayingAsset];
        
        OperationContent *content = [[OperationContent alloc] initWithOperation:operation];
        
        SignedTransaction *signedTran = [[SignedTransaction alloc] init];
        
        signedTran.operations = @[content];
        
        [self signedTransaction:signedTran success:success error:error];
    } error:error lazyLoad:YES];
}



- (void)transferFromAccountBeiZhu:(AccountObject *)fromAccount toAccount:(AccountObject *)toAccount assetAmount:(AssetAmountObject *)assetAmount memo:(NSString *)memo feePayingAsset:(AssetObject *)feePayingAsset assetFeemount:(AssetAmountObject *)feemount success:(SignedTransactionDone)success error:(ErrorDone)error{
    
    
    NSError *errors;
    
    if (![self judgeCanUseWithError:&errors]) {
        error(errors);
        return;
    }
    
    TransferOperation *operation = [[TransferOperation alloc] init];
    
    operation.from = fromAccount.identifier;
    
    operation.to = toAccount.identifier;
    
    operation.amount = assetAmount;
    
    operation.requiredAuthority = fromAccount.active.publicKeys;
    
    if (memo.length > 0) {
        NSError *errors;
        
        PrivateKey *private = [self.walletFile getPrivateKeyFromPublicKey:fromAccount.options.memo_key error:&errors];
        
        if (!private) {
            if (!errors) {
                errors = [NSError errorWithDomain:[NSString stringWithFormat:@"Account %@ memo key %@ not found",fromAccount.name,fromAccount.options.memo_key] code:WebsocketErrorCodeWalletKeyAccountError userInfo:nil];
            }
            
            error(errors);
            return;
        }
        
        Memo *memoData = [[Memo alloc] initWithSend:YES privateKey:private anotherPublickKey:toAccount.options.memo_key customerNonce:nil totalMessage:memo];
        
        operation.memo = memoData;
    }
    
    NSInteger feeAmount1 =[[feemount valueForKey:@"amount"] integerValue];
    
//    operation.fee = [operation caculateFeeWithFeeDic:@{@"fee":@(feemount.amount)} payFeeAsset:feePayingAsset];
    
    [self getOperationBaseFeeObjectWithSuccess:^(NSDictionary *result) {
        
        operation.fee = [operation caculateFeeWithFeeDic2:@{@"fee":@(feeAmount1)} payFeeAsset:feePayingAsset];
        
        OperationContent *content = [[OperationContent alloc] initWithOperation:operation];
        
        SignedTransaction *signedTran = [[SignedTransaction alloc] init];
        
        signedTran.operations = @[content];
        
        [self signedTransaction:signedTran success:success error:error];
    } error:error lazyLoad:YES];
    
   
}



//提现
- (void)getMoneyFromAccount:(AccountObject *)fromAccount toAccount:(AccountObject *)toAccount assetAmount:(AssetAmountObject *)assetAmount memo:(NSString *)memo feePayingAsset:(AssetObject *)feePayingAsset success:(SignedTransactionDone)success error:(void (^) (NSError *))error{
    NSError *errors;
    if (![self judgeCanUseWithError:&errors]) {
        error(errors);
        return;
    }
    
    TransferOperation *operation = [[TransferOperation alloc] init];
    
    operation.from = fromAccount.identifier;
    
    operation.to = toAccount.identifier;
    
    operation.amount = assetAmount;
    
    operation.requiredAuthority = fromAccount.active.publicKeys;
    
    if (memo.length > 0) {
        NSError *errors;
        
        PrivateKey *private = [self.walletFile getPrivateKeyFromPublicKey:fromAccount.options.memo_key error:&errors];
        
        if (!private) {
            if (!errors) {
                errors = [NSError errorWithDomain:[NSString stringWithFormat:@"Account %@ memo key %@ not found",fromAccount.name,fromAccount.options.memo_key] code:WebsocketErrorCodeWalletKeyAccountError userInfo:nil];
                
            }
            
            error(errors);
            return;
        }
        
        Memo *memoData = [[Memo alloc] initWithSend:YES privateKey:private anotherPublickKey:toAccount.options.memo_key customerNonce:nil totalMessage:memo];
        
        operation.memo = memoData;
        
    }
    
    [self getOperationBaseFeeObjectWithSuccess:^(NSDictionary *result) {
        
        operation.fee = [operation caculateFeeWithFeeDic1:result[@(0)] payFeeAsset:feePayingAsset];
        
        OperationContent *content = [[OperationContent alloc] initWithOperation:operation];
        
        SignedTransaction *signedTran = [[SignedTransaction alloc] init];
        
        signedTran.operations = @[content];
        
        [self signedTransaction:signedTran success:success error:error];
    } error:error lazyLoad:YES];
    
    
}


//转账带备注
- (void)getMomeFromAccount:(AccountObject *)fromAccount toAccount:(AccountObject *)toAccount assetAmount:(AssetAmountObject *)assetAmount memo:(NSString *)memo feePayingAsset:(AssetObject *)feePayingAsset success:(SignedTransactionDone)success error:(void (^) (NSError *))error{
    
    NSError *errors;
    if (![self judgeCanUseWithError:&errors]) {
        error(errors);
        return;
    }
    
    TransferOperation *operation = [[TransferOperation alloc] init];
    
    operation.from = fromAccount.identifier;
    
    operation.to = toAccount.identifier;
    
    operation.amount = assetAmount;
    
    operation.requiredAuthority = fromAccount.active.publicKeys;
    
    if (memo.length > 0) {
        NSError *errors;
        
        PrivateKey *private = [self.walletFile getPrivateKeyFromPublicKey:fromAccount.options.memo_key error:&errors];
        
        if (!private) {
            if (!errors) {
                errors = [NSError errorWithDomain:[NSString stringWithFormat:@"Account %@ memo key %@ not found",fromAccount.name,fromAccount.options.memo_key] code:WebsocketErrorCodeWalletKeyAccountError userInfo:nil];
                
            }
            
            error(errors);
            return;
        }
        
        Memo *memoData = [[Memo alloc] initWithSend:YES privateKey:private anotherPublickKey:toAccount.options.memo_key customerNonce:nil totalMessage:memo];
        
        operation.memo = memoData;
        
    }
    
    [self getOperationBaseFeeObjectWithSuccess:^(NSDictionary *result) {
        
        operation.fee = [operation caculateFeeWithFeeDic2:result[@(0)] payFeeAsset:feePayingAsset];
        
        OperationContent *content = [[OperationContent alloc] initWithOperation:operation];
        
        SignedTransaction *signedTran = [[SignedTransaction alloc] init];
        
        signedTran.operations = @[content];
        
        [self signedTransaction:signedTran success:success error:error];
    } error:error lazyLoad:YES];
    
}


//查询费率

-(void)getRequiredFees:(AccountObject *)fromAccount toAccount:(AccountObject *)toAccount assetAmount:(AssetAmountObject *)assetAmount memo:(NSString *)memo feePayingAsset:(AssetObject *)feePayingAsset success:(void(^)(AssetAmountObject  *result))success error:(ErrorDone)error{
//     NSError *errors;
    
    TransferOperation *operation = [[TransferOperation alloc] init];
    
    operation.from = fromAccount.identifier;
    
    operation.to = toAccount.identifier;
    
    operation.amount = assetAmount;
  
    operation.fee = assetAmount;
    operation.requiredAuthority = fromAccount.active.publicKeys;
    
    if (memo.length > 0) {
        NSError *errors;
        
        PrivateKey *private = [self.walletFile getPrivateKeyFromPublicKey:fromAccount.options.memo_key error:&errors];
        
        if (!private) {
            if (!errors) {
                errors = [NSError errorWithDomain:[NSString stringWithFormat:@"Account %@ memo key %@ not found",fromAccount.name,fromAccount.options.memo_key] code:WebsocketErrorCodeWalletKeyAccountError userInfo:nil];
            }
            
            error(errors);
            return;
        }
        
        Memo *memoData = [[Memo alloc] initWithSend:YES privateKey:private anotherPublickKey:toAccount.options.memo_key customerNonce:nil totalMessage:memo];
        
        operation.memo = memoData;
    }
    
  
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    uploadParams.methodName = @"get_required_fees";
    
    uploadParams.totalParams = @[@[@[@0,operation.generateToTransferObject]],[NSString stringWithFormat:@"%@",assetAmount.assetId]];

    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray * result) {
        
        success(result.firstObject);
        
    };
    
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
    
    
}


- (void)roomActionFromAccount:(AccountObject *)fromAccount
                    baseAsset:(AssetObject *)baseAsset
               feePayingAsset:(AssetObject *)feePayingAsset
                         room:(ObjectId *)room
                         type:(NSInteger)type
                        input:(NSArray <NSNumber *>*)input
                       amount:(long long)amount
                      success:(SignedTransactionDone)success
                        error:(void (^) (NSError *))error {
    NSError *errors;

    if (![self judgeCanUseWithError:&errors]) {
        error(errors);
        return;
    }

    RoomOperation *operation = [[RoomOperation alloc] init];

    operation.issuer = fromAccount.identifier;

    operation.room = room;

    operation.type = type;

    operation.input = input;

    operation.amount = amount;
    [self getOperationBaseFeeObjectWithSuccess:^(NSDictionary *result) {
        operation.requiredAuthority = fromAccount.active.publicKeys;
        operation.fee = [operation caculateFeeWithFeeDic:result[@1] payFeeAsset:feePayingAsset];
        OperationContent *content = [[OperationContent alloc] initWithOperation:operation];

        SignedTransaction *signedTran = [[SignedTransaction alloc] init];
        
        signedTran.operations = @[content];

        [self signedTransaction:signedTran success:success error:error];
    } error:error lazyLoad:YES];
}

- (void)sellAssetFromAccount:(AccountObject *)account amountToSell:(AssetAmountObject *)amountToSell minToReceiveAsset:(AssetAmountObject *)minToReceive expirationDate:(NSDate *)expirationDate fillOrKill:(BOOL)fillOrKill feeAsset:(AssetObject *)feeAsset success:(SignedTransactionDone)success error:(ErrorDone)error {
    NSError *errors;
    if (![self judgeCanUseWithError:&errors]) {
        error(errors);
        return;
    }
    
    LimitOrderCreateOperation *operation = [[LimitOrderCreateOperation alloc] init];
    
    operation.seller = account.identifier;
    
    operation.amount_to_sell = amountToSell;
    
    operation.min_to_receive = minToReceive;
    
    operation.expiration = expirationDate;
    
    operation.fill_or_kill = fillOrKill;
    
    [self getOperationBaseFeeObjectWithSuccess:^(NSDictionary *result) {
        operation.requiredAuthority = account.active.publicKeys;
        
        operation.fee = [operation caculateFeeWithFeeDic:result[@1] payFeeAsset:feeAsset];
        
        OperationContent *content = [[OperationContent alloc] initWithOperation:operation];
        
        SignedTransaction *signedTran = [[SignedTransaction alloc] init];
        
        signedTran.operations = @[content];
        
        [self signedTransaction:signedTran success:success error:error];
    } error:error lazyLoad:YES];

}

- (void)signedTransaction:(SignedTransaction *)signedTransaction success:(void (^) (SignedTransaction *))success error:(void (^) (NSError *))error {
    NSError *errors;
    if (![self judgeCanUseWithError:&errors]) {
        error(errors);
        return;
    }
    
    [self getDynamicGlobalPropertiesWithSuccess:^(ChainDynamicGlobalProperties *result) {
        [signedTransaction setRefBlock:result.head_block_id];
        signedTransaction.expiration = [result.time dateByAddingTimeInterval:30];
        
        for (PublicKey *key in [signedTransaction needSignedKeys]) {
            PrivateKey *priKey = [self.walletFile getPrivateKeyFromPublicKey:key error:nil];
            
            if (priKey) {
                [signedTransaction signWithPrikey:priKey];
            }
        }
        
        UploadParams *uploadParams = [[UploadParams alloc] init];

        uploadParams.methodName = @"broadcast_transaction";
        
        uploadParams.totalParams = @[signedTransaction.generateToTransferObject];
        
        CallBackModel *callBackModel = [[CallBackModel alloc] init];
        
        callBackModel.successResult = ^(id result) {
            success(signedTransaction);
        };
        
        callBackModel.errorResult = error;
        
        [self sendWithChainApi:WebsocketBlockChainApiNetworkBroadcast method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
        
    } error:error];
}

- (BrainKey *)deriveKeyWithBrainKey:(NSString *)brainKey {
    return [BrainKey deriveFromBrainKey:brainKey];
}

- (BrainKey *)deriveKeyWithOwnerBrainKey:(NSString *)brainKey{
    
    return [BrainKey deriveFromOwnerBrainKey:brainKey];
}

- (BrainKey *)suggestBrainKey {
    return [BrainKey suggestBrainKey];
}

- (NSArray <AccountObject *> *)myaccounts {
    return self.walletFile.my_accounts;
}

//得到平台信息 （自己仿照着人家写的 逻辑 callBackModel.successResult 不知道是干啥的）
-(void)getPlatform:(NSString *)method unploadParamsTotalParams:(NSArray *)unploadParams paltNum:(NSInteger)paltNum success:(void(^)(PlatAccount* result))success error:(ErrorDone)error{

    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    uploadParams.methodName = method;
    
    uploadParams.totalParams = @[[NSObject generateToTransferArray:unploadParams]];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray* result) {

        NSDictionary *dic = result[paltNum];
        
        
            success([PlatAccount generateFromObject:dic]);

    };
    
    callBackModel.errorResult = error;
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}

//得到房间的信息 （自己仿照着人家写的 逻辑 callBackModel.successResult 不知道是干啥的）
-(void)getSeerRoom:(NSString *)method  fristString:(ObjectId *)fristString nLimint:(NSInteger)nLinmint secondInt:(NSInteger)secondInt success:(void(^)(RoomAccount* result))success error:(ErrorDone)error{
        UploadParams *uploadParams = [[UploadParams alloc] init];
    
        uploadParams.methodName = method;
    
        uploadParams.totalParams = @[fristString,@(nLinmint),@(secondInt)];
    
        CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
        callBackModel.successResult = ^(RoomAccount* result) {
            
            success([RoomAccount generateFromObject:result]);
        };
    
        callBackModel.errorResult = error;
    
        [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
}





-(void)getHistroyAccount:(NSString*)str success:(void(^)(NSArray<AccountHistoryModle*> *result))success error:(ErrorDone)error{
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    uploadParams.methodName = @"get_account_history";
    
    uploadParams.totalParams = @[str,@"1.9.0",@(100),@"1.9.0"];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray * result) {
        NSLog(@"%@",result);
        success([AccountHistoryModle generateFromDataArray:result]);

    };
    
    [self sendWithChainApi:(WebsocketBlockChainApiHistory) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
    
}

-(void)getBlockNum:(NSString *)blockStr success:(void(^)( NSDictionary *result))success error:(ErrorDone)error{
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    uploadParams.methodName = @"get_block";
    
    uploadParams.totalParams = @[blockStr];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSDictionary * result) {
        NSLog(@"%@",result);
//        success([AccountHistoryModle generateFromDataArray:result]);
        success(result);
    };
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
    
    
    
}
-(void)getAccountName:(NSString *)pukStr success:(void(^)(NSArray *result))success error:(ErrorDone)error{
    
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    uploadParams.methodName = @"get_key_references";
    
    uploadParams.totalParams = @[@[pukStr]];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray * result) {
       
        success(result);
    };
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
    
}


//查询账户的订单信息
-(void)getplayInfo:(NSString *)identifier success:(void(^)(OrderAccount *result))success error:(ErrorDone)error{
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    uploadParams.methodName = @"get_player_info";
    
    uploadParams.totalParams = @[identifier];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(OrderAccount * result) {

        success([OrderAccount generateFromObject:result]);
    };
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
    
}

//查询历史订单

-(void)getHistoryOrder:(NSString*)player andAsset:(NSString *)asset andStatus:(NSInteger)Status unixTimeStr:(NSInteger)unixTime withPaage:(NSInteger)paageCount  success:(void(^)(NSArray<OrderContention*>* result))success error:(ErrorDone)error{
    
    UploadParams *uploadParams = [[UploadParams alloc] init];
    
    uploadParams.methodName = @"get_seer_records_by_player";
    
    uploadParams.totalParams = @[player,asset,@(Status),@(unixTime),@"2020-10-10T00:00:44",@(paageCount)];
    
    CallBackModel *callBackModel = [[CallBackModel alloc] init];
    
    callBackModel.successResult = ^(NSArray * result) {
        NSArray *seoncdArry = result.lastObject;
        NSArray *lasetArry = seoncdArry.lastObject;
        success([OrderContention generateFromDataArray:lasetArry]);
    };
    
    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
    
}







//- (void)listAssets:(NSString *)lowerBounds nLimit:(NSInteger)nLimit success:(void (^)(NSArray<AssetObject *> *))success error:(ErrorDone)error {
//    UploadParams *uploadParams = [[UploadParams alloc] init];
//
//    uploadParams.methodName = @"list_assets";
//
//    uploadParams.totalParams = @[lowerBounds,@(nLimit)];
//
//    CallBackModel *callBackModel = [[CallBackModel alloc] init];
//
//    callBackModel.successResult = ^(NSArray * result) {
//        success([AssetObject generateFromDataArray:result]);
//    };
//
//    callBackModel.errorResult = error;
//
//    [self sendWithChainApi:(WebsocketBlockChainApiDataBase) method:(WebsocketBlockChainMethodApiCall) params:uploadParams callBack:callBackModel];
//}


+ (instancetype)BitsharesWalletObjectManager{
//    da68a9c5f2fd9ed48e626ea301db1c77505523884ba0dd409e779246c6ea26cf
    //正式
//    cea4fdf4f5c2278f139b22e782b308928f04008b0fc2c79970a58974a2a28f91
    //新节点
//    cea4fdf4f5c2278f139b22e782b308928f04008b0fc2c79970a58974a2a28f91
    static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _bitsharesWalletManger = [[BitsharesWalletObject alloc]initWithChainId:@"cea4fdf4f5c2278f139b22e782b308928f04008b0fc2c79970a58974a2a28f91" prefix:@"SEER"];
        });
        return _bitsharesWalletManger;
}


- (void)needConnect {
//    [[BitsharesWalletObject BitsharesWalletObjectManager] connectUrl:@"ws://39.105.189.224/ws" timeOut:10 connectedError:^(NSError *error) {
//        NSLog(@"%@",error.description);
//
//
//
////        if (error.code == 50) {
////             UIAlertView *alert =[[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Prompt",@"Internation", nil) message:NSLocalizedStringFromTable(@"Check the network",@"Internation", nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"Buttonsure",@"Internation", nil) otherButtonTitles:nil];
////            [alert show];
////            return;
////        }
//        [self needConnect];
//
//
//    }];
//
    [[BitsharesWalletObject BitsharesWalletObjectManager] connectUrl:SEE_New_URL timeOut:10 connectedError:^(NSError *error) {
        NSLog(@"%@",error.description);



        //        if (error.code == 50) {
        //             UIAlertView *alert =[[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Prompt",@"Internation", nil) message:NSLocalizedStringFromTable(@"Check the network",@"Internation", nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"Buttonsure",@"Internation", nil) otherButtonTitles:nil];
        //            [alert show];
        //            return;
        //        }
        [self needConnect];


    }];
    
    
    
}

-(void)attemptDealloc{
    _bitsharesWalletManger=nil;
//    onceToken=0l;
}


@end
