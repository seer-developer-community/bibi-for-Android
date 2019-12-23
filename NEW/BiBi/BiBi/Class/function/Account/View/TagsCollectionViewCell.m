//
//  TagsCollectionViewCell.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/25.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "TagsCollectionViewCell.h"
#import "SDHelper.h"
#import "TagsModel.h"
@implementation TagsCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    UILabel *title = [[UILabel alloc] init];
    
    title.font = [UIFont systemFontOfSize:12];
//    title.layer.cornerRadius = 15.0;
//    title.layer.masksToBounds = YES;
//    title.layer.borderWidth = 1.0;
    title.backgroundColor = [UIColor colorWithRed:45/255.0 green:134/255.0 blue:227/255.0 alpha:0.1];
    title.textAlignment = NSTextAlignmentCenter;
    
    self.title = title;
    [self.contentView addSubview:title];
}

//-(void)setValueWithModel:(TagsModel *)model{
//
//    self.title.text = [NSString stringWithFormat:@"%@",model.title];
//    self.title.frame = CGRectMake(0, 10, 68, 33);
//    self.title.textColor = [UIColor colorWithRed:45/255.0 green:134/255.0 blue:227/255.0 alpha:1.0];
//    self.title.layer.borderColor = [UIColor colorWithRed:45/255.0 green:134/255.0 blue:227/255.0 alpha:1.0].CGColor;
//
//}

-(void)setTextTitle:(NSString *)textTitle{
    
    self.title.text = [NSString stringWithFormat:@"%@",textTitle];
    self.title.frame = CGRectMake(0, 0, 68, 33);
    
}


@end
