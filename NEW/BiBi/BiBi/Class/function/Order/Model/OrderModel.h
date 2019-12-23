//
//  OrderModel.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/8.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderToclass.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject


//房间号
@property (nonatomic,copy) NSString * roomId;

//标题
@property(nonatomic,copy)NSString *contentStr;

//选项
@property(nonatomic,copy)NSString *chooseStr;

//第几个选项
@property(nonatomic,assign)int choosenumber;

//金额
@property(nonatomic,assign)float amount;

// 参与时间
@property(nonatomic,copy)NSString *timeOutStr;

@property(nonatomic,copy)NSString *timeOutStrEN;

//中奖
@property(nonatomic,assign)float reward;

//高度
@property(nonatomic,assign)CGFloat hight;

//截止时间
@property (nonatomic, copy) NSString *timeStop;

@property(nonatomic,copy)NSString *timeStopEN;

//房间的类型
@property(nonatomic,assign)NSInteger room_type;

//金额
@property(nonatomic,assign) NSInteger totalmoneyaCount;

//人数
@property(nonatomic,assign) NSInteger totalpeople;

// 占比
@property(nonatomic,assign)NSInteger percent;

//选项
@property(nonatomic,strong)NSArray *choseButcount;

//预测最大值
@property(nonatomic,assign)NSInteger maxNub;

//预测最小值
@property(nonatomic,assign)NSInteger minNub;

//头部高度
@property(nonatomic,assign)CGFloat hightH;

//第几个选项
@property(nonatomic,copy)NSString * winnerLabel;


@property(nonatomic,assign)CGFloat yuchengHight;

//投注总金额
@property(nonatomic,assign)float total_shares;

////赔率
//@property(nonatomic,strong) NSArray *odds_number;

//
@property(nonatomic,strong)NSArray *proportion;



//固定赔率的金额
@property(nonatomic,assign) NSInteger pool;

//固定赔率的投注金额和中奖金额

@property(nonatomic,strong)NSArray *total_participate;

//固定赔率赔数
@property(nonatomic,strong)NSArray *awards;

//所有份数集合
@property(nonatomic,strong)NSArray *items_countNum;

//除以L的集合
@property(nonatomic,assign)NSInteger lmsr_number;

//订单里面花的钱数
@property(nonatomic,assign)float paid;

//币种
@property(nonatomic,copy)NSString *accept_asset;

@property(nonatomic,copy)NSString *ass_id;
//pvp房间的赔付金额
@property(nonatomic,assign)float pvp_rewerd;

//订单类型标注
@property(nonatomic,assign)NSInteger orderIndex;

//新订单第几个选项
@property(nonatomic,assign)int status_int;

//页数的标识
@property(nonatomic,copy)NSString *identifier;
//投注的选手
@property(nonatomic,copy)NSString *player;
//投注的房间
@property(nonatomic,copy)NSString *room;
//选项
@property(nonatomic,assign)int input;

//包含的选项
@property(nonatomic,strong)NSArray<OrderToclass*>*items_order;
////投注的总金额
//@property(nonatomic,assign)NSInteger amount;
////reward
//@property(nonatomic,assign)NSInteger reward;
////status
//@property(nonatomic,assign)NSInteger status;
////paid
//@property(nonatomic,assign)NSInteger paid;

- (CGFloat)getHeight;

-(CGFloat)getroomtypeHeight;

@end

NS_ASSUME_NONNULL_END
