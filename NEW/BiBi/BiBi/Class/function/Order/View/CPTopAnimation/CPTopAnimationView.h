//
//  CPTopAnimationView.h
//  CubePlatformFramework
//
//  Created by 陈彦松 on 2018/6/8.
//  Copyright © 2018年 cmbc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SiwpBlock)(NSInteger index);
@interface CPTopAnimationView : UIView
@property (copy, nonatomic) SiwpBlock swipe;
@property (strong, nonatomic) NSMutableArray * items;
@property(assign,nonatomic)NSInteger indexflag;

@property(assign,nonatomic)NSInteger indexflag2;

- (instancetype)initWithFrame:(CGRect)frame WithTitles:(NSArray*)titles flag:(NSInteger)indexfalg;
- (void)resetStates;
- (void)setCurrentStatesWithIndex:(NSInteger)indx;

@end
