//
//  JBMNavView.m
//  JobMarket
//
//  Created by 武建斌 on 2018/5/6.
//  Copyright © 2018年 111. All rights reserved.
//

#import "JBMNavView.h"
#define LoadingText @""
#define barButtonWidth 44
#define barButtonHeight 44
#define rightBarButtonWidth 66
@interface JBMNavView()

@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UILabel *navLabel;
//@property (nonatomic, strong) UIButton *leftBarButton; //大小为 (44 , 44)
//@property (nonatomic, strong) UIButton *rightBarButton;//大小为 (44 , 44)
@property (nonatomic, strong) UIButton *closeBarButton;//大小为 （44， 44）

//
@end

@implementation JBMNavView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = UIColorFromHexValue(0x4b75cc);
        self.backgroundColor =[UIColor whiteColor];

        [self loadingSubviews];
    }
    return self;
}
//
- (void)loadingSubviews
{
    CGFloat OriginY = 0.0f;
    if (IOS7_OR_LATER)
    {
        OriginY = STATUS_GAP;
    }

    CGRect backgroundImageFrame = CGRectMake(0, 0, ScreenWidth, 44 + OriginY);
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:backgroundImageFrame];
    self.backgroundImageView.userInteractionEnabled = YES;
    self.backgroundImageView.backgroundColor = UIColorFromHexValue(0x4b75cc);
    self.backgroundImageView.hidden = YES;

    CGRect titleImageFrame = CGRectMake(0, OriginY, ScreenWidth, 44 );
    self.titleImageView = [[UIImageView alloc] initWithFrame:titleImageFrame];
    self.titleImageView.userInteractionEnabled = YES;
    self.titleImageView.hidden = YES;

    self.navLabel =[[UILabel alloc] init];
    self.navLabel.text = LoadingText;
    self.navLabel.font = [UIFont systemFontOfSize:22];
    self.navLabel.frame = CGRectMake(44, OriginY, ScreenWidth - 88, 44);
    self.navLabel.textAlignment = NSTextAlignmentCenter;
    self.navLabel.textColor = [UIColor blackColor];
    self.navLabel.backgroundColor = [UIColor clearColor];
    self.navLabel.hidden = YES;

    self.leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBarButton setFrame:CGRectMake( 0, OriginY, barButtonWidth, barButtonHeight)];
    [self.leftBarButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
//    [self.leftBarButton setImage:[UIImage imageNamed:@"mycase_back"] forState:UIControlStateNormal];
    [self.leftBarButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    self.leftBarButton.hidden = YES;
    self.leftBarButton.showsTouchWhenHighlighted = YES;

    self.rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBarButton setFrame:CGRectMake( ScreenWidth-rightBarButtonWidth, OriginY, rightBarButtonWidth, barButtonHeight)];
    [self.rightBarButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.rightBarButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    self.rightBarButton.hidden = YES;
    self.rightBarButton.showsTouchWhenHighlighted = YES;

    self.closeBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBarButton setFrame:CGRectMake(barButtonWidth, OriginY, barButtonWidth, barButtonHeight)];
    [self.closeBarButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.closeBarButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    self.closeBarButton.hidden = YES;
    self.closeBarButton.showsTouchWhenHighlighted = YES;

    [self addSubview:self.backgroundImageView];
    [self addSubview:self.titleImageView];
    [self addSubview:self.navLabel];
    [self addSubview:self.leftBarButton];
    [self addSubview:self.rightBarButton];
    [self addSubview:self.closeBarButton];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _navLabel.hidden = NO;
    _navLabel.text = title;
//    _navLabel.textColor = UIColorFromHexValue(0xffffff);
//    _navLabel.textColor =  [UIColor colorWithRed:34.0f/255.0f green:34.0f/255.0f blue:34.0f/255.0f alpha:1.0f];
    _navLabel.textColor = [UIColor blackColor];
    _navLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18*kWidthScale];
}
-(void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    
    self.backgroundImageView.hidden = NO;
    self.backgroundImageView.image =backgroundImage;
    
    
}



-(void)setLefBarButtonImage:(UIImage *)lefBarButtonImage{
    _lefBarButtonImage = lefBarButtonImage;
    self.leftBarButton.hidden = NO;
    self.leftBarButton.showsTouchWhenHighlighted = NO;
    [self.leftBarButton setImage: _lefBarButtonImage forState:UIControlStateNormal];
    
}
-(void)setRightBarButtonImage:(UIImage *)rightBarButtonImage{
    _rightBarButtonImage = rightBarButtonImage;
    self.rightBarButton.hidden = NO;
    self.rightBarButton.showsTouchWhenHighlighted = NO;
    
    [self.rightBarButton setImage:_rightBarButtonImage forState:UIControlStateNormal];
    
}


@end
