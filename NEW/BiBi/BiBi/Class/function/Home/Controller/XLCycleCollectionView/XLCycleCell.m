//
//  XLCycleCell.m
//  XLCycleCollectionViewDemo
//
//  Created by MengXianLiang on 2017/3/6.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XLCycleCell.h"

@interface XLCycleCell () {
    UILabel *_textLabel;
    UILabel *_timeStopLabel;
    UIImageView *_imageView;
}

//@property(nonatomic,strong)UILabel *timeStopStr;
@end

@implementation XLCycleCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
//    _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
//    _textLabel.textAlignment = NSTextAlignmentCenter;
//    _textLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:50];
//    [self addSubview:_textLabel];
    _imageView = [[UIImageView alloc]init];
//    [_imageView setImage:[UIImage imageNamed:@"Home_banner3"]];
    _imageView.frame = self.bounds;
    [self addSubview:_imageView];
    
    
    _timeStopLabel = [[UILabel alloc]init];
    _timeStopLabel.text = @"截止时间：00：00：00";
    _timeStopLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
    _timeStopLabel.textColor = [UIColor whiteColor];
    _timeStopLabel.numberOfLines = 0;
    [self addSubview:_timeStopLabel];
    
    [_timeStopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-35);
        make.bottom.mas_equalTo(-30);
    }];
    
    _textLabel = [[UILabel alloc]init];
    _textLabel.text = @"来个大发了个看看来个发你了观看能不能不考虑别闹了可能不坑比你更可能不不可能不给老板娘而伟大色放水电费第三方大幅度发大幅度舒服舒服放松放松佛挡杀佛";
    _textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
    _textLabel.textColor = UIColorFromHexValue(0xffffff);
    _textLabel.numberOfLines = 0;
    [self addSubview:_textLabel];
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(30);
        make.right.mas_equalTo(-150);
        make.bottom.mas_equalTo(-55);
      
        
    }];
    
   
    

    
    
    
    
    
}

//- (void)setTitle:(NSString *)title {
//    _title = title;
//    _textLabel.text = title;
//}


-(void)setCellModel:(DetailsModel *)cellModel{
    
    _cellModel =cellModel;
    
    _textLabel.text = cellModel.title;
     NSString *DeadlineStr= NSLocalizedStringFromTable(@"Deadline",@"Internation", nil);
   
    //    [_model valueForKey:<#(nonnull NSString *)#>]
    NSString *timeStr = [cellModel valueForKey:NSLocalizedStringFromTable(@"time",@"Internation", nil)];
   
    _timeStopLabel.text = [NSString stringWithFormat:@"%@:%@",DeadlineStr,timeStr];
    
}

-(void)setImageViewStr:(NSString *)imageViewStr{

    _imageViewStr = imageViewStr;

    [_imageView setImage:[UIImage imageNamed:_imageViewStr]];

}

@end
