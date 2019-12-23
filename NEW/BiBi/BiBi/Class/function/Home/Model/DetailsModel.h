//
//  DetailsModel.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/19.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectId.h"
NS_ASSUME_NONNULL_BEGIN
#define topMargin 30


@interface DetailsModel : NSObject


//

@property (nonatomic,copy) NSString * roomId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *time1;

@property(nonatomic,copy)NSString *startTimer;
//按钮显示
@property(nonatomic,copy)NSString *choosebut;

@property(nonatomic,assign) NSInteger totalmoneyaCount;

@property(nonatomic,assign) NSInteger totalpeople;

@property(nonatomic,assign)NSInteger percent;
//房间的类型
@property(nonatomic,assign)NSInteger room_type;

@property(nonatomic,assign)CGFloat hight;

//
@property(nonatomic,strong)NSArray *choseButcount;

//预测最大值
@property(nonatomic,assign)NSInteger maxNub;

//预测最小值
@property(nonatomic,assign)NSInteger minNub;

//占比

@property(nonatomic,assign)NSInteger zhanbi;

//投注总金额
@property(nonatomic,assign)float total_shares;

//赔率
@property(nonatomic,strong) NSArray *odds_number;

//PVP 投注
@property(nonatomic,strong)NSArray *proportion;




@property(nonatomic,assign)CGFloat hightH;

@property(nonatomic,assign)CGFloat yuchengHight;

//固定赔率的金额
@property(nonatomic,assign) NSInteger pool;

//固定赔率的投注金额和中奖金额

@property(nonatomic,strong)NSArray *total_participate;

//固定赔率赔数
@property(nonatomic,strong)NSArray *awards;

//所有份数集合
@property(nonatomic,strong)NSArray *items_countNum;

//除以L的集合
@property(nonatomic,assign)float lmsr_number;


//币种
@property(nonatomic,copy)NSString *accept_asset;

//币种ID
@property(nonatomic,copy)NSString *ass_id;

@end

NS_ASSUME_NONNULL_END
