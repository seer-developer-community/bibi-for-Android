//
//  MoneyPacketManager.m
//  BiBi
//
//  Created by 武建斌 on 2019/1/1.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "MoneyPacketManager.h"

////密码
//@property(copy,nonatomic)NSString *passWored;
//
////用户ID
//
//@property(copy,nonatomic)NSString *identifier;
//
////余额
//@property(assign,nonatomic) float surplus;
//
//
//@property (assign, nonatomic) BOOL isLogin;
//
////助记词
//
//@property(nonatomic,copy)NSString *brainKeyStr;
//
////私钥
//@property(nonatomic,copy)NSString *priveKeyStr;
//
////公钥
//@property(nonatomic,copy)NSString *puliKeyStr;

#define USERNAME @"userName"
#define ISLOGIN @"isLogin"
#define Id @"identifier"
#define Surplus @"surplus"
#define Usdt @"usdt_surplus"
#define Pdfc @"pdfc_surplus"
#define BraninKey @"brainKeyStr"
#define PriveKeyStr @"priveKeyStr"
#define ownerPriveKeyStr @"ownpriveKeyStr"
#define PuliKeyStr @"puliKeyStr"
#define Password @"passWored"
#define Address @"adderss"
#define ISHiddenImage @"ishiddenImage"
#define AssorderId  @"assorder_id"
#define ISaddress @"isaddress"

@implementation MoneyPacketManager

static MoneyPacketManager * _manager = nil;
static dispatch_once_t onceToken;
+ (instancetype)moneyAcctountManager {
    dispatch_once(&onceToken, ^{
        _manager = [[MoneyPacketManager alloc]init];
        NSLog(@"%p%s",self,__func__);
    });
    return _manager;
}


+(void)attemptDealloc{
    _manager=nil;
    onceToken=0l;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userName = @"";
        self.identifier = @"";
        self.surplus = 0.0;
        self.usdt_surplus = 0.0;
        self.pdfc_surplus = 0.0;
        self.passWored = @"";
        self.isLogin = NO;
        self.brainKeyStr =@"";
        self.priveKeyStr = @"";
        self.ownpriveKeyStr = @"";
        self.puliKeyStr = @"";
        self.assorder_id = @"";
        self.isHiddenImage = NO;
    }
    return self;
}


- (void)setUserName:(NSString *)userName {
    _userName = userName;
    NSLog(@"refresh userName :%@",_userName);
}
////账户名
//@property (copy, nonatomic) NSString* userName;
////密码
//@property(copy,nonatomic)NSString *passWored;
//
////用户ID
//
//@property(copy,nonatomic)NSString *identifier;
//
////余额
//@property(assign,nonatomic) float surplus;
//
//
//@property (assign, nonatomic) BOOL isLogin;
//
////助记词
//
//@property(nonatomic,copy)NSString *brainKeyStr;
//
////私钥
//@property(nonatomic,copy)NSString *priveKeyStr;
//
////公钥
//@property(nonatomic,copy)NSString *puliKeyStr;

- (void)logout{
    self.userName = @"";
    self.identifier = @"";
    self.surplus = 0;
    self.pdfc_surplus =0;
    self.usdt_surplus = 0;
    self.passWored = @"";
    self.isLogin = NO;
    self.brainKeyStr =@"";
    self.priveKeyStr = @"";
    self.ownpriveKeyStr = @"";
    self.puliKeyStr = @"";
    self.eth_address = @"";
    self.assorder_id = @"";
    self.isHiddenImage = NO;
    [self saveUserData];
}

- (void)saveUserData {
    NSLog(@"单例里面%@",self.identifier);
   NSUserDefaults * userDe =  [NSUserDefaults standardUserDefaults];
    [userDe setObject:self.userName forKey:USERNAME];
    [userDe setObject:@(self.isLogin) forKey:ISLOGIN];
    [userDe setObject:@(self.surplus) forKey:Surplus];
    [userDe setObject:@(self.usdt_surplus) forKey:Usdt];
    [userDe setObject:@(self.pdfc_surplus) forKey:Pdfc];
    [userDe setObject:self.identifier forKey:Id];
    [userDe setObject:self.passWored forKey:Password];
    [userDe setObject:self.brainKeyStr forKey:BraninKey];
    [userDe setObject:self.puliKeyStr forKey:PuliKeyStr];
    [userDe setObject:self.priveKeyStr forKey:PriveKeyStr];
    [userDe setObject:self.ownpriveKeyStr forKey:ownerPriveKeyStr];
    [userDe setObject:self.eth_address forKey:Address];
    [userDe setObject:@(self.isHiddenImage) forKey:ISHiddenImage];
    [userDe setObject:self.assorder_id forKey:AssorderId];
    
}

- (void)getUserData {
    NSUserDefaults * userDe =  [NSUserDefaults standardUserDefaults];
    self.userName = [userDe objectForKey:USERNAME] ? [userDe objectForKey:USERNAME] :@"";
    self.isLogin = [[userDe objectForKey:ISLOGIN] boolValue];
    self.surplus = [[userDe objectForKey:Surplus] floatValue] ?[[userDe objectForKey:Surplus] floatValue] :0;
    self.usdt_surplus = [[userDe objectForKey:Usdt] floatValue]?[[userDe objectForKey:Usdt] floatValue]:0;
    self.pdfc_surplus = [[userDe objectForKey:Pdfc] floatValue]?[[userDe objectForKey:Pdfc] floatValue]:0;
    self.passWored = [userDe objectForKey:Password] ? [userDe objectForKey:Password] :@"";
    self.identifier =[userDe objectForKey:Id] ? [userDe objectForKey:Id] :@"";
    self.brainKeyStr =[userDe objectForKey:BraninKey] ? [userDe objectForKey:BraninKey] :@"";
    self.puliKeyStr = [userDe objectForKey:PuliKeyStr] ? [userDe objectForKey:PuliKeyStr] :@"";
    self.priveKeyStr =[userDe objectForKey:PriveKeyStr] ? [userDe objectForKey:PriveKeyStr] :@"";
    self.ownpriveKeyStr = [userDe objectForKey:ownerPriveKeyStr] ? [userDe objectForKey:ownerPriveKeyStr] :@"";
    self.eth_address =[userDe objectForKey:Address] ? [userDe objectForKey:Address]:@"";
    self.isHiddenImage = [[userDe objectForKey:ISHiddenImage]boolValue];
    self.assorder_id =[userDe objectForKey:AssorderId] ? [userDe objectForKey:AssorderId]:@"";
}
@end
