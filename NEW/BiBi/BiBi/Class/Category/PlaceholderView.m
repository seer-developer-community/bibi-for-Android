//
//  PlaceholderView.m
//  TableViewPlaceholder
//
//  Created by administrator on 2017/8/26.
//
//

#import "PlaceholderView.h"

@implementation PlaceholderView
{
    UIImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame onTapView:(TapBlock)onTapBlock
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.onTapBlock = onTapBlock;
        [self setupSubViews];
    }
    return self;
}
-(void)setupSubViews
{
    UIImageView *imageView =[[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeCenter;
    [imageView setImage:[UIImage imageNamed:@"talblview_icon"]];
    _imageView = imageView;
    [self addSubview:imageView];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapView:)]];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}
-(void)onTapView:(UITapGestureRecognizer *)recognizer
{
    if (self.onTapBlock) {
        self.onTapBlock();
    }
}
@end
