//
//  CZGuideCollectionController.m
//  07- 网易彩票(项目准备)
//
//  Created by Apple on 16/3/28.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CZGuideCollectionController.h"
#import "CZGuideCell.h"

@interface CZGuideCollectionController ()

//设置关联的属性
@property(nonatomic,weak)UIImageView *bigIamgeView;
@property(nonatomic,weak)UIImageView *bigTextIamgeView;
@property(nonatomic,weak)UIImageView *smallTextIamgeView;


//记录上一个 page 是多少
@property(nonatomic,assign)NSInteger upPage;

@end

@implementation CZGuideCollectionController

- (instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置itm的大小
    flowLayout.itemSize = kScreenBounds.size;
    flowLayout.minimumLineSpacing = 0;
    
    //设置横向滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:flowLayout];
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //弹动禁止
    self.collectionView.bounces = NO;
    
    //分页
    self.collectionView.pagingEnabled = YES;
  
    //取消横向的滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;

    [self.collectionView registerClass:[CZGuideCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //添加剩余的图片
//
//    //1.最长的线
//    UIImageView *lineImageView = [[UIImageView alloc]init];
//    lineImageView.image = [UIImage imageNamed:@"guideLine"];
    
//    lineImageView.x = -200;
//
//    [lineImageView sizeToFit];
//    [self.collectionView addSubview:lineImageView];
    
//    //2.大图片
//    UIImageView *bigImageView = [[UIImageView alloc]init];
//    bigImageView.image = [UIImage imageNamed:@"Guide1"];
////    bigImageView.y = self.collectionView.h * 0.8;
//
//    [bigImageView sizeToFit];
//    [self.collectionView addSubview:bigImageView];
//    self.bigIamgeView = bigImageView;
    
    
    //3.大文字
//    UIImageView *bigTextImageView = [[UIImageView alloc]init];
//    bigTextImageView.image = [UIImage imageNamed:@"guideLargeText1"];
//    bigTextImageView.y = self.collectionView.h * 0.7;
//
//    [bigTextImageView sizeToFit];
//    [self.collectionView addSubview:bigTextImageView];
//    self.bigTextIamgeView = bigTextImageView;
    
    
    //4.小文字
//    UIImageView *smallTextImageView = [[UIImageView alloc]init];
//    smallTextImageView.image = [UIImage imageNamed:@"guideSmallText1"];
//
//    smallTextImageView.y = self.collectionView.h * 0.8;
//
//    [smallTextImageView sizeToFit];
//    [self.collectionView addSubview:smallTextImageView];
//    self.smallTextIamgeView = smallTextImageView;
    
  
}

//监听滚动  通过偏移量  判断第几页 添加Image
////滚动短暂的停止
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    
//    //1.获取偏移量
//   CGPoint offset =  scrollView.contentOffset;
//    
//    //2.获取x 偏移量
//    CGFloat offsetX = offset.x;
//    
//    //3.获取分页 是第几页
//    
//    NSInteger pageNum = offsetX / kScreenWidth;
//    
//   
//    //用 第几页做判断  向左 还是向右
//    CGFloat startX;
//    
//    if (self.upPage > pageNum) { //上一个 page  D大于现在你看到的页面的page  往右滚
//        
//        startX = offsetX - kScreenWidth;
//        
//        
//        
//    }else{ //网左滚
//    
//    
//        startX = offsetX + kScreenWidth;
//    
//    }
//
//    
//    
//    //骗过用户 瞬间跳过去
//    self.bigIamgeView.left = startX;
////    self.bigTextIamgeView.x = startX;
////    self.smallTextIamgeView.x = startX;
//    
//    
//    
//    //4.设置 图片
//    NSString *bigName = [NSString stringWithFormat:@"Guide%@",@(pageNum +1)];
////    NSString *bigTextName = [NSString stringWithFormat:@"guideLargeText%@",@(pageNum +1)];
////    NSString *smallTextName = [NSString stringWithFormat:@"guideSmallText%@",@(pageNum +1)];
//    
//    
//    self.bigIamgeView.image = [UIImage imageNamed:bigName];
////    self.bigTextIamgeView.image = [UIImage imageNamed:bigTextName];
////    self.smallTextIamgeView.image = [UIImage imageNamed
////                                     :smallTextName];
//    
//    //设置 控件的X 值
//    [UIView animateWithDuration:2 animations:^{
//        
//        self.bigIamgeView.left = offsetX;
////        self.bigTextIamgeView.x = offsetX;
////        self.smallTextIamgeView.x = offsetX;
//    }];
//
//    
//    
//    //把现在的page  记录下来 ,下次使用
//    self.upPage = pageNum;
//    
//
//}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CZGuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString *GuideStr = NSLocalizedStringFromTable(@"Guide",@"Internation", nil);
    NSString *imageName = [NSString stringWithFormat:@"%@%@",GuideStr,@(indexPath.row + 1)];
    cell.guideImage = [UIImage imageNamed:imageName];
    
    [cell scrowWithIndexpath:indexPath withCount:3];
    
    
    return cell;
}



















#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
