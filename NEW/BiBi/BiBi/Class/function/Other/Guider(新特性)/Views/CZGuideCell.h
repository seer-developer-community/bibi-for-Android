//
//  CZGuideCell.h
//  07- 网易彩票(项目准备)
//
//  Created by Apple on 16/3/28.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZGuideCell : UICollectionViewCell

//接收外界 传进来的图片
@property(nonatomic,strong)UIImage *guideImage;

//接收传进来的 角标
- (void)scrowWithIndexpath:(NSIndexPath *)indexpath withCount:(NSInteger)count;


@end
