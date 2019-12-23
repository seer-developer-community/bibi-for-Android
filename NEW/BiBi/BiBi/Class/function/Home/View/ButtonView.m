//
//  ButtonView.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/23.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "ButtonView.h"

@implementation ButtonView

-(instancetype)init{

    
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
    
}

- (void)setButCount:(NSInteger)butCount {
    _butCount = butCount;
    
    if (_butCount>3) {
        
        _butCount =3;
    }
  
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
    [self setupButton];
    
    
}


-(void)setButArry:(NSArray *)butArry{
    _butArry = butArry;
    
    
}


-(void)setupButton{
    CGFloat margin = 30;
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
   
    CGFloat btnWithd = (ScreenWidth - 100)/self.butCount;
    if (self.butCount == 2) {
        btnWithd = (ScreenWidth-75) /2;
    }
    for (int i = 0; i <self.butCount; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 + i;
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.userInteractionEnabled = NO;
//        button.layer.borderWidth = 0.5f;
//        button.layer.borderColor = UIColorFromHexValue(0x666666).CGColor;
        [button setTitle:self.butArry[i] forState:UIControlStateNormal];
        
        button.titleLabel.lineBreakMode  = NSLineBreakByTruncatingTail;
        
        button.backgroundColor = UIColorFromHexValue(0x2A7DDF);
        
        button.layer.cornerRadius = 16.7;
        
        button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
        
        [button setTitleColor: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
       [ button setGradientBackgroundWithColors:@[UIColorFromHexValue(0x2A7DDF),UIColorFromHexValue(0x38AFF4)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        
        button.frame = CGRectMake(w, 0, btnWithd, self.height);
        [self addSubview:button];
        w += btnWithd;
        w += margin;
    }
    [self layoutIfNeeded];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat btnWithd = (ScreenWidth - 100)/_butCount;
    if (self.butCount == 2) {
        btnWithd = (ScreenWidth-75) /2;
    }
    CGFloat margin = 25;

    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    for (UIView * subV in self.subviews) {
        subV.frame = CGRectMake(w, 0, btnWithd, self.height);
        w += btnWithd;
        w += margin;

    }
}

@end
