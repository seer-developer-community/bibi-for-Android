//
//  CashOutViewController.h
//  BiBi
//
//  Created by 武建斌 on 2019/4/26.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "BYBaseViewController.h"
#import "PredictHeaderModel.h"

@protocol CashOutDelegate <NSObject>

-(void)CashOutReload;

@end



@interface CashOutViewController : BYBaseViewController

/** 内容视图 */
@property (nonatomic, strong) UIView *containerView;

/** 提现地址 */
@property (nonatomic, strong) UITextField *accountTF;
/** 提现金额*/
@property (nonatomic, strong) UITextField *passwordTF;
/** 登录按钮 */
@property (nonatomic, strong) UIButton *loginBtn;

/** 余额 */
@property(nonatomic,strong)UILabel *yueLabel;

//带过去的值
@property(nonatomic,strong)PredictHeaderModel *cash_model;

@property(nonatomic,weak)id<CashOutDelegate>cashOutDelegate;

@end

