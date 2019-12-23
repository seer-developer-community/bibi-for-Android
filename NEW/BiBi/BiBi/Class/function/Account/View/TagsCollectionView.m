//
//  TagsCollectionView.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/25.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "TagsCollectionView.h"
#import "TagsModel.h"
#import "SDHelper.h"
#import "TagsCollectionViewCell.h"
#define SDtagsView @"SDtagsView"
#define SDtagsHeadView @"SDtagsHeadView"

@interface TagsCollectionView ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

/**
 存放cell唯一标识符
 */
@property (nonatomic,strong)NSMutableDictionary *cellIdDic;

@end


@implementation TagsCollectionView



-(NSMutableDictionary *)cellIdDic{
    if (!_cellIdDic){
        _cellIdDic =[NSMutableDictionary dictionary];
    }
    return _cellIdDic;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        //注册
        [self registerClass:[TagsCollectionViewCell class] forCellWithReuseIdentifier:SDtagsView];
        //注册头部
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SDtagsHeadView];
        
    }
    return self;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *arr =self.dataArr[section];
    
    return arr.count;
}

//cell的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(68,33);
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //每次从字典中取出根据IndexPath取出唯一标识符
      TagsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SDtagsView forIndexPath:indexPath];
    if (indexPath.section == 0) {
        
        NSArray *arr =self.dataArr[indexPath.section];
        
        
        cell.backgroundColor = [UIColor redColor];
        
        cell.textTitle = arr[indexPath.row];
    }else{
        
        
        NSArray *arr =self.dataArr[indexPath.section];
        
        cell.backgroundColor = [UIColor yellowColor];
        
        cell.textTitle = arr[indexPath.row];
      
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{


    if ([self.sd_delegate respondsToSelector:@selector(SDCollectionTagsView:didSelectItemAtIndexPath:)]){
        [self.sd_delegate SDCollectionTagsView:self didSelectItemAtIndexPath:indexPath ];
    }

//    NSLog(@"index:%@",model.title);
}

//头部试图大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenW, 200);
}
//头视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *headView =(UICollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SDtagsHeadView forIndexPath:indexPath];
    UILabel *titlelabel =[[UILabel  alloc]init];
    titlelabel.frame =CGRectMake(20, 0, kScreenW-10, 200);
    titlelabel.textColor =fontHightColor;

//    UILabel *detaillabel =[[UILabel  alloc]init];
//    detaillabel.frame =CGRectMake(100, 0, kScreenW-100, 30);
//    detaillabel.textColor =fontNomalColor;
//    detaillabel.font =[UIFont systemFontOfSize:12];
//    titlelabel.textColor =fontHightColor;
    if (indexPath.section==0){
        titlelabel.text =@"请根据你记下的助记词，按顺序点击，验证你备份的助记词正确无误";
        titlelabel.numberOfLines = 0;

//        detaillabel.text =@"(点击我的标签可以移除)";

    }
    else if(indexPath.section==1){
        titlelabel.text =@"所有标签";
//        detaillabel.text =@"(点击所有标签添加到我的标签)";
    }


    //头部view下划线
    UIView *line =[[UIView alloc]init];
    line.backgroundColor =borderCol;
    line.frame =CGRectMake(0, 30, kScreenW, 0.5);
    [headView addSubview:line];
    [headView addSubview:titlelabel];
//    [headView addSubview:detaillabel];
    return headView;
}


@end
