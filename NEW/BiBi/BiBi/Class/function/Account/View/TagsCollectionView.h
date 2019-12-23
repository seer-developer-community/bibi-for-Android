//
//  TagsCollectionView.h
//  BiBi
//
//  Created by 武建斌 on 2018/12/25.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SDCollectionTagsViewDelegate <NSObject>

- (void)SDCollectionTagsView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end






@interface TagsCollectionView : UICollectionView



/**
 数据源
 */
@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic,weak) id<SDCollectionTagsViewDelegate>sd_delegate;

@end


