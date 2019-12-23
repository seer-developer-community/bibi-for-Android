//
//  passWordView.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/24.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^sureBlock)(NSString *string);

typedef void (^ButtonBlock) (id sender);
@interface passWordView : UIView

@property(nonatomic,copy)sureBlock sureClick;


@property (nonatomic, strong, nullable) ButtonBlock block;


-(void)withSureClick:(sureBlock)block;


- (void)addButtonAction:(ButtonBlock)block;

-(instancetype) initWithTitleImage;

@end

NS_ASSUME_NONNULL_END
