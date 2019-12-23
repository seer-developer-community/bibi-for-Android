//
//  TestMineViewController.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/17.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "BYBaseViewController.h"
#import "MineTableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface TestMineViewController : BYBaseViewController
@property(nonatomic,strong)MineTableView *mintableView;
//文字数组
@property(nonatomic,strong)NSArray *labelArry;
@end

NS_ASSUME_NONNULL_END
