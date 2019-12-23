//
//  NoteTagsViewController.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/25.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "NoteTagsViewController.h"
#import "TagsModel.h"
#import "TagsCollectionView.h"
#import "TagsCollectionViewFlowLayout.h"

//#define tagsDataFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tagsData.data"]

@interface NoteTagsViewController ()
<SDCollectionTagsViewDelegate>
/**
 上面标签
 */
@property (nonatomic,strong)NSMutableArray *myTagsArr;


/**
 下面固定标签
 */
@property (nonatomic,strong)NSMutableArray *moreTagsArr;

/**
 所有标签数据
 */
@property (nonatomic,strong)NSMutableArray *dataArr;

/**
 tagsView
 */

@property(nonatomic,strong)TagsCollectionView *tagsView;




@end

@implementation NoteTagsViewController

//上面标签

-(NSMutableArray *)myTagsArr{
    if (!_myTagsArr) {

        if (!_myTagsArr) {
            _myTagsArr =[NSMutableArray array];
        }
    }
    return _myTagsArr;
}

//下面标签
-(NSMutableArray *)moreTagsArr{
    if (!_moreTagsArr){

        NSString * str = @"JHOW BALLOT CALLOUS HEADCAP AMNESIC TARSIER HELLUO SEEKER OPERAE CURLIKE PUTT HOOPOE RUSPONE JARRA ODORANT ACEPHAL";
        
        NSString *str1 = [str lowercaseString];
        NSArray *tagsArry =[str1  componentsSeparatedByString:@" "];
        _moreTagsArr =[NSMutableArray arrayWithArray:tagsArry];
    
    }
    return _moreTagsArr;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr){
        _dataArr =[NSMutableArray array];
        [_dataArr addObject:self.myTagsArr];
        [_dataArr addObject:self.moreTagsArr];
    }
    return _dataArr;
}



-(TagsCollectionView *)tagsView{
    if (!_tagsView){
       TagsCollectionViewFlowLayout *flowLayout = [[TagsCollectionViewFlowLayout alloc]init];
        flowLayout.betweenOfCell = 30;
        _tagsView =[[TagsCollectionView alloc]initWithFrame:CGRectMake(0, 50, kScreenW, kScreenH) collectionViewLayout:flowLayout];
        _tagsView.sd_delegate =self;
    }
    return _tagsView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =self.navTitle;
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.tagsView];
    self.tagsView.dataArr =[NSMutableArray arrayWithArray:self.dataArr];
    [self.tagsView reloadData];
    
}

#pragma mark - SDCollectionTagsViewDelegate

-(void)SDCollectionTagsView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *tagsModel;
    if (indexPath.section ==0) //我的标签
    {
        tagsModel = self.myTagsArr[indexPath.row];
        [self.myTagsArr removeObjectAtIndex:indexPath.row];
        [self.tagsView deleteItemsAtIndexPaths:@[indexPath]];
        [self.moreTagsArr addObject:tagsModel];
        NSIndexPath *indePath1 = [NSIndexPath indexPathForItem:self.moreTagsArr.count -1 inSection:1];
        [self.tagsView insertItemsAtIndexPaths:@[indePath1]];
        
    }
    
    if (indexPath.section ==1) //所有标签
    {
        tagsModel =self.moreTagsArr[indexPath.row];
        [self.moreTagsArr removeObjectAtIndex:indexPath.row];
        [self.tagsView deleteItemsAtIndexPaths:@[indexPath]];
        [self.myTagsArr addObject:tagsModel];
        NSIndexPath *indePath1 = [NSIndexPath indexPathForItem:self.myTagsArr.count -1 inSection:0];
        [self.tagsView insertItemsAtIndexPaths:@[indePath1]];
        
    }
    [self.dataArr removeAllObjects];
    [self.dataArr addObject:self.myTagsArr];
    [self.dataArr addObject:self.moreTagsArr];
    
    
    
}


-(void)dealloc{
    
    
    NSLog(@"页面销毁");
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
