//
//  RegisterView.h
//  BiBi
//
//  Created by 武建斌 on 2019/1/28.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterViewDelegate <NSObject>

-(void)registerPushlog;

@end

@interface RegisterView : UIView

@property(nonatomic,weak)id<RegisterViewDelegate>delegate;

@end


