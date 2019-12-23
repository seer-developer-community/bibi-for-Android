//
//  MaskView.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/2.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ButtonBlock) (id sender);

@interface MaskView : UIView

@property (nonatomic, strong, nullable) ButtonBlock block;

- (void)addButtonAction:(ButtonBlock)block;

-(instancetype) initWithTitleBiglable:(NSString *)bigLabel little:(NSString *)little littletwo:(NSString *)littletwo textColor:(UIColor *)textColor;
@end


NS_ASSUME_NONNULL_END
