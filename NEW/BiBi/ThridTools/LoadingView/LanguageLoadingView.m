//
//  LanguageLoadingView.m
//  BiBi
//
//  Created by 武建斌 on 2019/2/13.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "LanguageLoadingView.h"

@interface LanguageLoadingView ()

@property (nonatomic ,strong) UIImageView *loadingImageView;

@end
@implementation LanguageLoadingView


-(id)init
{
    if (self = [super init])
    {
        
        self.frame = [UIScreen mainScreen].bounds;
        //        self.loadingImageView = [[UIImageView alloc]init];
        //        [self addSubview:self.loadingImageView];
        //        self.loadingImageView.frame = CGRectMake((ScreenWidth-30)/2, (ScreenHeight-30)/2, 40, 40);
        //        self.loadingImageView.image = [UIImage imageNamed:@"juhua_icon"];
        
        [self setupUI];
        
    }
    return self;
}




-(void)setupUI{
    
    UIView *whiteView = [[UIView alloc]init];
    whiteView.backgroundColor = [UIColor blackColor];
//    whiteView.alpha = 0.5;
    whiteView.layer.cornerRadius = 15;
    [self addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(18, 180));
    }];
    
    self.loadingImageView = [[UIImageView alloc]init];
    self.loadingImageView.image = [UIImage imageNamed:@""];
    [whiteView addSubview:self.loadingImageView];
    
    [self.loadingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    UILabel *lodingLabel = [[UILabel alloc]init];
    lodingLabel.text = NSLocalizedStringFromTable(@"Set Language",@"Internation", nil);
    lodingLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 18.7];
    lodingLabel.textColor = [UIColor whiteColor];
    [whiteView addSubview:lodingLabel];
    
    [lodingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loadingImageView.mas_bottom).offset(15);
        make.centerX.mas_equalTo(0);
    }];
    
    [self showAnimation];
}

-(void)showAnimation{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1.0f];
    
}





- (void)showLoadingView
{
    [UIView animateWithDuration:0.25 animations:^{
        CABasicAnimation *animation=[CABasicAnimation         animationWithKeyPath:@"transform.rotation.z"];
        // 设定动画选项
        animation.duration = 2.5;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount =HUGE_VALF;
        // 设定旋转角度
        animation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
        animation.toValue = [NSNumber numberWithFloat:2 * M_PI]; // 终止角度
        [self.loadingImageView.layer addAnimation:animation forKey:@"rotate-layer"];
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}

- (void)cancelView
{
    [UIView animateWithDuration:0.25 animations:^{
        [self removeFromSuperview];
    } completion:^(BOOL finished) {
    }];
    
    
    
}

@end
