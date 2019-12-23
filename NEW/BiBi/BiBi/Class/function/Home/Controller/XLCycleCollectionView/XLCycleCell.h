//
//  XLCycleCell.h
//  XLCycleCollectionViewDemo
//
//  Created by MengXianLiang on 2017/3/6.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsModel.h"
@interface XLCycleCell : UICollectionViewCell

//@property (nonatomic, copy) NSString *title;
@property(nonatomic,strong)DetailsModel *cellModel;

@property(nonatomic,strong) NSString * imageViewStr;

@end
