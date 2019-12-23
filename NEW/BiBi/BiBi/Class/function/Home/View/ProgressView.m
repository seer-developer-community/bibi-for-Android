
//
//  ProgressView.m
//  BiBi
//
//  Created by 武建斌 on 2018/12/28.
//  Copyright © 2018 武建斌. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView ()
@property(nonatomic,strong)NSArray *arry;
@property(nonatomic,strong)NSArray *parry;
@property(nonatomic,assign)float total_shares;
@property(nonatomic,assign)float total_copies;

@end

@implementation ProgressView


-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
//        [self setupUI];
        
       
    }
    
    return self;
    
}









//-(void)setProgressCount:(NSInteger)progressCount{
//    
//    _progressCount = progressCount;
//    
//    
//    while (self.subviews.count) {
//        [self.subviews.lastObject removeFromSuperview];
//    }
//    
//    [self setupUI];
//    
//}

//竞猜文字
-(UILabel *)answerLabel{
    
    if (!_answerLabel) {
        
        _answerLabel  = [[UILabel alloc]init];
        
        [_answerLabel setText:@"测试这个数据"];
    }
    
    
    return _answerLabel;
}

// 进度条

-(UIProgressView *)progressView{
    
    if (!_progressView) {
        
        
        _progressView = [[UIProgressView alloc]init];
    }
    
    return _progressView;
}

-(UIView *)proAndlabelView{
    
    if (!_proAndlabelView) {
        
        _proAndlabelView = [[UIView alloc]init];
    }
    
    return _proAndlabelView;
}

- (void)setProgessDetail:(DetailsModel *)progessDetail {
    _progessDetail = progessDetail;
    
    if (_progessDetail.choseButcount) {
        
        if (_progessDetail.room_type == 1) {
            self.parry = [NSArray arrayWithArray:_progessDetail.proportion];
            
            self.arry = [NSArray arrayWithArray:_progessDetail.choseButcount];
        }
        
        if (_progessDetail.room_type ==2) {
            self.parry = [NSArray arrayWithArray:_progessDetail.total_participate];
            self.arry = [NSArray arrayWithArray:_progessDetail.choseButcount];
            
        }
        if (_progessDetail.room_type == 0) {
            self.arry = [NSArray arrayWithArray:_progessDetail.choseButcount];
            self.parry = [NSArray arrayWithArray:_progessDetail.items_countNum];
            for (NSInteger i = 0; i<_progessDetail.items_countNum.count; i++) {
                self.total_copies += [_progessDetail.items_countNum[i] floatValue];
            }
        }
        
        self.total_shares = progessDetail.total_shares;
        
        [self setupUI];
    }
}


-(void)setProgessOrderModel:(OrderModel *)progessOrderModel{
    _progessOrderModel = progessOrderModel;
    
    if (_progessOrderModel.choseButcount) {
        
        if (_progessOrderModel.room_type == 1) {
            self.parry = [NSArray arrayWithArray:_progessOrderModel.proportion];
            
            self.arry = [NSArray arrayWithArray:_progessOrderModel.choseButcount];
        }
        if (_progessOrderModel.room_type == 2) {
            self.parry = [NSArray arrayWithArray:_progessOrderModel.total_participate];
            
            self.arry = [NSArray arrayWithArray:_progessOrderModel.choseButcount];
            
        }
        if (_progessOrderModel.room_type == 0) {
            self.arry = [NSArray arrayWithArray:_progessOrderModel.choseButcount];
            self.parry = [NSArray arrayWithArray:_progessOrderModel.items_countNum];
            for (NSInteger i = 0; i<_progessOrderModel.items_countNum.count; i++) {
                self.total_copies += [_progessOrderModel.items_countNum[i] floatValue];
            }
        }

        
//        self.arry = [NSArray arrayWithArray:_progessOrderModel.choseButcount];
//        self.parry = [NSArray arrayWithArray:_progessOrderModel.proportion];
        self.total_shares = progessOrderModel.total_shares;
        
      
        
        [self setupUI];
    }
    
    
}


