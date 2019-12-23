//
//  CPTopAnimationView.m
//  CubePlatformFramework
//
//  Created by 陈彦松 on 2018/6/8.
//  Copyright © 2018年 cmbc. All rights reserved.
//

#import "CPTopAnimationView.h"

@interface CPTopAnimationView ()

@property (strong, nonatomic) UIView * titleUnderline;
@property (strong, nonatomic) UIButton * previousClickedTitleButton;

@end

@implementation CPTopAnimationView

- (instancetype)initWithFrame:(CGRect)frame WithTitles:(NSArray*)titles flag:(NSInteger)indexfalg
{
    self = [super initWithFrame:frame];
    if (self) {
        _items = [NSMutableArray array];
            NSLog(@"这个索引是多少aaaaaaa%ld",indexfalg);
        [self setUpUIWithTitiles:titles flag:indexfalg];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setUpUIWithTitiles:(NSArray*)titles flag:(NSInteger)indexfalg {
    
    UIView *bagView = [[UIView alloc]init];
    bagView.frame = CGRectMake(15, 0, kScreenW-30, 44);
    bagView.backgroundColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bagView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bagView.bounds;
    maskLayer.path = maskPath.CGPath;
    bagView.layer.mask = maskLayer;
    [self addSubview:bagView];

    NSUInteger count = titles.count;
    // 标题按钮的尺寸
    CGFloat titleButtonW = bagView.width / count;
    CGFloat titleButtonH = self.height;
    
    
    // 创建标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *titleButton = [[UIButton alloc] init];
        titleButton.tag = i;
        [titleButton setTitleColor:UIColorFromHexValue(0x333333) forState:UIControlStateNormal];//3479DF
        [titleButton setTitleColor:UIColorFromHexValue(0x3479DF) forState:UIControlStateSelected];//

        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bagView addSubview:titleButton];
        // frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        // 文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:16];
//        titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_items addObject:titleButton];
    }

    UIButton *firstTitleButton = bagView.subviews[indexfalg];
    

    
    // 下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.height = 2;
    titleUnderline.width =firstTitleButton.width/4;
    titleUnderline.centerX = firstTitleButton.centerX;
    titleUnderline.top = bagView.height - titleUnderline.height;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [bagView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    // 切换按钮状态
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    self.previousClickedTitleButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [firstTitleButton.titleLabel sizeToFit];
    self.titleUnderline.width = ScreenWidth/count/4;
    self.titleUnderline.centerX = firstTitleButton.centerX;

//    for (NSUInteger i = 0; i < (count - 1); i++) {
//        UIView * margrinV = [[UIView alloc] initWithFrame:CGRectMake((i +1) * titleButtonW, 12, 1, self.height - 24)];
//        margrinV.backgroundColor = UIColorFromHexValue(0xe0e0e0);
//        [bagView addSubview:margrinV];
//    }
}

- (void)titleButtonClick:(UIButton*)titleButton {
    if (self.previousClickedTitleButton == titleButton) {
        //重复点击
    }
    // 处理标题按钮点击
    [self dealTitleButtonClick:titleButton];

}
- (void)dealTitleButtonClick:(UIButton *)titleButton{
    // 切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    self.previousClickedTitleButton.titleLabel.font = [UIFont systemFontOfSize:16];

    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    NSUInteger index = titleButton.tag;
    self.previousClickedTitleButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [UIView animateWithDuration:0.25 animations:^{
        // 处理下划线
//        self.titleUnderline.width = titleButton.titleLabel.width+ 10;
        self.titleUnderline.width = ScreenWidth/self->_items.count/4;
        self.titleUnderline.centerX = titleButton.centerX;
    } completion:^(BOOL finished) {
        if (self.swipe) {
            self.swipe(index);
        }
    }];
    
}




- (void)resetStates {
    id  views = [_items objectAtIndex:0];
    if ([views isKindOfClass:[UIButton class]]) {
        UIButton * firstButton = views;
        self.previousClickedTitleButton.selected = NO;
        firstButton.selected = YES;
        self.previousClickedTitleButton = firstButton;
//        NSUInteger index = firstButton.tag;
        [UIView animateWithDuration:0.25 animations:^{
            // 处理下划线
            self.titleUnderline.width = ScreenWidth/self->_items.count/4;
            self.titleUnderline.centerX = firstButton.centerX;
        } completion:^(BOOL finished) {
        }];
    }
}
- (void)setCurrentStatesWithIndex:(NSInteger)indx {
    if (indx == self.previousClickedTitleButton.tag)return;
        
    id  views = [_items objectAtIndex:indx];
    if ([views isKindOfClass:[UIButton class]]) {
        UIButton * firstButton = views;
        self.previousClickedTitleButton.selected = NO;
        firstButton.selected = YES;
        self.previousClickedTitleButton = firstButton;
        //        NSUInteger index = firstButton.tag;
        [UIView animateWithDuration:0.25 animations:^{
            // 处理下划线
            self.titleUnderline.width = ScreenWidth/self->_items.count;
            self.titleUnderline.centerX = firstButton.centerX;
        } completion:^(BOOL finished) {
        }];
    }

}

//-(void)setIndexflag:(NSInteger)indexflag{
//
//    _indexflag = indexflag;
//    self.indexflag2 = _indexflag;
////    self.indexflag = indexflag;
//
//    NSLog(@"这个值是多少朵svrgghh%ld",indexflag);
//    NSArray * itemArray = @[@"进行中",@"待结算",@"已结束"];
//
//    [self setUpUIWithTitiles:itemArray flag:indexflag];
//
//    
//}



@end
