//
//  NewOrderCell.m
//  BiBi
//
//  Created by 武建斌 on 2019/4/10.
//  Copyright © 2019 武建斌. All rights reserved.
//

#import "NewOrderCell.h"

@implementation NewOrderCell


+(instancetype)cellWithTableView:(UITableView *)tabelView{
    static NSString *cellID = @"NewOrderCell";
    NewOrderCell *cell = [tabelView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[NewOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    
    }
    return self;
}


-(void)setupUI{
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
