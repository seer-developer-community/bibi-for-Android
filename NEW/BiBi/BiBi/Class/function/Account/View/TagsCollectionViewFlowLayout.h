//
//  TagsCollectionViewFlowLayout.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/25.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,TagsType){
    TagsTypeWithLeft,
    TagsTypeWithCenter,
    TagsTypeWithRight
};

NS_ASSUME_NONNULL_BEGIN

@interface TagsCollectionViewFlowLayout : UICollectionViewFlowLayout

//两个Cell之间的距离
@property (nonatomic,assign)CGFloat betweenOfCell;
//cell对齐方式
@property (nonatomic,assign)TagsType cellType;

-(instancetype)initWthType : (TagsType)cellType;

@end

NS_ASSUME_NONNULL_END
