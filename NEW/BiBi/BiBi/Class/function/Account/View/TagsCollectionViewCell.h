//
//  TagsCollectionViewCell.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/25.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TagsModel;
NS_ASSUME_NONNULL_BEGIN

@interface TagsCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UILabel *title;

@property(nonatomic,copy)NSString *textTitle;
//-(void)setValueWithModel:(TagsModel *)model;

@end

NS_ASSUME_NONNULL_END
