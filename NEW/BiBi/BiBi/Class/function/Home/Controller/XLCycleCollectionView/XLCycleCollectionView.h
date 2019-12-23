//
//  XLCycleCollectionView.h
//  XLCycleCollectionViewDemo
//
//  Created by MengXianLiang on 2017/3/6.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsModel.h"

@protocol CPColltionViewboardProtocol <NSObject>
- (void)selectedIndex:(NSInteger)index;
@end


@interface XLCycleCollectionView : UIView

@property (nonatomic, strong) NSArray<NSString *> *data;

@property(nonatomic,strong)NSArray*HeadModelArry;

@property (weak, nonatomic) id< CPColltionViewboardProtocol> delegate;

@end
