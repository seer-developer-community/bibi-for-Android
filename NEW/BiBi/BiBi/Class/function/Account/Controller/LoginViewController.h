//
//  LoginViewController.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/23.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "BYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : BYBaseViewController


/** 内容视图 */
@property (nonatomic, strong) UIView *containerView;

/** 账号输入 */
@property (nonatomic, strong) UITextField *accountTF;

/** 密码输入 */
@property (nonatomic, strong) UITextField *passwordTF;

/** 确认密码输入 */

@property(nonatomic,strong)UITextField *unpasswordTF;

/** 登录按钮 */
@property (nonatomic, strong) UIButton *loginBtn;

/** 余额 */
@property(nonatomic,strong)UILabel *yueLabel;

@end

NS_ASSUME_NONNULL_END
