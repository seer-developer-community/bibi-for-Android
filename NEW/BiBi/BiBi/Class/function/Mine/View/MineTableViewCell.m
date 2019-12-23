//
//  MineTableViewCell.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/17.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
      static NSString *identifier = @"wallet";
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell =[[MineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        [self setupUI];
        self.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return self;
}

-(void)setupUI{
    
  //  cell的图片
    
    UIImageView *cellImageView = [[UIImageView alloc]init];
    cellImageView.frame =CGRectMake(15, 15, 16, 16);
    self.cellimageView = cellImageView;
    [self addSubview:cellImageView];
    
    
    //cell文字
    
    UILabel * cellLabel = [[UILabel alloc]init];
    cellLabel.frame = CGRectMake(40,15*kHeightScale,200,21);
    cellLabel.centerY = cellImageView.centerY;
    cellLabel.numberOfLines = 0;
    cellLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
    cellLabel.textColor = [UIColor colorWithRed:31/255.0 green:55/255.0 blue:118/255.0 alpha:1.0];
    self.cellLabel = cellLabel;
     [self addSubview:cellLabel];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
