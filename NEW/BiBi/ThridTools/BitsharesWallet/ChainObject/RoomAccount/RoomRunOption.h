//
//  RoomRunOption.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/19.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
#import "Participators.h"
#import "AdvancedOption.h"
#import "AdvancedRunningOption.h"
#import "LmsrOption.h"
#import "LmsrrunningOption.h"
NS_ASSUME_NONNULL_BEGIN

@interface RoomRunOption : NSObject<ObjectToDataProtocol>

@property(nonatomic,assign)NSInteger room_type;

@property(nonatomic,strong)NSArray<NSString *>*selection_description;

@property(nonatomic,assign)NSInteger range;

@property(nonatomic,copy)NSArray<NSArray<Participators*>*> *participators;

//投注总金额
@property(nonatomic,assign)NSInteger total_shares;

@property(nonatomic,assign)NSInteger settled_balance;

@property(nonatomic,assign)NSInteger settled_row;

@property(nonatomic,assign)NSInteger settled_column;

//重新封装
@property(nonatomic,copy)NSArray *player_count;

@property(nonatomic,assign)NSInteger total_player_count;


// 重新封装 model
@property(nonatomic,strong)NSArray *pvp_running;

//
@property(nonatomic,assign)NSInteger guaranty_alone;

//固定赔率和金额

@property(nonatomic,strong)AdvancedOption *advanced;

//固定赔率投注金额和赔付金额

@property(nonatomic,strong)AdvancedRunningOption *advanced_running;


//交易类型
@property(nonatomic,strong)LmsrOption *lmsr;

//交易类型选项的个数
@property(nonatomic,strong)LmsrrunningOption *lmsr_running;

@property(nonatomic,strong)NSArray *final_result;

@end

NS_ASSUME_NONNULL_END
