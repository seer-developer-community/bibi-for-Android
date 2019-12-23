//
//  RoomLabelAuthority.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/19.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
@class ObjectId;
// 不知道这个对象是干什么的
@interface RoomLabelAuthority : NSObject
//0
@property(nonatomic,copy)NSString *BTCstring;
//1
@property(nonatomic,copy)NSString *OKEXsting;

//合约 2
@property(nonatomic,copy)NSString *contract;
//季度3
@property(nonatomic,copy)NSString *quarter;
//币圈4
@property(nonatomic,copy)NSString *circle;

//期货5
@property(nonatomic,copy)NSString *futures;

@end


