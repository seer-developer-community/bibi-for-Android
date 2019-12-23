//
//  QuizzesSucdViewController.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/4.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "BYBaseViewController.h"


#import "DetailsModel.h"
#import "OrderModel.h"
@interface QuizzesSucdViewController : BYBaseViewController

@property(nonatomic,strong)DetailsModel *preModel;
@property(nonatomic,strong)OrderModel *orderM;
@property(nonatomic,assign)NSInteger chooseCount;
@property(nonatomic,assign)NSInteger trNmber;

@end


