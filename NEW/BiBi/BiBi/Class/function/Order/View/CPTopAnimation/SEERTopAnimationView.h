//
//  SEERTopAnimationView.h
//  BiBi
//
//  Created by 武建斌 on 2019/4/10.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SeerBlock)(NSInteger index);
@interface SEERTopAnimationView : UIView
@property (copy, nonatomic) SeerBlock seerpe;
@property (strong, nonatomic) NSMutableArray * items;
@property(assign,nonatomic)NSInteger indexflag;

@property(assign,nonatomic)NSInteger indexflag2;

- (instancetype)initWithFrame:(CGRect)frame WithTitles:(NSArray*)titles flag:(NSInteger)indexfalg andbool:(BOOL)isok;
- (void)resetStates;
- (void)setCurrentStatesWithIndex:(NSInteger)indx;

@end


