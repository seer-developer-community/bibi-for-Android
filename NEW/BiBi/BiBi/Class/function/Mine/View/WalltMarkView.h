//
//  WalltMarkView.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/2.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^ButtonBlock)(void);
@interface WalltMarkView : UIView
-(instancetype) initWithTitleBiglable:(NSString *)bigLabel little:(NSString *)little;

@property (nonatomic, strong, nullable) ButtonBlock block;
- (void)addButtonAction:(ButtonBlock)block;

@end

NS_ASSUME_NONNULL_END
