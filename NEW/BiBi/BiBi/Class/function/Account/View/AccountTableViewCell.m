//
//  AccountTableViewCell.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/17.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "AccountTableViewCell.h"

@implementation AccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"accountTableViewCell";
    AccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell =[[AccountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        [self setupUI];
//        self.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return self;
}

-(void)setupUI{
    
    UIImageView *cellImageView = [[UIImageView alloc]init];
    cellImageView.image = [UIImage imageNamed:@"account_back"];
    self.cellimageView = cellImageView;
    [self addSubview:cellImageView];
    
    [cellImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(5*kScaleW);
                make.right.mas_equalTo(-5*kScaleW);
                make.bottom.mas_equalTo(5*kScaleH);
        
//        make.size.mas_equalTo(CGSizeMake(407, 93));
    
    }];
    
    //seer图片
    UIImageView *seerImageView = [[UIImageView alloc]init];
    self.bizhongimageView = seerImageView;
    [seerImageView setImage:[UIImage imageNamed:@"account_seer"]];

    [cellImageView addSubview:seerImageView];

    [seerImageView  mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.mas_equalTo(cellImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40*kWidthScale, 40*kHeightScale));
        make.left.mas_equalTo(cellImageView.mas_left).offset(20*kWidthScale);

    }];

    UILabel *seerLabel = [[UILabel alloc]init];

    seerLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 17.3];

    seerLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    [seerLabel setText:@"SEER"];
    self.bizhongtextcount = seerLabel;

    [cellImageView addSubview:seerLabel];

    

    [seerLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.mas_equalTo(0);

        make.left.mas_equalTo(seerImageView.mas_right).offset(15*kWidthScale);

    }];


    UILabel *yueLabel = [[UILabel alloc]init];

    yueLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 17.3];

    yueLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];

    self.cellLabel = yueLabel;

    [cellImageView addSubview:yueLabel];

    [yueLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-20*kWidthScale);

    }];

//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(281.3,101.7,106,13);
//    label.numberOfLines = 0;
//    [self.view addSubview:label];
//
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"523678.3787" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 17.3],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
//
//    label.attributedText = string;
    
 
}

//-(void)setTextcount:(NSString *)textcount{
//    _textcount = textcount;
//    
//    self.textLabel.text = textcount;
//    
//    
//}

-(void)setModel:(PredictHeaderModel *)model{
    _model = model;
    self.cellLabel.text =[NSString stringWithFormat:@"%.5f", model.minNub];
    if ([model.ass_id isEqualToString:@"1.3.0"]) {
        self.cellimageView.image =[UIImage imageNamed:@"account_back"];
        self.bizhongimageView.image =[UIImage imageNamed:@"account_seer"];
        self.bizhongtextcount.text =@"SEER";
    }else if ([model.ass_id isEqualToString:@"1.3.2"]){
         self.cellimageView.image =[UIImage imageNamed:@"account_pfc_iocn"];
         self.bizhongimageView.image =[UIImage imageNamed:@"account_pfc"];
         self.bizhongtextcount.text =@"PFC";
    }else if ([model.ass_id isEqualToString:@"1.3.5"]){
         self.cellimageView.image =[UIImage imageNamed:@"account_usdt_iocn"];
         self.bizhongimageView.image =[UIImage imageNamed:@"account_usdt"];
          self.bizhongtextcount.text =@"USDT";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
