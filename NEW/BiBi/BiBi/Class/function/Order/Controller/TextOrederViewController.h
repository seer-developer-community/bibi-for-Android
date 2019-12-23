//
//  TextOrederViewController.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/7.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "BYBaseViewController.h"

@protocol OrderChoseDelegate <NSObject>

-(void)push:(NSInteger)index;

@end

typedef void (^ButtontwoBlock)(void);
@interface TextOrederViewController : BYBaseViewController

@property(nonatomic,weak)id<OrderChoseDelegate>delegate;

@property (nonatomic, strong, nullable) ButtontwoBlock block;
//
//- (void)returnText:(ButtontwoBlock)block;

@end


