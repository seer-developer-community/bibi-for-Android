//
//  PredictHeaderModel.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/28.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define topMargin 30

@interface PredictHeaderModel : NSObject


//内容
@property (nonatomic, copy) NSString *title;
//时间
@property (nonatomic, copy) NSString *time;

// 参与金额
@property(nonatomic,assign) NSInteger totalmoneyaCount;

//参与人数
@property(nonatomic,assign) NSInteger totalpeople;

//占百分比
@property(nonatomic,assign)NSInteger percent;


////背景的高度
@property(nonatomic,assign)CGFloat hight;

//选项数组
@property(nonatomic,strong)NSArray *choseButcount;

//预测最大值
@property(nonatomic,assign)NSInteger maxNub;

//预测最小值
@property(nonatomic,assign)float minNub;

//model里面的id
@property(nonatomic,copy)NSString *ass_id;


@end

NS_ASSUME_NONNULL_END
