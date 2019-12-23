//
//  RoomAccount.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/19.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ObjectToDataProtocol.h"
//@class RoomRunOption;
@class RoomAuthority;
@class RoomLabelAuthority;
@class ObjectId;
#import "RoomAccountOption.h"
#import "RoomRunOption.h"
NS_ASSUME_NONNULL_BEGIN

@interface RoomAccount : NSObject<ObjectToDataProtocol>


/**
 账户id(唯一标识)
 */
@property (nonatomic, strong) NSString *identifier;


//需要变化
@property(nonatomic,copy)NSString *description_des;

// label 包含着数据
@property (nonatomic, strong) RoomLabelAuthority*label;


@property(nonatomic,strong)NSArray<ObjectId *>*committee_result;
//// 是0

@property(nonatomic,assign)NSInteger final_finished;

@property(nonatomic,strong)ObjectId *owner;

@property(nonatomic,strong)RoomRunOption *running_option;

@property (nonatomic, strong) NSString *last_deal_time;

@property(nonatomic,copy)NSString *script;

@property(nonatomic,strong)RoomAccountOption *option;

//1
@property(nonatomic,assign)NSInteger room_type;

@property(nonatomic,strong)NSArray *final_result;

@property(nonatomic,copy)NSString *house_id;

@property(nonatomic,strong)NSArray<ObjectId *>*owner_result;

@property(nonatomic,assign)BOOL settle_finished;

@property(nonatomic,strong)NSString *status;

@property(nonatomic,strong)NSArray<ObjectId *>*oracle_sets;

//累计收益
@property(nonatomic,strong)NSArray *share_wins;

//总订单数
@property(nonatomic,strong)NSArray *count_total;

//获胜订单
@property(nonatomic,strong)NSArray *count_wins;

//获胜订单
@property(nonatomic,strong)NSArray *rooms;

@property(nonatomic,strong)NSArray *share_total;

@property(nonatomic,strong)NSArray *count_back;


@property(nonatomic,strong)NSArray *share_back;

















//@property(nonatomic,strong)NSArray<ObjectId *>*oracle_sets;








@end

NS_ASSUME_NONNULL_END
