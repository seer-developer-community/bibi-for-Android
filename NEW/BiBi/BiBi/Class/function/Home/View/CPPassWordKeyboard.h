//
//  CPPassWordKeyboard.h
//  随便
//
//  Created by 陈彦松 on 2018/12/23.
//  Copyright © 2018年 cmbc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CPPassWordKeyboardProtocol <NSObject>
- (void)selectedIndex:(NSInteger)index andText:(NSString*)text;
@end
@interface CPPassWordKeyboard : UIView

@property (weak, nonatomic) id<CPPassWordKeyboardProtocol> delegate;
@end
