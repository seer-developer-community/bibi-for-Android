
#import "JZLoadingViewPacket.h"

@interface JZLoadingViewPacket ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation JZLoadingViewPacket


- (void)showWithTitle:(NSString *)title result:(RequestResult)result hasAnimation:(BOOL)animation {
    
    self.backgroundColor = [UIColor clearColor];
    
    self.hidden = NO;
    
    self.titleLabel.text = title;

    if (result == Loading_suffix) {
        self.imageView.image = [UIImage imageNamed:@"rotationImage"];
    }else if (result == Success_suffix) {
        self.imageView.image = [UIImage imageNamed:@"requestSuccess"];
    }else if (result == Faild_suffix) {
        self.imageView.image = [UIImage imageNamed:@"networkFaild"];
    }

    [self.imageView.layer removeAllAnimations];
    if (animation) {

        CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
        //设置动画完成后保持原状
        animation1.fillMode = kCAFillModeForwards;
        animation1.removedOnCompletion = NO;
        //值
        animation1.fromValue = [NSNumber numberWithFloat:1.0];
        animation1.toValue = [NSNumber numberWithFloat:0];
        animation1.duration = 1.2;


        NSString *keyPath = @"transform.rotation.z";
        CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:keyPath];
        animation2.fillMode = kCAFillModeForwards;
        animation2.removedOnCompletion = NO;
        //值
        animation2.fromValue = [NSNumber numberWithFloat:0];
        animation2.toValue = [NSNumber numberWithFloat:1.5*M_PI];
        animation2.duration = 1.2;

        CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
        groupAnnimation.duration = 1.5;
        groupAnnimation.repeatCount = MAXFLOAT;
        groupAnnimation.animations = @[animation1, animation2];

        groupAnnimation.fillMode = kCAFillModeForwards;
        groupAnnimation.removedOnCompletion = NO;
        [self.imageView.layer addAnimation:groupAnnimation forKey:@"group"];
    }else {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(hide) withObject:nil afterDelay:1.5];
    }

    [self sendSubviewToBack:self.bgView];
    _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.titleLabel.textColor = [UIColor whiteColor];
}



- (void)hide {
    self.hidden = YES;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _bgView.layer.cornerRadius = 5;
        [self addSubview:_bgView];
        
        _bgView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_bgView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-20];
        [self addConstraint:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:_bgView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:20];
        [self addConstraint:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:_bgView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        [self addConstraint:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:_bgView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:100];
        [self addConstraint:constraint];
        
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [self addConstraint:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:25];
        [self addConstraint:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:15];
        [self addConstraint:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15];
        [self addConstraint:constraint];
        
    }
    return _titleLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [self addConstraint:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-10];
        [self addConstraint:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:40];
        [self addConstraint:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:40];
        [self addConstraint:constraint];

    }
    return _imageView;
}


+ (JZLoadingViewPacket *)shareInstance {
    static JZLoadingViewPacket *loading = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loading = [[JZLoadingViewPacket alloc] init];
    });
    return loading;
}
+ (void)showWithTitle:(NSString *)title result:(RequestResult)result hasAnimation:(BOOL)animation addToView:(UIView *)selfView {
    JZLoadingViewPacket *loading = [self shareInstance];
    [selfView addSubview:loading];
    
    loading.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:loading attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:selfView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [selfView addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:loading attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:selfView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [selfView addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:loading attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:selfView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [selfView addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:loading attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:selfView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [selfView addConstraint:constraint];
    
    
    
    [loading showWithTitle:title result:result hasAnimation:animation];
}


@end
