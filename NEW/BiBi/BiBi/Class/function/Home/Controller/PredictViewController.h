//
//  PredictViewController.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/27.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "BYBaseViewController.h"

//#import "PredictHeaderModel.h"
#import "DetailsModel.h"
#import "OrderModel.h"
NS_ASSUME_NONNULL_BEGIN
//typedef void (^ButtontwoBlock)(void);
@interface PredictViewController : BYBaseViewController

@property(nonatomic,strong)DetailsModel *preModel;

@property(nonatomic,strong)OrderModel *orderM;

//@property (nonatomic, strong, nullable) ButtontwoBlock block;
////
//- (void)returnText:(ButtontwoBlock)block;




@end

NS_ASSUME_NONNULL_END
