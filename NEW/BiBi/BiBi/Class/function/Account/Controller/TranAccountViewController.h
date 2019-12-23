//
//  TranAccountViewController.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/18.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "BYBaseViewController.h"
#import "PredictHeaderModel.h"
//@protocol RecordsViewDelegate <NSObject>
//
//-(void)RecordsViewReload;

//@end

NS_ASSUME_NONNULL_BEGIN

@interface TranAccountViewController : BYBaseViewController

/** 内容视图 */
@property (nonatomic, strong) UIView *containerView;

/** 账号输入 */
@property (nonatomic, strong) UITextField *accountTF;
/** 密码输入 */
@property (nonatomic, strong) UITextField *passwordTF;
/** 登录按钮 */
@property (nonatomic, strong) UIButton *loginBtn;

/** 余额 */
@property(nonatomic,strong)UILabel *yueLabel;


//@property(nonatomic,weak)id<RecordsViewDelegate>recordsViewDelegate;


//带过去的值
@property(nonatomic,strong)PredictHeaderModel *trans_model;
@end

NS_ASSUME_NONNULL_END
