//
//  CZGuideCell.m
//  07- 网易彩票(项目准备)
//
//  Created by Apple on 16/3/28.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CZGuideCell.h"
//#import "CZMainTabController.h"
#import "JBMTabBarController.h"
@interface CZGuideCell ()

@property(nonatomic,weak)UIImageView *myImageView;

//懒加载按钮
@property(nonatomic,strong)UIButton *mustBtn;

@end

@implementation CZGuideCell

- (void)scrowWithIndexpath:(NSIndexPath *)indexpath withCount:(NSInteger )count
{
    
    //判断 最后一个
    if(indexpath.row == count - 1){
    
        self.mustBtn.hidden = NO;
    }else{
        
        self.mustBtn.hidden = YES;
    }

}
- (UIButton *)mustBtn
{
    if (!_mustBtn) {
        
        _mustBtn = [[UIButton alloc]init];
        [_mustBtn setBackgroundImage:[UIImage imageNamed:@"markwllt2_icon"] forState:UIControlStateNormal];
        [_mustBtn setTitle:NSLocalizedStringFromTable(@"Experience",@"Internation", nil)forState:UIControlStateNormal];
        
        [_mustBtn sizeToFit];
        
        
        //监听按钮的点击事件
        [_mustBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_mustBtn];
    }
    
    return _mustBtn;
}

//跳转到 第一个界面 tabVc
- (void)btnClick:(UIButton *)sender
{
    
    JBMTabBarController *vc = [[JBMTabBarController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = vc;

    

}

- (void)setGuideImage:(UIImage *)guideImage
{
    _guideImage = guideImage;
    
    
    self.myImageView.image = guideImage;
    

}

//创建一个 带 UIimageVIew的 cell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //创建一个 UIiamgeView
        
        UIImageView *imageVIew = [[UIImageView alloc]init];
        
        [self addSubview:imageVIew];
        
        //关联
        self.myImageView = imageVIew;
        
    }
    return self;
}

//设置frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.myImageView.frame = self.bounds;
    
    //设置按钮的frema
    self.mustBtn.top = kScreenHeight * 0.85;
    self.mustBtn.left = (kScreenWidth - self.mustBtn.width) * 0.5;
    
    
    
}
@end
