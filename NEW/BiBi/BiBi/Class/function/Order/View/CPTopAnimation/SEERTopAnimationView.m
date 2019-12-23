//
//  SEERTopAnimationView.m
//  BiBi
//
//  Created by 武建斌 on 2019/4/10.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "SEERTopAnimationView.h"

@interface SEERTopAnimationView ()

@property (strong, nonatomic) UIView * titleUnderline;
@property (strong, nonatomic) UIButton * previousClickedTitleButton;

@end

@implementation SEERTopAnimationView

- (instancetype)initWithFrame:(CGRect)frame WithTitles:(NSArray*)titles flag:(NSInteger)indexfalg andbool:(BOOL)isok
{
    self = [super initWithFrame:frame];
    if (self) {
        _items = [NSMutableArray array];
        NSLog(@"这个索引是多少-----%ld",(long)indexfalg);
        [self setUpUIWithTitiles:titles flag:indexfalg andbool:isok];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setUpUIWithTitiles:(NSArray*)titles flag:(NSInteger)indexfalg andbool:(BOOL)isok{
    UIView *bagView = [[UIView alloc]init];
    if (titles.count ==1) {
         bagView.frame = CGRectMake(0, 0, 80, 35);
    }else{
        bagView.frame = CGRectMake(0, 0, kScreenW-30, 35);
    }
    bagView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bagView];
    
    NSUInteger count = titles.count;
    // 标题按钮的尺寸
    CGFloat titleButtonW = bagView.width/count;
    CGFloat titleButtonH = self.height;
    
    
    // 创建标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *titleButton = [[UIButton alloc] init];
        titleButton.tag = i;
        [titleButton setTitleColor:UIColorFromHexValue(0x333333) forState:UIControlStateNormal];//3479DF
        [titleButton setTitleColor:UIColorFromHexValue(0x3479DF) forState:UIControlStateSelected];//
        //判断是否能点击
        titleButton.enabled = isok;
        
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bagView addSubview:titleButton];
        // frame
        if (count>3) {
            titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        }else{
          titleButton.frame = CGRectMake(i * (80+15), 0, 80, titleButtonH);
        }
        
        // 文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        if ([titles[i] isEqualToString:@"SEER"]) {
            [titleButton setImage:[UIImage imageNamed:@"seer_orderimage"]forState:UIControlStateNormal];
             }else if ([titles[i] isEqualToString:@"USDT"]){
                 [titleButton setImage:[UIImage imageNamed:@"usdt_orderimage"]forState:UIControlStateNormal];
             }else if ([titles[i] isEqualToString:@"PFC"]){
                  [titleButton setImage:[UIImage imageNamed:@"PFC_orderimage"]forState:UIControlStateNormal];
             }else{
                  [titleButton setImage:[UIImage imageNamed:@"wallet_N"]forState:UIControlStateNormal];
             }
      
        titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
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
    self.previousClickedTitleButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [firstTitleButton.titleLabel sizeToFit];
    if (count ==1) {
       self.titleUnderline.width = ScreenWidth/10;
    }else{
       self.titleUnderline.width = ScreenWidth/count/4;
    }
    
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
    self.previousClickedTitleButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    NSUInteger index = titleButton.tag;
    self.previousClickedTitleButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [UIView animateWithDuration:0.25 animations:^{
        // 处理下划线
        //        self.titleUnderline.width = titleButton.titleLabel.width+ 10;
        self.titleUnderline.width = ScreenWidth/self->_items.count/4;
        self.titleUnderline.centerX = titleButton.centerX;
    } completion:^(BOOL finished) {
        if (self.seerpe) {
            self.seerpe(index);
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