-(void)setupUI{
    
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
    CGFloat margin = 5;
    CGFloat h = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
     CGFloat btnhighd = (self.height-(self.arry.count *5))/self.arry.count;
    
    for (int i = 0; i<self.arry.count; i++) {
        UIView *proAndlabelView = [[UIView alloc]init];
        
        proAndlabelView.backgroundColor = [UIColor whiteColor];
        
        // 显示的投注选项
        UILabel *answerLabel = [[UILabel alloc]init];
        answerLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
        answerLabel.textColor = UIColorFromHexValue(0x444444);
         [answerLabel setText:self.arry[i]];
      
        [proAndlabelView addSubview:answerLabel];
        
        [answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(progressView.mas_centerY);
//            make.right.mas_equalTo(progressView.mas_left).offset(-37);
            make.left.mas_equalTo(proAndlabelView.mas_left).offset(5);
            make.top.mas_equalTo(5);
        }];
        
        
        UIProgressView *progressView = [[UIProgressView alloc]init];
        progressView.trackTintColor = [UIColor colorWithRed:42/255.0 green:125/255.0 blue:223/255.0 alpha:0.2];
        progressView.layer.borderWidth = 1;
        progressView.layer.borderColor = UIColorFromHexValue(0x2A7DDF).CGColor;
        progressView.layer.masksToBounds = YES;
        for (UIImageView * imageview in progressView.subviews) {
            imageview.layer.cornerRadius = 7;
            imageview.clipsToBounds = YES;
        }
        if (progressView.progress>1) {
            progressView.progress = 1;
        }
        if (self.progessDetail) {
            if (self.progessDetail.room_type == 1) {
                progressView.progress = [self.parry[i] floatValue]/self.total_shares;
                
            }
            if (self.progessDetail.room_type == 2) {
                progressView.progress = [[self.parry[i] firstObject] floatValue]/self.total_shares;
                
            }
            if (self.progessDetail.room_type == 0) {
                progressView.progress = [self.parry[i] floatValue]/self.total_copies;
            }
        }
        if (self.progessOrderModel) {
            if (self.progessOrderModel.room_type == 1) {
                progressView.progress = [self.parry[i] floatValue]/self.total_shares;
            }
            if (self.progessOrderModel.room_type == 2) {
                progressView.progress = [[self.parry[i] firstObject] floatValue]/self.total_shares;
            }
            if (self.progessOrderModel.room_type == 0) {
                 progressView.progress = [self.parry[i] floatValue]/self.total_copies;
            }
        }
       
       
       
        progressView.layer.cornerRadius = 7;
        progressView.progressTintColor = [UIColor colorWithRed:42/255.0 green:125/255.0 blue:223/255.0 alpha:1];
        [proAndlabelView addSubview:progressView];
        
        UILabel *prolabel = [[UILabel alloc]init];
        
        if (self.progessDetail) {
            if (self.progessDetail.room_type == 1) {
                if (self.total_shares == 0||[self.parry[i] integerValue] == 0) {
                    prolabel.text = @"0.0%";
                    progressView.progress = 0.0;
                }else{
                    prolabel.text =[NSString stringWithFormat:@"%.f %%",[self.parry[i] floatValue]/self.total_shares*100];
                    
                }
            }
            if (self.progessDetail.room_type == 2) {
                if (self.progessDetail.total_shares == 0||[[self.parry[i]firstObject] integerValue] == 0) {
                    prolabel.text = @"0.0%";
                    progressView.progress = 0.0;
                    
                }else{
                    prolabel.text =[NSString stringWithFormat:@"%.f %%",[[self.parry[i]firstObject] floatValue]/
                                    self.progessDetail.total_shares*100];
                    
                }
            }
            if (self.progessDetail.room_type == 0) {
                if (self.total_copies == 0|| [self.parry[i] integerValue] == 0) {
                    prolabel.text = @"0.0%";
                    progressView.progress = 0.0;
                }else{
                    
                    prolabel.text = [NSString stringWithFormat:@"%.f %%",
                                     [self.parry[i] floatValue]/self.total_copies*100];
                }
            }
        }
        if (self.progessOrderModel) {
            if (self.progessOrderModel.room_type == 1) {
                if (self.total_shares == 0||[self.parry[i] integerValue] == 0) {
                    prolabel.text = @"0.0%";
                    progressView.progress = 0.0;
                }else{
                    prolabel.text =[NSString stringWithFormat:@"%.f %%",[self.parry[i] floatValue]/self.total_shares*100];
                    
                }
            }
    
            if (self.progessOrderModel.room_type == 2) {
                if (self.progessOrderModel.total_shares == 0||[[self.parry[i]firstObject] integerValue] == 0) {
                    prolabel.text = @"0.0%";
                    progressView.progress = 0.0;
                    
                }else{
                    prolabel.text =[NSString stringWithFormat:@"%.f %%",[[self.parry[i]firstObject] floatValue]/
                                    self.progessOrderModel.total_shares*100];
                    
                }
            }
            if (self.progessOrderModel.room_type == 0) {
                if (self.total_copies == 0|| [self.parry[i] integerValue] == 0) {
                    prolabel.text = @"0.0%";
                    progressView.progress = 0.0;
                }else{
                    
                    prolabel.text = [NSString stringWithFormat:@"%.f %%",
                                     [self.parry[i] floatValue]/self.total_copies*100];
                }
            }
            
        }
       
        
        prolabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 12];
        prolabel.textColor = UIColorFromHexValue(0x444444);
        [progressView addSubview:prolabel];
        
        [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(proAndlabelView.mas_right).offset(-10);
            make.centerY.mas_equalTo(answerLabel.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(200, 15));
        }];
        
        [prolabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
        

        proAndlabelView.frame = CGRectMake(0, h, self.width,btnhighd);
        
        [self addSubview:proAndlabelView];
        h+=btnhighd;
        h+=margin;
    }
    
    [self layoutIfNeeded];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat btnhighd = (self.height-(self.arry.count *5))/self.arry.count;
    CGFloat margin = 5;
    CGFloat h = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    for (UIView * subV in self.subviews) {
        subV.frame = CGRectMake(0, h, self.width,btnhighd);
        
        h+=btnhighd;
        h+=margin;
        
    }
}






@end
