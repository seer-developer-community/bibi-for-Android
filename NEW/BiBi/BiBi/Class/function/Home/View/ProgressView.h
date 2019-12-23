//
//  ProgressView.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/28.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsModel.h"
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProgressView : UIView

//进度条的占比
@property(nonatomic,assign)NSInteger progress;

//选项
@property(nonatomic,strong)UILabel *answerLabel;

//数量
@property(nonatomic,assign)NSInteger progressCount;

//进度条
@property(nonatomic,strong)UIProgressView *progressView;

//放进度条和label的view

@property(nonatomic,strong)UIView *proAndlabelView;

@property (nonatomic, strong) DetailsModel *progessDetail;

@property(nonatomic,strong) OrderModel *progessOrderModel;

@end

NS_ASSUME_NONNULL_END
