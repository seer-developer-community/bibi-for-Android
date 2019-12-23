//
//  PredictTableViewCell.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/27.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "PredictTableViewCell.h"
#import "WBPopOverView.h"
@implementation PredictTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellId = @"SDChatTableViewCellId";
    PredictTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell =[[PredictTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
         
    }
    
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        [self setupUI];
    }
    return self;
}



-(UILabel *)touLabel{
    
    if (!_touLabel) {
        
        _touLabel = [[UILabel alloc]init];
        
        _touLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
        _touLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
        _touLabel.lineBreakMode  = NSLineBreakByTruncatingTail;
    }
    
    
    return _touLabel;
}

-(UILabel *)odds_numberLabel{
    
    if (!_odds_numberLabel) {
        
        _odds_numberLabel = [[UILabel alloc]init];
        _odds_numberLabel.text = @"(x0.0)";
        _odds_numberLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
        _odds_numberLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size: 9.3];
        _odds_numberLabel.lineBreakMode  = NSLineBreakByTruncatingTail;
    }
    
    
    return _odds_numberLabel;
}


-(UIButton *)promptBnt{
    
    if (!_promptBnt) {
        _promptBnt = [[UIButton alloc]init];
        [_promptBnt setBackgroundImage:[UIImage imageNamed:@"prompt_icon"] forState:UIControlStateNormal];
        
        [_promptBnt addTarget:self action:@selector(sayBut) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _promptBnt;
}

-(UIButton *)imageViewButon{
    if (!_imageViewButon) {
        _imageViewButon = [[UIButton alloc]init];
        [_imageViewButon setBackgroundImage:[UIImage imageNamed:@"duihua_icon"] forState:UIControlStateNormal];
//        [_imageViewButon setBackgroundColor:[UIColor redColor]];
        
    }
    
    return _imageViewButon;
}





-(UIImageView *)sureBntImageView{
    if (!_sureBntImageView) {
        _sureBntImageView = [[UIImageView alloc]init];
        _sureBntImageView.image = [UIImage imageNamed:NSLocalizedStringFromTable(@"surebuton",@"Internation", nil)];
        
    }
    
    return _sureBntImageView;
}

-(UIButton *)yuceBnt{
    if (!_yuceBnt) {
        _yuceBnt = [[UIButton alloc]init];
        NSString *PredictStr = NSLocalizedStringFromTable(@"Predict",@"Internation", nil);
        [_yuceBnt setTitle:PredictStr forState:UIControlStateNormal];
        [_yuceBnt setTitleColor:UIColorFromHexValue(0x2A7DDF) forState:UIControlStateNormal];
        [_yuceBnt setBackgroundImage:[UIImage imageNamed:@"Bnt_corners_icon"] forState:UIControlStateNormal];
        _yuceBnt.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
        [_yuceBnt addTarget:self action:@selector(clickCell) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yuceBnt;
}




-(void)setupUI{
    
    [self addSubview:self.touLabel];
    
    [self.touLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
//        make.width.mas_equalTo(150);
        make.centerY.mas_equalTo(0);
        
    }];
    
    [self addSubview:self.odds_numberLabel];
    
    [self.odds_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.touLabel.mas_right).offset(3);
        make.centerY.mas_equalTo(self.touLabel.mas_centerY);
    }];
    
    [self addSubview:self.promptBnt];
//    self.promptBnt.selected = NO;
    [self.promptBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.odds_numberLabel.mas_right).offset(3);
        make.centerY.mas_equalTo(self.odds_numberLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    [self addSubview:self.yuceBnt];
    
    [self.yuceBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.touLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(93, 33));
        
    }];
    
    
    
    
    [self addSubview:self.imageViewButon];
    [self.imageViewButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.promptBnt.mas_right).offset(10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(130, 78));
    }];
//    UIView *view19 = [[UIView alloc]init];
//    view19.frame = self.imageViewButon.frame;
//    view19.backgroundColor = [UIColor redColor];
//    [self addSubview:view19];
    UILabel *textLabel1 = [[UILabel alloc]init];
    textLabel1.text =NSLocalizedStringFromTable(@"PVDpeilv",@"Internation", nil);
    textLabel1.font =[UIFont fontWithName:@"PingFangSC-Regular" size: 7.3];
    textLabel1.numberOfLines = 0;
    self.textLabel1 = textLabel1;
    [self.imageViewButon addSubview:textLabel1];

    [textLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-8);
        make.left.mas_equalTo(12);
    }];
    
    self.imageViewButon.hidden = YES;
    
//    UIButton *button = [[UIButton alloc]init];
    
//    [button setTitle:@"预测" forState:UIControlStateNormal];
//    [button setTitleColor:UIColorFromHexValue(0x2A7DDF) forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"prebnt_icon"] forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
    
 
    
    
    [self addSubview:self.sureBntImageView];
    self.sureBntImageView.hidden = YES;
    [self.sureBntImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-24);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(CGSizeMake(74, 40));
        
    }];
    
}



//点击预测按钮
-(void)clickCell{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonPush:)]) {
        
        [self.delegate buttonPush:self];
        
    }
    
}



//点击赔率按钮

-(void)sayBut{
    [self.promptBnt setSelected:!self.promptBnt.isSelected];
    self.imageViewButon.hidden = YES;
    if (self.promptBnt.isSelected) {
       self.imageViewButon.hidden = NO;
    }
    
//    CGPoint point=CGPointMake(self.promptBnt.frame.origin.x+self.promptBnt.frame.size.width, self.promptBnt.frame.origin.y+self.promptBnt.frame.size.height/2);//箭头点的位置
//    WBPopOverView *view=[[WBPopOverView alloc]initWithOrigin:point Width:140 Height:50 Direction:WBArrowDirectionLeft1];//初始化弹出视图的箭头顶点位置point，展示视图的宽度Width，高度Height，Direction以及展示的方向
//    view.backgroundColor = [UIColor clearColor];
//    [self addSubview:view];
//    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
//    lable.text=@"测试内容";
//    lable.textColor=[UIColor greenColor];
//    [view.backView addSubview:lable];
//    [view popView];
    
}


@end
