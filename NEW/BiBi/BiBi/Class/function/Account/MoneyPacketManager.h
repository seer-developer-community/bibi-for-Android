//
//  MoneyPacketManager.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/1.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoneyPacketManager : NSObject
+ (instancetype)moneyAcctountManager;
+(void)attemptDealloc;
//账户名
@property (copy, nonatomic) NSString* userName;
//密码
@property(copy,nonatomic)NSString *passWored;

//用户ID

@property(copy,nonatomic)NSString *identifier;

//SEER余额
@property(assign,nonatomic) float surplus;

//USDT
@property(assign,nonatomic)float usdt_surplus;

@property(assign,nonatomic)float pdfc_surplus;


@property (assign, nonatomic) BOOL isLogin;

//判断图片
@property(assign,nonatomic)BOOL isHiddenImage;

//助记词

@property(nonatomic,copy)NSString *brainKeyStr;

//私钥
@property(nonatomic,copy)NSString *priveKeyStr;

//own私钥
@property(nonatomic,copy)NSString *ownpriveKeyStr;

//公钥
@property(nonatomic,copy)NSString *puliKeyStr;

//eth地址
@property(nonatomic,copy)NSString *eth_address;

//订单里面的是什么币种
@property(nonatomic,copy)NSString *assorder_id;

@property (assign, nonatomic) BOOL isaddress;
- (void)logout;
- (void)saveUserData;
- (void)getUserData;

@end

NS_ASSUME_NONNULL_END
