//
//  JBMNavModel.h
//  JobMarket
//
//  Created by 武建斌 on 2018/5/6.
//  Copyright © 2018年 111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JBMNavModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *imageHighlight;
@property (nonatomic) SEL action;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) NSInteger tag;


- (id)initBackWithTarget:(id)target
                  action:(SEL)action;

- (id)initWithTitle:(NSString *)title
             target:(id)target
             action:(SEL)action;

- (id)initWithTitle:(NSString *)title
             target:(id)target
             action:(SEL)action
              image:(UIImage *)image
     imageHighlight:(UIImage *)imageHighlight;
@end
