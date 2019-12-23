//
//  CPPassWordKeyboard.m
//  随便
//
//  Created by 陈彦松 on 2018/12/23.
//  Copyright © 2018年 cmbc. All rights reserved.
//

#import "CPPassWordKeyboard.h"
@interface CPPassWordKeyboardCell : UICollectionViewCell

@property (strong, nonatomic) UILabel * numberLable;


@end
@implementation CPPassWordKeyboardCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        self.contentView.layer.masksToBounds = YES;
        
        self.contentView.layer.cornerRadius = 15;
    }
    return self;
}

- (void)initUI {
    _numberLable = [[UILabel alloc] init];
    _numberLable.frame = self.contentView.bounds;
    _numberLable.textAlignment = NSTextAlignmentCenter;
    _numberLable.backgroundColor = [UIColor whiteColor];
    _numberLable.textColor = [UIColor blueColor];
    [self.contentView addSubview:_numberLable];

}
@end






@interface CPPassWordKeyboard ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView * collectionView;
@property (strong, nonatomic) NSArray * dataSoucre;


@end
@implementation CPPassWordKeyboard

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *reset = NSLocalizedStringFromTable(@"reset",@"Internation", nil);
        NSString *delete = NSLocalizedStringFromTable(@"delete",@"Internation", nil);
        _dataSoucre  = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",reset,@"0",delete];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    CGFloat screnW = [UIScreen mainScreen].bounds.size.width;
//    CGFloat screnH = [UIScreen mainScreen].bounds.size.height;

    CGFloat itemWidth = (screnW - 10 * 2 - 30) / 3.0;
//    CGFloat padding =  10;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(itemWidth, 33);
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 10;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width-30, 200) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:220/255.0 alpha:1.0];
    [_collectionView registerClass:[CPPassWordKeyboardCell class] forCellWithReuseIdentifier:@"CPPassWordKeyboardcell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
    
   
    
    
}


#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSoucre.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CPPassWordKeyboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CPPassWordKeyboardcell" forIndexPath:indexPath];
    cell.numberLable.text = _dataSoucre[indexPath.item];
    cell.numberLable.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 18.7];
    cell.numberLable.textColor = UIColorFromHexValue(0x444444);
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedIndex:andText:)]) {
        [self.delegate selectedIndex:indexPath.item andText:_dataSoucre[indexPath.item]];
    }
}
@end
